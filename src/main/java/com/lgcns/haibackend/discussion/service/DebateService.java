package com.lgcns.haibackend.discussion.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.common.security.AuthUtils;
import com.lgcns.haibackend.discussion.domain.dto.ChatMessage;
import com.lgcns.haibackend.discussion.domain.dto.DebateRoomRequestDTO;
import com.lgcns.haibackend.discussion.domain.dto.DebateRoomResponseDTO;
import com.lgcns.haibackend.discussion.domain.dto.DebateStatus;
import com.lgcns.haibackend.discussion.domain.dto.DebateTopicsRequest;
import com.lgcns.haibackend.discussion.domain.dto.DebateTopicsResponse;
import com.lgcns.haibackend.discussion.domain.entity.DebateRoomEntity;
import com.lgcns.haibackend.discussion.repository.DebateRoomRepository;
import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.discussion.domain.dto.DebateSummaryResponse;
import com.lgcns.haibackend.user.domain.entity.UserClassInfo;
import com.lgcns.haibackend.user.domain.entity.UserEntity;
import com.lgcns.haibackend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
public class DebateService {

    @Value("${aws.bedrock.prompt.debate-topic}")
    private String debateTopicPromptId;

    @Value("${aws.bedrock.prompt.debate-summary}")
    private String debateSummaryPromptId;

    private final DebateRoomRepository debateRoomRepository;

    private final UserRepository userRepository;
    private final RedisTemplate<String, String> redisTemplate;
    private final com.lgcns.haibackend.bedrock.client.FastApiClient fastApiClient;
    private final ObjectMapper objectMapper;
    private final Map<UUID, DebateRoomRequestDTO> activeRooms = new ConcurrentHashMap<>();

