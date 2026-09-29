package com.lgcns.haibackend.util;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import com.lgcns.haibackend.global.Role;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;

class JwtProviderTest {

    private static final String SECRET = "test-secret-key-for-jwt-provider-0123456789";
    private static final String OTHER_SECRET = "other-secret-key-for-jwt-provider-0123456789";

    private JwtProvider jwtProvider;
    private final String userId = UUID.randomUUID().toString();

    @BeforeEach
    void setUp() {
        jwtProvider = new JwtProvider();
        ReflectionTestUtils.setField(jwtProvider, "secret", SECRET);
    }

    @Test
    void accessToken_parsesWithAccessType() {
        String token = jwtProvider.generateAccessToken(userId, Role.STUDENT);

        Claims claims = jwtProvider.parseAccessClaims(token);

        assertThat(claims.getSubject()).isEqualTo(userId);
        assertThat(claims.get("role", String.class)).isEqualTo("STUDENT");
        assertThat(claims.get(JwtProvider.CLAIM_TYPE, String.class)).isEqualTo(JwtProvider.TYPE_ACCESS);
    }

    @Test
    void refreshToken_isRejected() {
        String token = jwtProvider.generateRefreshToken(userId, Role.STUDENT);

        assertThatThrownBy(() -> jwtProvider.parseAccessClaims(token))
                .isInstanceOf(JwtException.class)
                .hasMessageContaining("Refresh token");
    }

    @Test
    void legacyTokenWithoutType_isTreatedAsAccess() {
        String token = sign(SECRET, new Date(System.currentTimeMillis() + 60_000));

        Claims claims = jwtProvider.parseAccessClaims(token);

        assertThat(claims.getSubject()).isEqualTo(userId);
        assertThat(claims.get(JwtProvider.CLAIM_TYPE)).isNull();
    }

    @Test
    void tokenSignedWithOtherKey_isRejected() {
        String token = sign(OTHER_SECRET, new Date(System.currentTimeMillis() + 60_000));

        assertThatThrownBy(() -> jwtProvider.parseAccessClaims(token))
                .isInstanceOf(SignatureException.class);
    }

    @Test
    void expiredToken_isRejected() {
        String token = sign(SECRET, new Date(System.currentTimeMillis() - 1_000));

        assertThatThrownBy(() -> jwtProvider.parseAccessClaims(token))
                .isInstanceOf(ExpiredJwtException.class);
    }

    @Test
    void existingAccessors_stillWork() {
        String token = jwtProvider.generateAccessToken(userId, Role.TEACHER);

        assertThat(jwtProvider.getUserIdFromToken(token)).isEqualTo(userId);
        assertThat(jwtProvider.getRoleFromToken(token)).isEqualTo("TEACHER");
    }

    // type claim 없이 서명한 토큰 (기존 발급 형식)
    private String sign(String secret, Date expiration) {
        return Jwts.builder()
                .setSubject(userId)
                .claim("role", "STUDENT")
                .setExpiration(expiration)
                .signWith(Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8)))
                .compact();
    }
}
