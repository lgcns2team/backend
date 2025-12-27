package com.lgcns.haibackend.user.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.common.redis.RedisChatRepository;
import com.lgcns.haibackend.user.domain.dto.UserRequestDTO;
import com.lgcns.haibackend.user.domain.dto.UserResponseDTO;
import com.lgcns.haibackend.user.repository.RefreshTokenRepository;
import com.lgcns.haibackend.user.service.UserService;
import com.lgcns.haibackend.util.JwtProvider;

import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@SecurityScheme(name = "bearerAuth", type = SecuritySchemeType.HTTP, scheme = "bearer", bearerFormat = "JWT")
@RestController
@RequestMapping("/auth/api/user")
@RequiredArgsConstructor
public class AuthUserController {
    // JWT 필요 -> 로그아웃, 회원정보 수정
    @Autowired
    private UserService userService;

    @Autowired
    private JwtProvider jwtProvider;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    private final RedisChatRepository redisChatRepository;

    @SecurityRequirement(name = "bearerAuth")
    @PutMapping("/update/{id}")
    public ResponseEntity<UserResponseDTO> update(@RequestBody UserRequestDTO request,
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        System.out.println(">>>> user ctrl PUT /update");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        String token = authHeader.substring(7);
        String userIdStr = jwtProvider.getUserIdFromToken(token);
        UUID userId = null; // UUID 객체를 선언합니다.

        try {
            userId = UUID.fromString(userIdStr);
        } catch (IllegalArgumentException e) {
            // 토큰에 담긴 UUID 문자열이 유효하지 않을 경우
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        UserResponseDTO response = userService.update(userId, request);
        return ResponseEntity.ok(response);
    }

    @SecurityRequirement(name = "bearerAuth")
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(Authentication auth) {
        UUID userId = UUID.fromString(auth.getPrincipal().toString());

        refreshTokenRepository.delete(userId);
        redisChatRepository.deleteAllAIPersonChats(userId);
        redisChatRepository.deleteAllChatbotChats(userId);

        System.out.println(">>>> Refresh token deleted for user: " + userId);
        return ResponseEntity.ok().build();
    }

    @SecurityRequirement(name = "bearerAuth")
    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteUser(Authentication auth) {
        UUID userId = UUID.fromString(auth.getPrincipal().toString());

        refreshTokenRepository.delete(userId);
        redisChatRepository.deleteAllAIPersonChats(userId);
        redisChatRepository.deleteAllChatbotChats(userId);

        userService.deleteUser(userId);
        return ResponseEntity.ok("회원 탈퇴가 완료되었습니다.");
    }

    @SecurityRequirement(name = "bearerAuth")
    @GetMapping("/teacher-code")
    public ResponseEntity<Integer> getTeacherCode() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    
        try {
            // 토큰의 sub(UUID)를 가져와서 서비스 호출
            UUID userId = UUID.fromString(auth.getName());
            Integer teacherCode = userService.getTeacherCodeByUserId(userId);

            return ResponseEntity.ok(teacherCode);

        } catch (IllegalArgumentException e) {
            // UUID 형식이 아닐 경우
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        } catch (RuntimeException e) {
            // 사용자가 없거나 선생님이 아닐 경우 (위 서비스에서 던진 에러)
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

    }
}