    public boolean isTeacher(UUID userId) {
        UserEntity user = userRepository.findByUserId(userId)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.UNAUTHORIZED,
                        "User not found: " + userId));

        return user.getRole() == Role.TEACHER;
    }

    public void validateTeacher(UUID userId) {
        if (!isTeacher(userId)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "선생님만 접근할 수 있습니다.");
        }
    }

    @Transactional
    public DebateRoomResponseDTO createRoom(DebateRoomRequestDTO req, Authentication auth) {

        UUID userId = AuthUtils.getUserId(auth);
        validateTeacher(userId);

        UserEntity teacher = userRepository.findByUserId(userId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found"));

        DebateRoomEntity room = new DebateRoomEntity();
        room.setTeacher(teacher);
        room.setParticipantCount(req.getParticipantCount());
        room.setTopicTitle(req.getTopicTitle());
        room.setTopicDescription(req.getTopicDescription());
        room.setGrade(req.getGrade());
        room.setClassroom(req.getClassroom());

        DebateRoomEntity saved = debateRoomRepository.save(room);

        return DebateRoomResponseDTO.fromEntity(saved);
    }

    @Transactional
    public void deleteRoom(UUID roomId, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required");
        }

        DebateRoomEntity room = debateRoomRepository.findById(roomId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Room not found"));

        UUID currentUserId = AuthUtils.getUserId(auth);
        if (!room.getTeacher().getUserId().equals(currentUserId)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "방을 생성한 선생님만 삭제할 수 있습니다.");
        }
        Integer teacherCode = room.getTeacherCode();
        debateRoomRepository.delete(room);

        String roomIdStr = roomId.toString();
        redisTemplate.delete("debate:room:" + roomIdStr + ":messages");
        redisTemplate.delete("debate:room:" + roomIdStr + ":status");

        if (teacherCode != null) {
            String teacherCodeIndexKey = "debate:teacherCode:" + teacherCode + ":rooms";
            redisTemplate.opsForZSet().remove(teacherCodeIndexKey, roomIdStr);
        }
    }

    @Transactional(readOnly = true)
    public List<DebateRoomResponseDTO> getRoomsByClassCode(Authentication auth) {

        if (auth == null || !auth.isAuthenticated()) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required");
        }

        UUID userId = AuthUtils.getUserId(auth);

        UserEntity user = userRepository.findByUserId(userId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found"));

        Integer teacherCode = user.getTeacherCode();
        if (teacherCode == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "No teacher code");
        }

        boolean isTeacher = (user.getRole() == Role.TEACHER);

        List<DebateRoomEntity> rooms;

        if (isTeacher) {
            rooms = debateRoomRepository.findByTeacherCodeOrderByCreatedAtDesc(teacherCode);
        } else {
            UserClassInfo userInfo = userRepository.findClassInfoByUserId(userId);
            if (userInfo == null || userInfo.getGrade() == null) {
                throw new ResponseStatusException(HttpStatus.FORBIDDEN, "No grade info");
            }
            Integer grade = userInfo.getGrade();
            rooms = debateRoomRepository.findByTeacherCodeAndGradeOrderByCreatedAtDesc(teacherCode, grade);
        }

        if (rooms == null || rooms.isEmpty()) {
            return List.of();
        }

        return rooms.stream()
                .map(DebateRoomResponseDTO::fromEntity)
                .toList();
    }

    public List<ChatMessage> getMessages(UUID roomId, int page, int size) {
        if (!debateRoomRepository.existsById(roomId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "room not found");
        }

        String key = "debate:room:" + roomId.toString() + ":messages";
        int p = Math.max(0, page);
        int s = Math.max(1, Math.min(size, 200));

        Long totalLong = redisTemplate.opsForList().size(key);
        long total = (totalLong == null) ? 0 : totalLong;
        if (total == 0)
            return List.of();

        long end = total - 1 - ((long) p * s);
        long start = Math.max(0, end - (s - 1));
        if (end < 0)
            return List.of();

        List<String> jsonList = redisTemplate.opsForList().range(key, start, end);
        if (jsonList == null || jsonList.isEmpty())
            return List.of();

        List<ChatMessage> result = new ArrayList<>(jsonList.size());
        for (String json : jsonList) {
            try {
                result.add(objectMapper.readValue(json, ChatMessage.class));
            } catch (Exception ignored) {
            }
        }

        Collections.reverse(result);
        return result;
    }

    public DebateRoomRequestDTO getRoom(String roomId) {
        return activeRooms.get(roomId);
    }

    @Transactional(readOnly = true)
    public void validateJoin(String roomId, UUID userId) {

        UUID roomUuid;
        try {
            roomUuid = UUID.fromString(roomId);
        } catch (IllegalArgumentException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid roomId");
        }

        DebateRoomEntity room = debateRoomRepository.findById(roomUuid)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Room not found"));

        Integer roomTeacherCode = room.getTeacherCode();
        Integer roomGrade = room.getGrade();
        Integer roomClassroom = room.getClassroom();

        if (roomTeacherCode == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Room not found");
        }

        UserClassInfo userInfo = userRepository.findClassInfoByUserId(userId);
        if (userInfo == null) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN,
                    "Class information required");
        }

        if (userInfo.getTeacherCode() == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "No teacher code");
        }

        if (!roomTeacherCode.equals(userInfo.getTeacherCode())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not in this class");
        }

        boolean isTeacher = isTeacher(userId);

        if (!isTeacher) {
            if (roomGrade != null) {
                if (userInfo.getGrade() == null || !roomGrade.equals(userInfo.getGrade())) {
                    throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Grade mismatch");
                }
            }
            if (roomClassroom != null) {
                if (userInfo.getClassroom() == null || !roomClassroom.equals(userInfo.getClassroom())) {
                    throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Classroom mismatch");
                }
            }
        }
    }

    public String getNickName(UUID userId) {
        return userRepository.findNickNameByUserId(userId);
    }

    public void saveStatus(String roomId, UUID userId, DebateStatus status) {
        String key = "debate:room:" + roomId + ":status";
        if (status == DebateStatus.CANCEL) {
            redisTemplate.opsForHash().delete(key, userId.toString());
        } else {
            redisTemplate.opsForHash().put(key, userId.toString(), status.name());
        }
    }

    public DebateStatus requireStatusSelected(String roomId, UUID userId, SimpMessageHeaderAccessor headerAccessor) {
        // 세션에 있으면 우선 사용
        Map<String, Object> session = headerAccessor.getSessionAttributes();
        if (session != null && session.get("status") != null) {
            return DebateStatus.valueOf(session.get("status").toString());
        }

        // Redis에서 확인
        String key = "debate:room:" + roomId + ":status";
        Object v = redisTemplate.opsForHash().get(key, userId.toString());
        if (v == null) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Select PRO/CON first");
        }
        return DebateStatus.valueOf(v.toString());
    }

    public void updateRoomMode(String roomId, String viewMode) {
        String roomKey = "debate:room:" + roomId;
        redisTemplate.opsForHash().put(roomKey, "viewMode", viewMode);
    }

    public String resolveNickname(UUID userId, SimpMessageHeaderAccessor headerAccessor) {
        Map<String, Object> session = headerAccessor.getSessionAttributes();
        if (session != null && session.get("sender") != null) {
            return session.get("sender").toString();
        }
        String nickname = getNickName(userId);
        return nickname != null ? nickname : "unknown";
    }

    public List<ChatMessage> getMessages(UUID roomId) {

        if (!debateRoomRepository.existsById(roomId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "room not found");
        }

        String key = "debate:room:" + roomId + ":messages";
        List<String> rawMessages = redisTemplate.opsForList().range(key, 0, -1);

        List<ChatMessage> messages = new ArrayList<>();
        if (rawMessages != null) {
            for (String json : rawMessages) {
                try {
                    messages.add(objectMapper.readValue(json, ChatMessage.class));
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
            }
        }
        return messages;
    }

    public void appendMessage(UUID roomId, ChatMessage msg) {

        if (!debateRoomRepository.existsById(roomId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "room not found");
        }
        String key = "debate:room:" + roomId.toString() + ":messages";
        try {
            String json = objectMapper.writeValueAsString(msg);
            redisTemplate.opsForList().rightPush(key, json);
            // redisTemplate.opsForList().trim(key, -200, -1);
        } catch (JsonProcessingException e) {
            throw new IllegalStateException("Failed to serialize ChatMessage", e);
        }
    }

    /**
     * 토론 주제 추천 받기
     * AWS Bedrock Prompt를 통해 한국 역사 토론 주제 3개를 추천받습니다.
     */
    public DebateTopicsResponse getDebateTopicRecommendations(DebateTopicsRequest request) {
        // 1. PromptRequest 생성
        com.lgcns.haibackend.aiPerson.domain.dto.PromptRequest promptRequest = com.lgcns.haibackend.aiPerson.domain.dto.PromptRequest
                .builder()
                .promptId(debateTopicPromptId)
                .userQuery(request.getUserQuery())
                .build();

        // 2. FastAPI를 통해 스트리밍 응답 받기
        String completeResponse = fastApiClient.chatPromptStream(promptRequest)
                .collectList()
                .map(chunks -> String.join("", chunks))
                .block();

        if (completeResponse == null || completeResponse.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "AI 응답을 받지 못했습니다.");
        }

        // 🔍 디버깅: 완전한 응답 출력
        System.out.println("=== COMPLETE RESPONSE ===");
        System.out.println(completeResponse);
        System.out.println("=== END RESPONSE ===");

        // 3. JSON 파싱하여 DebateTopicsResponse 변환
        try {
            DebateTopicsResponse response = objectMapper.readValue(completeResponse, DebateTopicsResponse.class);
            return response;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "AI 응답을 파싱하는 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    public DebateSummaryResponse getDebateAnalysis(UUID roomId) {
        // 1. 채팅 내역 가져오기
        List<ChatMessage> messages = getMessages(roomId);
        System.err.println("messages !!!!!!: " + messages);
        if (messages == null || messages.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "분석할 대화 내용이 없습니다.");
        }

        // 2. 대화 내용 포맷팅
        StringBuilder sb = new StringBuilder();
        for (ChatMessage msg : messages) {
            // 시스템 메시지(접두사 "__")는 분석에서 제외
            if (msg.getContent() != null && msg.getContent().startsWith("__")) {
                continue;
            }
            if (msg.getType() == ChatMessage.MessageType.CHAT) {
                String status = msg.getStatus() != null ? msg.getStatus().name() : "NONE";
                sb.append(String.format("[%s (%s)]: %s\n", msg.getSender(), status, msg.getContent()));
            }
        }
        String chatHistory = sb.toString();

        if (chatHistory.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "분석할 대화 내용이 없습니다 (채팅 메시지 없음).");
        }

        // 3. PromptRequest 생성
        com.lgcns.haibackend.aiPerson.domain.dto.PromptRequest promptRequest = com.lgcns.haibackend.aiPerson.domain.dto.PromptRequest
                .builder()
                .promptId(debateSummaryPromptId)
                .userQuery(chatHistory)
                .build();

        // 4. AI 응답 받기
        String completeResponse = fastApiClient.chatPromptStream(promptRequest)
                .collectList()
                .map(chunks -> String.join("", chunks))
                .block();

        System.out.println("=== SUMMARY RESPONSE ===");
        System.out.println(completeResponse);
        System.out.println("=== END RESPONSE ===");

        if (completeResponse == null || completeResponse.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "AI 분석 응답을 받지 못했습니다.");
        }

        // 4.1. 응답 전처리 (마크다운 코드 블록 제거 및 JSON 추출)
        String jsonResponse = completeResponse;
        if (jsonResponse.contains("```")) {
            jsonResponse = jsonResponse.replace("```json", "").replace("```", "");
        }

        int start = jsonResponse.indexOf("{");
        int end = jsonResponse.lastIndexOf("}");
        if (start != -1 && end != -1 && start < end) {
            jsonResponse = jsonResponse.substring(start, end + 1);
        } else {
            jsonResponse = jsonResponse.trim();
        }

        // 5. JSON 파싱
        try {
            return objectMapper.readValue(jsonResponse,
                    com.lgcns.haibackend.discussion.domain.dto.DebateSummaryResponse.class);
        } catch (Exception e) {
            System.err.println("JSON Parse Error. Raw: " + completeResponse);
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "AI 응답 파싱 실패: " + e.getMessage());
        }
    }

}
