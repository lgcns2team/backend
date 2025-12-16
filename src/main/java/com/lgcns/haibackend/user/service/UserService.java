package com.lgcns.haibackend.user.service;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Service;

import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.user.domain.dto.UserRequestDTO;
import com.lgcns.haibackend.user.domain.dto.UserResponseDTO;
import com.lgcns.haibackend.user.domain.entity.UserEntity;
import com.lgcns.haibackend.user.repository.RefreshTokenRepository;
import com.lgcns.haibackend.user.repository.UserRepository;
import com.lgcns.haibackend.util.JwtProvider;

import jakarta.transaction.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JwtProvider provider;
    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    public UserResponseDTO signup(UserRequestDTO request) {
        System.out.println(">>> service signup");
        Integer classCode = null;
        Integer generatedCode = null;

        if (request.getRole() == Role.TEACHER) {
            // 1. 선생님: 새로운 반 코드 생성 (6자리 숫자)
            
            // 6자리 랜덤 숫자 생성 로직 (100000 ~ 999999 사이)
            do {
                // [주의] 이 코드가 실제 운영 환경에서 고유성을 보장하려면, 
                // 충분히 많은 코드를 생성하고 충돌 가능성을 줄여야 합니다.
                generatedCode = (int) (Math.random() * 900000) + 100000;
                
                // 생성된 코드가 이미 다른 선생님에 의해 사용 중인지 DB에서 확인
            } while (userRepository.existsByClassCodeAndRole(generatedCode, Role.TEACHER));
            
            classCode = generatedCode;
            
        } else if (request.getRole() == Role.STUDENT) {
            // 2. 학생: joinCode 필수 검증 로직!
            
            // DTO에서 학생이 입력한 코드 (Integer 타입)를 가져옵니다.
            Integer joinCode = request.getClassCode(); 

            if (joinCode == null || joinCode < 100000 || joinCode > 999999) {
                throw new IllegalArgumentException("학생은 유효한 6자리 반 초대 코드를 입력해야 합니다.");
            }
            
            // 해당 코드를 가진 선생님(반)이 존재하는지 DB에서 확인
            // (findBy 대신 existsBy를 사용해 성능 최적화)
            boolean codeExists = userRepository.existsByClassCodeAndRole(joinCode, Role.TEACHER);

            if (!codeExists) {
                throw new RuntimeException("유효하지 않거나 존재하지 않는 반 코드입니다.");
            }
            
            classCode = joinCode; // 학생에게 classCode 부여
            
        }
        UserEntity entity = userRepository.save(request.toEntity());
        System.out.println(">>> after save: " + entity);

        UserResponseDTO dto = UserResponseDTO.fromEntity(entity);
        if (entity.getRole() == Role.TEACHER && entity.getClassCode() != null) {
            dto.setCreatedClassCode(entity.getClassCode().toString());
        }
        System.out.println(">>> response dto: " + dto);


        return dto;
    }

    public Map<String, Object> login(UserRequestDTO request) {
        System.out.println(">>> service login");
        UserEntity entity = userRepository.findByNicknameAndPassword(request.getNickname(), request.getPassword())
                .orElseThrow(() -> new RuntimeException("닉네임 또는 비밀번호가 일치하지 않습니다."));

        String userIdStr = entity.getUserId().toString();
        Role role = entity.getRole();

        String accToken = provider.generateAccessToken(userIdStr, role);
        String refToken = provider.generateRefreshToken(userIdStr, role);

        refreshTokenRepository.save(entity.getUserId(), refToken, provider.getRefreshExpirationMs());
        UserResponseDTO response = UserResponseDTO.fromEntity(entity);

        Map<String, Object> map = new HashMap<>();
        map.put("response", response);
        map.put("access", accToken);
        map.put("refresh", refToken);
        return map;

    }
    @Transactional
    public UserResponseDTO update(UUID userId, UserRequestDTO request) {
        System.out.println(">>> service updateUser");

        UserEntity user = userRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("유저 없음"));
        // 1. 이름 (name) 업데이트
    if (request.getName() != null) {
        user.setName(request.getName()); 
    }
    
    // 2. 닉네임 (nickname) 업데이트
    if (request.getNickname() != null) {
        user.setNickname(request.getNickname());
    }
    
    // 3. 비밀번호 (password/passwd) 업데이트
    if (request.getPassword() != null) { // 또는 getPasswd()
        // [필수] 실제 구현 시 여기에 BCryptPasswordEncoder.encode() 적용 필요
        user.setPassword(request.getPassword()); // 또는 setPasswd()
    }

    // 4. 학년 (grade) 업데이트 (0은 유효한 값일 수 있으므로 null 체크 대신 필요에 따라 0 초과 체크)
    if (request.getGrade() != null && request.getGrade() > 0) { 
        user.setGrade(request.getGrade());
    }

    // 5. 반 (classroom) 업데이트
    if (request.getClassroom() != null && request.getClassroom() > 0) {
        user.setClassroom(request.getClassroom());
    }
    
    // 6. 역할 (role) 업데이트
    if (request.getRole() != null) {
        user.setRole(request.getRole());
    }

    // 로그 출력
    System.out.println("update success/ name: " + user.getName() + ", nickname: " + user.getNickname());

    UserEntity updated = userRepository.save(user);

        return UserResponseDTO.fromEntity(updated);
    }

    @Transactional
    public void deleteUser(UUID userId) {
        UserEntity user = userRepository.findByUserId(userId)
                    .orElseThrow( () -> new RuntimeException("사용자를 찾을 수 없습니다."));
        userRepository.delete(user);
    }
}
