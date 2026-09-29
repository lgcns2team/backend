package com.lgcns.haibackend.common.security;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Consumer;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.test.util.ReflectionTestUtils;

import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.util.JwtProvider;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

class StompAuthChannelInterceptorTest {

    private static final String SECRET = "test-secret-key-for-stomp-interceptor-0123456789";
    private static final String OTHER_SECRET = "other-secret-key-for-stomp-interceptor-0123456789";

    private final MessageChannel channel = mock(MessageChannel.class);
    private final UUID userId = UUID.randomUUID();
    private final String roomTopic = "/topic/room/" + UUID.randomUUID();

    private JwtProvider jwtProvider;
    private SubscriptionAuthorizer roomAuthorizer;
    private StompAuthChannelInterceptor interceptor;
    private Map<String, Object> session;

    @BeforeEach
    void setUp() {
        jwtProvider = new JwtProvider();
        ReflectionTestUtils.setField(jwtProvider, "secret", SECRET);

        roomAuthorizer = mock(SubscriptionAuthorizer.class);
        when(roomAuthorizer.supports(anyString()))
                .thenAnswer(inv -> inv.<String>getArgument(0).startsWith("/topic/room/"));

        interceptor = new StompAuthChannelInterceptor(jwtProvider, List.of(roomAuthorizer));
        session = new HashMap<>();
    }

    @Nested
    class Connect {

        @Test
        void validAccessTokenInHeader_setsPrincipal() {
            String token = jwtProvider.generateAccessToken(userId.toString(), Role.STUDENT);
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT,
                    a -> a.addNativeHeader("Authorization", "Bearer " + token));

            Message<?> result = interceptor.preSend(message(acc), channel);

            assertThat(result).isNotNull();
            assertThat(acc.getUser()).isInstanceOf(UsernamePasswordAuthenticationToken.class);
            assertThat(acc.getUser().getName()).isEqualTo(userId.toString());
            assertThat(((UsernamePasswordAuthenticationToken) acc.getUser()).getAuthorities())
                    .extracting(GrantedAuthority::getAuthority)
                    .containsExactly("ROLE_STUDENT");
        }

        @Test
        void validTokenFromHandshake_setsPrincipal_andIsRemovedFromSession() {
            session.put(StompAuthChannelInterceptor.HANDSHAKE_TOKEN_ATTR,
                    jwtProvider.generateAccessToken(userId.toString(), Role.TEACHER));
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT, a -> { });

            interceptor.preSend(message(acc), channel);

