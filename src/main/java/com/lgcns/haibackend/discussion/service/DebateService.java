package com.lgcns.haibackend.discussion.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.common.security.AuthUtils;
import com.lgcns.haibackend.discussion.domain.dto.ChatMessage;
import com.lgcns.haibackend.discussion.domain.dto.DebateRoomRequestDTO;
import com.lgcns.haibackend.discussion.domain.dto.DebateRoomResponseDTO;
import com.lgcns.haibackend.discussion.domain.dto.DebateStatus;
import com.lgcns.haibackend.discussion.domain.entity.DebateRoomEntity;
import com.lgcns.haibackend.discussion.repository.DebateRoomRepository;
import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.user.domain.entity.UserClassInfo;
import com.lgcns.haibackend.user.domain.entity.UserEntity;
import com.lgcns.haibackend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;

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

@Service
@RequiredArgsConstructor
public class DebateService {

    private final DebateRoomRepository debateRoomRepository;

    private final UserRepository userRepository;
    private final RedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;

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
                "Class information required"
            );
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
        redisTemplate.opsForHash().put(key, userId.toString(), status.name());
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

}
