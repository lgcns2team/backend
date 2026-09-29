package com.lgcns.haibackend.util;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.lgcns.haibackend.global.Role;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtProvider {

    // Access Token 만료 시간 (1시간)
    private static final long ACCESS_TOKEN_EXPIRATION_MS = 1000 * 60 * 60; 
    // Refresh Token 만료 시간 (7일)
    private static final long REFRESH_TOKEN_EXPIRATION_MS = 1000 * 60 * 60 * 24 * 7;

    // 토큰 종류 구분 claim (access / refresh)
    public static final String CLAIM_TYPE = "type";
    public static final String TYPE_ACCESS = "access";
    public static final String TYPE_REFRESH = "refresh";

    @Value("${jwt.secret}")
    private String secret;

    private Key getStringKey() {

        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public String generateAccessToken(String userIdStr, Role role) {
        System.out.println("[debug] >>> JwtProvider generateAccessToken");
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + ACCESS_TOKEN_EXPIRATION_MS);
        
        return Jwts.builder()
                .setSubject(userIdStr)
                .claim("role", role)
                .claim(CLAIM_TYPE, TYPE_ACCESS)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(getStringKey())
                .compact();

    }

    public String generateRefreshToken(String userIdStr, Role role) {
        System.out.println("[debug] >>> JwtProvider generateRefreshToken");
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + REFRESH_TOKEN_EXPIRATION_MS);
        
        return Jwts.builder()
                .setSubject(userIdStr)
                .claim("role", role)
                .claim(CLAIM_TYPE, TYPE_REFRESH)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(getStringKey())
                .compact();
    }
    // [추가] RefreshTokenRepository에서 TTL (Time-To-Live)을 설정하기 위한 메서드
    public long getRefreshExpirationMs() {
        return REFRESH_TOKEN_EXPIRATION_MS;
    }

    public String getUserIdFromToken(String token) {
        return parseClaims(token).getSubject();
    }

    // [추가] role을 추출하는 메서드입니다.
    public String getRoleFromToken(String token) {
        return parseClaims(token).get("role", String.class);
    }

    // 서명·만료 검증 후 access 토큰의 claims 반환 (refresh 토큰은 거부)
    // type claim이 없는 기존 토큰은 access로 간주
    public Claims parseAccessClaims(String token) {
        Claims claims = parseClaims(token);
        if (TYPE_REFRESH.equals(claims.get(CLAIM_TYPE, String.class))) {
            throw new JwtException("Refresh token is not allowed");
        }
        return claims;
    }

    private Claims parseClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getStringKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    // 토큰 유효성 검사 메서드 (RefreshToken 재발급 로직에 필요)
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(getStringKey()).build().parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            // 토큰 만료, 위변조 등 예외 처리 (여기서는 단순히 false 반환)
            System.err.println("JWT Token Validation Error: " + e.getMessage());
            return false;
        }
    }
}