            assertThat(acc.getUser().getName()).isEqualTo(userId.toString());
            assertThat(session).doesNotContainKey(StompAuthChannelInterceptor.HANDSHAKE_TOKEN_ATTR);
        }

        @Test
        void headerTokenTakesPrecedenceOverHandshakeToken() {
            UUID otherUser = UUID.randomUUID();
            session.put(StompAuthChannelInterceptor.HANDSHAKE_TOKEN_ATTR,
                    jwtProvider.generateAccessToken(otherUser.toString(), Role.STUDENT));
            String headerToken = jwtProvider.generateAccessToken(userId.toString(), Role.STUDENT);
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT,
                    a -> a.addNativeHeader("Authorization", "Bearer " + headerToken));

            interceptor.preSend(message(acc), channel);

            assertThat(acc.getUser().getName()).isEqualTo(userId.toString());
            assertThat(session).doesNotContainKey(StompAuthChannelInterceptor.HANDSHAKE_TOKEN_ATTR);
        }

        @Test
        void lowercaseBearerAndHeaderName_areAccepted() {
            String token = jwtProvider.generateAccessToken(userId.toString(), Role.STUDENT);
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT,
                    a -> a.addNativeHeader("authorization", "bearer " + token));

            interceptor.preSend(message(acc), channel);

            assertThat(acc.getUser().getName()).isEqualTo(userId.toString());
        }

        @Test
        void stompCommandFrame_isAuthenticatedLikeConnect() {
            StompHeaderAccessor acc = accessor(StompCommand.STOMP, a -> { });

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }

        @Test
        void missingToken_isRejected() {
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT, a -> { });

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class)
                    .hasMessage("Authentication required");
            assertThat(acc.getUser()).isNull();
        }

        @Test
        void emptyBearerToken_isRejected() {
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT,
                    a -> a.addNativeHeader("Authorization", "Bearer "));

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }

        @Test
        void refreshToken_isRejected() {
            String token = jwtProvider.generateRefreshToken(userId.toString(), Role.STUDENT);

            assertRejected(token);
        }

        @Test
        void expiredToken_isRejected() {
            assertRejected(sign(SECRET, userId.toString(), "STUDENT", -1_000));
        }

        @Test
        void tokenSignedWithOtherKey_isRejected() {
            assertRejected(sign(OTHER_SECRET, userId.toString(), "STUDENT", 60_000));
        }

        @Test
        void malformedToken_isRejected() {
            assertRejected("not-a-jwt");
        }

        @Test
        void nonUuidSubject_isRejected() {
            assertRejected(sign(SECRET, "not-a-uuid", "STUDENT", 60_000));
        }

        @Test
        void missingRoleClaim_isRejected() {
            assertRejected(sign(SECRET, userId.toString(), null, 60_000));
        }

        private void assertRejected(String token) {
            StompHeaderAccessor acc = accessor(StompCommand.CONNECT,
                    a -> a.addNativeHeader("Authorization", "Bearer " + token));

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class)
                    .hasMessage("Invalid token");
            assertThat(acc.getUser()).isNull();
        }
    }

    @Nested
    class Subscribe {

        @Test
        void unauthenticated_isRejected() {
            StompHeaderAccessor acc = accessor(StompCommand.SUBSCRIBE, a -> a.setDestination(roomTopic));

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
            verify(roomAuthorizer, never()).authorize(any(), any());
        }

        @Test
        void userQueue_isAllowedWithoutAuthorizer() {
            StompHeaderAccessor acc = authenticated(StompCommand.SUBSCRIBE, "/user/queue/moderation");

            assertThatCode(() -> interceptor.preSend(message(acc), channel)).doesNotThrowAnyException();
            verify(roomAuthorizer, never()).authorize(any(), any());
        }

        @Test
        void roomTopic_delegatesToAuthorizer() {
            StompHeaderAccessor acc = authenticated(StompCommand.SUBSCRIBE, roomTopic);

            assertThatCode(() -> interceptor.preSend(message(acc), channel)).doesNotThrowAnyException();
            verify(roomAuthorizer).authorize(roomTopic, userId);
        }

        @Test
        void authorizerDenial_isPropagated() {
            doThrow(new AccessDeniedException("Access denied")).when(roomAuthorizer).authorize(roomTopic, userId);
            StompHeaderAccessor acc = authenticated(StompCommand.SUBSCRIBE, roomTopic);

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }

        @ParameterizedTest
        @ValueSource(strings = { "/topic/public", "/topic/**", "/topic/*", "/queue/anything", "/user/topic/x" })
        void destinationWithoutAuthorizer_isRejected(String destination) {
            StompHeaderAccessor acc = authenticated(StompCommand.SUBSCRIBE, destination);

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
            verify(roomAuthorizer, never()).authorize(any(), any());
        }

        @Test
        void missingDestination_isRejected() {
            StompHeaderAccessor acc = authenticated(StompCommand.SUBSCRIBE, null);

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }
    }

    @Nested
    class Send {

        @Test
        void appDestination_isAllowed() {
            StompHeaderAccessor acc = authenticated(StompCommand.SEND, "/app/room/" + UUID.randomUUID() + "/chat");

            assertThatCode(() -> interceptor.preSend(message(acc), channel)).doesNotThrowAnyException();
        }

        @ParameterizedTest
        @ValueSource(strings = { "/topic/room/x", "/queue/x", "/user/queue/moderation", "/apps/x", "app/x" })
        void nonAppDestination_isRejected(String destination) {
            StompHeaderAccessor acc = authenticated(StompCommand.SEND, destination);

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }

        @Test
        void unauthenticated_isRejected() {
            StompHeaderAccessor acc = accessor(StompCommand.SEND, a -> a.setDestination("/app/room/x/chat"));

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }

        @Test
        void nonUuidPrincipal_isRejected() {
            StompHeaderAccessor acc = accessor(StompCommand.SEND, a -> {
                a.setDestination("/app/room/x/chat");
                a.setUser(new UsernamePasswordAuthenticationToken("anonymousUser", null, List.of()));
            });

            assertThatThrownBy(() -> interceptor.preSend(message(acc), channel))
                    .isInstanceOf(AccessDeniedException.class);
        }
    }

    @Nested
    class OtherFrames {

        @Test
        void heartbeat_passes() {
            StompHeaderAccessor acc = StompHeaderAccessor.createForHeartbeat();
            acc.setLeaveMutable(true);

            assertThatCode(() -> interceptor.preSend(message(acc), channel)).doesNotThrowAnyException();
        }

        @Test
        void disconnectAndUnsubscribe_passWithoutUser() {
            StompHeaderAccessor disconnect = accessor(StompCommand.DISCONNECT, a -> { });
            StompHeaderAccessor unsubscribe = accessor(StompCommand.UNSUBSCRIBE, a -> a.setSubscriptionId("sub-0"));

            assertThatCode(() -> interceptor.preSend(message(disconnect), channel)).doesNotThrowAnyException();
            assertThatCode(() -> interceptor.preSend(message(unsubscribe), channel)).doesNotThrowAnyException();
        }
    }

    // --- helpers ---

    private StompHeaderAccessor accessor(StompCommand command, Consumer<StompHeaderAccessor> customizer) {
        StompHeaderAccessor acc = StompHeaderAccessor.create(command);
        acc.setSessionId("session-1");
        acc.setSessionAttributes(session);
        customizer.accept(acc);
        acc.setLeaveMutable(true); // 런타임처럼 인터셉터가 헤더를 직접 수정할 수 있게
        return acc;
    }

    private StompHeaderAccessor authenticated(StompCommand command, String destination) {
        return accessor(command, a -> {
            if (destination != null) {
                a.setDestination(destination);
            }
            a.setUser(new UsernamePasswordAuthenticationToken(userId.toString(), null, List.of()));
        });
    }

    private Message<byte[]> message(StompHeaderAccessor acc) {
        return MessageBuilder.createMessage(new byte[0], acc.getMessageHeaders());
    }

    private String sign(String secret, String subject, String role, long expiresInMs) {
        var builder = Jwts.builder()
                .setSubject(subject)
                .setExpiration(new Date(System.currentTimeMillis() + expiresInMs));
        if (role != null) {
            builder.claim("role", role);
        }
        return builder
                .signWith(Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8)))
                .compact();
    }
}
