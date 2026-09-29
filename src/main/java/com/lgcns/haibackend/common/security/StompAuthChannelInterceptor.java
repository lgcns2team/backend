package com.lgcns.haibackend.common.security;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.lgcns.haibackend.util.JwtProvider;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;

/**
 * STOMP 인바운드 채널 인증·인가 (기본 거부).
 * - CONNECT/STOMP: JWT(access) 검증 후 Principal 설정. 실패 시 예외 → ERROR 프레임, 연결 종료
 * - SUBSCRIBE: 사용자 큐 또는 SubscriptionAuthorizer가 허용한 목적지만 구독 가능
 * - SEND: 애플리케이션 목적지(/app/**)만 허용 (브로커 직접 전송 차단)
 * CONNECT 이후 프레임의 Principal은 Spring이 세션 단위로 유지한다.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class StompAuthChannelInterceptor implements ChannelInterceptor {

    // HandshakeInterceptor가 쿼리 파라미터 토큰을 저장하는 세션 속성 키
    public static final String HANDSHAKE_TOKEN_ATTR = "token";

    private static final String BEARER_PREFIX = "bearer ";
    private static final String APP_DESTINATION_PREFIX = "/app/";
    private static final String USER_QUEUE_PREFIX = "/user/queue/";

    private final JwtProvider jwtProvider;
    private final List<SubscriptionAuthorizer> subscriptionAuthorizers;

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor =
                MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

        if (accessor == null || accessor.getCommand() == null) {
            return message; // heartbeat 등
        }

        switch (accessor.getCommand()) {
            case CONNECT, STOMP -> authenticate(accessor);
            case SUBSCRIBE -> authorizeSubscribe(accessor);
            case SEND -> authorizeSend(accessor);
            default -> {
                // UNSUBSCRIBE, DISCONNECT, ACK 등은 통과
            }
        }
        return message;
    }

    private void authenticate(StompHeaderAccessor accessor) {
        String token = resolveToken(accessor);
        if (token == null) {
            log.warn("STOMP CONNECT rejected: no token (sessionId={})", accessor.getSessionId());
            throw new AccessDeniedException("Authentication required");
        }

        Claims claims;
        try {
            claims = jwtProvider.parseAccessClaims(token);
        } catch (JwtException | IllegalArgumentException e) {
            log.warn("STOMP CONNECT rejected: {} (sessionId={})",
                    e.getClass().getSimpleName(), accessor.getSessionId());
            throw new AccessDeniedException("Invalid token");
        }

        String userId = claims.getSubject();
        String role = claims.get("role", String.class);
        if (!isUuid(userId) || role == null) {
            log.warn("STOMP CONNECT rejected: invalid claims (sessionId={})", accessor.getSessionId());
            throw new AccessDeniedException("Invalid token");
        }

        accessor.setUser(new UsernamePasswordAuthenticationToken(
                userId,
                null,
                List.of(new SimpleGrantedAuthority("ROLE_" + role))));

        log.debug("STOMP CONNECT: userId={}, sessionId={}", userId, accessor.getSessionId());
    }

    private static boolean isUuid(String value) {
        if (value == null) {
            return false;
        }
        try {
            UUID.fromString(value);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    // Authorization 헤더 우선, 없으면 handshake 쿼리 토큰 사용 (사용 후 세션에서 제거)
    private String resolveToken(StompHeaderAccessor accessor) {
        Map<String, Object> session = accessor.getSessionAttributes();
        Object handshakeToken = session != null ? session.remove(HANDSHAKE_TOKEN_ATTR) : null;

        String header = accessor.getFirstNativeHeader("Authorization");
        if (header == null) {
            header = accessor.getFirstNativeHeader("authorization");
        }
        if (header != null && header.regionMatches(true, 0, BEARER_PREFIX, 0, BEARER_PREFIX.length())) {
            String token = header.substring(BEARER_PREFIX.length()).trim();
            if (!token.isEmpty()) {
                return token;
            }
        }

        if (handshakeToken != null && !handshakeToken.toString().isBlank()) {
            return handshakeToken.toString();
        }
        return null;
    }

    private void authorizeSubscribe(StompHeaderAccessor accessor) {
        UUID userId = requireUserId(accessor);
        String destination = requireDestination(accessor);

        if (destination.startsWith(USER_QUEUE_PREFIX)) {
            return; // 사용자 큐는 본인 세션에만 전달됨
        }

        SubscriptionAuthorizer authorizer = subscriptionAuthorizers.stream()
                .filter(a -> a.supports(destination))
                .findFirst()
                .orElseThrow(() -> deny(accessor, "no authorizer for " + destination));

        try {
            authorizer.authorize(destination, userId);
        } catch (AccessDeniedException e) {
            log.warn("STOMP SUBSCRIBE rejected: destination={}, userId={}", destination, userId);
            throw e;
        }
    }

    private void authorizeSend(StompHeaderAccessor accessor) {
        requireUserId(accessor);
        String destination = requireDestination(accessor);

        if (!destination.startsWith(APP_DESTINATION_PREFIX)) {
            throw deny(accessor, "direct send to " + destination);
        }
    }

    private UUID requireUserId(StompHeaderAccessor accessor) {
        Principal user = accessor.getUser();
        if (user == null) {
            throw deny(accessor, "unauthenticated");
        }
        if (!isUuid(user.getName())) {
            throw deny(accessor, "invalid principal");
        }
        return UUID.fromString(user.getName());
    }

    private String requireDestination(StompHeaderAccessor accessor) {
        String destination = accessor.getDestination();
        if (destination == null) {
            throw deny(accessor, "missing destination");
        }
        return destination;
    }

    private AccessDeniedException deny(StompHeaderAccessor accessor, String reason) {
        log.warn("STOMP {} rejected: {} (sessionId={})",
                accessor.getCommand(), reason, accessor.getSessionId());
        return new AccessDeniedException("Access denied");
    }
}
