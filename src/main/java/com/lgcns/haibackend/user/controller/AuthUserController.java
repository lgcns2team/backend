package com.lgcns.haibackend.user.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.user.domain.dto.UserRequestDTO;
import com.lgcns.haibackend.user.domain.dto.UserResponseDTO;
import com.lgcns.haibackend.user.repository.AIChatHistoryRepository;
import com.lgcns.haibackend.user.repository.RefreshTokenRepository;
import com.lgcns.haibackend.user.service.UserService;
import com.lgcns.haibackend.util.JwtProvider;

import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@SecurityScheme(name = "bearerAuth", type = SecuritySchemeType.HTTP, scheme = "bearer", bearerFormat = "JWT")
@RestController
@RequestMapping("/auth/api/user")
public class AuthUserController {
    // JWT 필요 -> 로그아웃, 회원정보 수정
    @Autowired
    private UserService userService;

    @Autowired
    private JwtProvider jwtProvider;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private AIChatHistoryRepository aiChatHistoryRepository;

    @SecurityRequirement(name = "bearerAuth")
    @PutMapping("/updateUser/{id}")
    public ResponseEntity<UserResponseDTO> update(@RequestBody UserRequestDTO request,
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        System.out.println(">>>> user ctrl PUT /updateUser");

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
    public ResponseEntity<Void> logout(@RequestHeader(value = "Authorization", required = false) String authHeader,
            HttpServletRequest request) {

        System.out.println(">>>> user ctrl POST /logout");
        System.out.println(">>>> Authorization: " + authHeader);

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String token = authHeader.substring(7);
        String userIdStr = jwtProvider.getUserIdFromToken(token);

        UUID userId = null;
        try {
            userId = UUID.fromString(userIdStr);
        } catch (IllegalArgumentException e) {
            // 토큰에 잘못된 형식의 UUID가 담겨있을 경우 (보안 이슈 또는 오류)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        refreshTokenRepository.delete(userId);
        aiChatHistoryRepository.deleteHistory(userId);

        System.out.println(">>>> Refresh token deleted for user: " + userId);
        return ResponseEntity.ok().build();
    }

    @SecurityRequirement(name = "bearerAuth")
    @DeleteMapping("/delete/{userId}")
    public ResponseEntity<String> deleteUser(@PathVariable("userId") UUID userId, @RequestHeader(value = "Authorization", required = false) String authHeader){
        
        if(authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String token = authHeader.substring(7);
        userService.deleteUser(userId);
        return ResponseEntity.ok("회원 탈퇴가 완료되었습니다.");
    }
}
