package com.lgcns.haibackend.discussion;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.timeout;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.autoconfigure.ImportAutoConfiguration;
import org.springframework.boot.autoconfigure.context.PropertyPlaceholderAutoConfiguration;
import org.springframework.boot.autoconfigure.jackson.JacksonAutoConfiguration;
import org.springframework.boot.autoconfigure.web.servlet.DispatcherServletAutoConfiguration;
import org.springframework.boot.autoconfigure.web.servlet.ServletWebServerFactoryAutoConfiguration;
import org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration;
import org.springframework.boot.autoconfigure.websocket.servlet.WebSocketServletAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompFrameHandler;
import org.springframework.messaging.simp.stomp.StompHeaders;
import org.springframework.messaging.simp.stomp.StompSession;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.socket.WebSocketHttpHeaders;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.messaging.WebSocketStompClient;
import org.springframework.web.socket.sockjs.client.SockJsClient;
import org.springframework.web.socket.sockjs.client.WebSocketTransport;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.common.security.StompAuthChannelInterceptor;
import com.lgcns.haibackend.discussion.config.WebSocketConfig;
import com.lgcns.haibackend.discussion.controller.DebateController;
import com.lgcns.haibackend.discussion.domain.dto.DebateStatus;
import com.lgcns.haibackend.discussion.security.DebateRoomSubscriptionAuthorizer;
import com.lgcns.haibackend.discussion.service.DebateService;
import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.moderation.dto.ModerationResult;
import com.lgcns.haibackend.moderation.service.ModerationService;
import com.lgcns.haibackend.util.JwtProvider;

/**
 * 실제 서버 + STOMP(SockJS) 클라이언트로 인증·인가 흐름을 검증한다.
 * DB/Redis 대신 DebateService, ModerationService는 mock.
 */
@SpringBootTest(
        webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        classes = StompSecurityIntegrationTest.WsTestApp.class,
        properties = "jwt.secret=integration-test-secret-key-0123456789abcdef")
class StompSecurityIntegrationTest {

    private static final long TIMEOUT_SEC = 5;

    @SpringBootConfiguration
    @ImportAutoConfiguration({
            PropertyPlaceholderAutoConfiguration.class,
            ServletWebServerFactoryAutoConfiguration.class,
            DispatcherServletAutoConfiguration.class,
            WebMvcAutoConfiguration.class,
            WebSocketServletAutoConfiguration.class,
            JacksonAutoConfiguration.class })
    @Import({
            WebSocketConfig.class,
            StompAuthChannelInterceptor.class,
            JwtProvider.class,
            DebateRoomSubscriptionAuthorizer.class,
            DebateController.class })
    static class WsTestApp {
    }

    @LocalServerPort
    private int port;

    @MockitoBean
    private DebateService debateService;

    @MockitoBean
    private ModerationService moderationService;

    private JwtProvider jwtProvider;
    private WebSocketStompClient stompClient;

    private final UUID userId = UUID.randomUUID();
    private final UUID roomId = UUID.randomUUID();
    private String roomTopic;

    @BeforeEach
    void setUp() {
        jwtProvider = new JwtProvider();
        org.springframework.test.util.ReflectionTestUtils.setField(
                jwtProvider, "secret", "integration-test-secret-key-0123456789abcdef");

        MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
        converter.setObjectMapper(new ObjectMapper().findAndRegisterModules());

        stompClient = new WebSocketStompClient(
                new SockJsClient(List.of(new WebSocketTransport(new StandardWebSocketClient()))));
        stompClient.setMessageConverter(converter);

        roomTopic = "/topic/room/" + roomId;

        when(debateService.requireStatusSelected(anyString(), any(), any())).thenReturn(DebateStatus.PRO);
        when(debateService.resolveNickname(any(), any())).thenReturn("nick");
        when(moderationService.check(anyString(), anyString()))
                .thenAnswer(inv -> new ModerationResult(true, false, inv.getArgument(1), null, 0));
    }

    @AfterEach
    void tearDown() {
        stompClient.stop();
    }

    // --- CONNECT ---

    @Test
    void connect_withHeaderToken_succeeds() throws Exception {
        StompSession session = connectWithHeader(accessToken(userId));

        assertThat(session.isConnected()).isTrue();
    }

    @Test
    void connect_withQueryToken_succeeds() throws Exception {
        StompSession session = connect(url() + "?token=" + accessToken(userId), new StompHeaders(), new Recorder())
                .get(TIMEOUT_SEC, TimeUnit.SECONDS);

        assertThat(session.isConnected()).isTrue();
    }

    @Test
    void connect_withoutToken_isRejected() {
        Recorder recorder = new Recorder();

        assertThatThrownBy(() -> connect(url(), new StompHeaders(), recorder).get(TIMEOUT_SEC, TimeUnit.SECONDS))
                .isInstanceOf(ExecutionException.class);
        assertThat(recorder.errorFrames).isNotEmpty();
    }

    @Test
    void connect_withRefreshToken_isRejected() {
        Recorder recorder = new Recorder();
        StompHeaders headers = bearer(jwtProvider.generateRefreshToken(userId.toString(), Role.STUDENT));

        assertThatThrownBy(() -> connect(url(), headers, recorder).get(TIMEOUT_SEC, TimeUnit.SECONDS))
                .isInstanceOf(ExecutionException.class);
        assertThat(recorder.errorFrames).isNotEmpty();
    }

    @Test
    void connect_withForgedToken_isRejected() {
        Recorder recorder = new Recorder();

        assertThatThrownBy(() -> connect(url(), bearer("forged.token.value"), recorder)
                .get(TIMEOUT_SEC, TimeUnit.SECONDS))
                .isInstanceOf(ExecutionException.class);
    }

    // --- Principal 유지 (CONNECT 이후 프레임) ---

    @Test
    void principal_isCarriedToSubscribeAndSend() throws Exception {
        StompSession session = connectWithHeader(accessToken(userId));
        BlockingQueue<Map<String, Object>> received = subscribe(session, roomTopic);

        // SUBSCRIBE 시점에 CONNECT의 userId로 인가됨
        verify(debateService, timeout(2_000)).validateJoin(roomId.toString(), userId);

        session.send("/app/room/" + roomId + "/chat", Map.of("type", "CHAT", "content", "hello"));

        Map<String, Object> message = received.poll(TIMEOUT_SEC, TimeUnit.SECONDS);
        assertThat(message).isNotNull();
        assertThat(message.get("content")).isEqualTo("hello");
        // SEND 시점에도 같은 userId가 Principal로 전달됨
        assertThat(message.get("userId")).isEqualTo(userId.toString());
    }

    @Test
    void userQueue_deliversToPrincipal() throws Exception {
        when(moderationService.check(anyString(), anyString()))
                .thenReturn(new ModerationResult(false, true, null, "blocked", 300));
        StompSession session = connectWithHeader(accessToken(userId));
        BlockingQueue<Map<String, Object>> moderation = subscribe(session, "/user/queue/moderation");
        subscribe(session, roomTopic);
        verify(debateService, timeout(2_000)).validateJoin(roomId.toString(), userId);

        session.send("/app/room/" + roomId + "/chat", Map.of("type", "CHAT", "content", "bad"));

        Map<String, Object> notice = moderation.poll(TIMEOUT_SEC, TimeUnit.SECONDS);
        assertThat(notice).isNotNull();
        assertThat(notice.get("type")).isEqualTo("blocked");
    }

    // --- SUBSCRIBE ---

    @Test
    void subscribe_toUnauthorizedRoom_closesConnection() throws Exception {
        doThrow(new ResponseStatusException(HttpStatus.FORBIDDEN, "Grade mismatch"))
                .when(debateService).validateJoin(eq(roomId.toString()), any());
        Recorder recorder = new Recorder();
        StompSession session = connect(url(), bearer(accessToken(userId)), recorder)
                .get(TIMEOUT_SEC, TimeUnit.SECONDS);

        subscribe(session, roomTopic);

        assertThat(recorder.awaitError()).isNotNull();
        assertThat(recorder.errorFrames.peek().getFirst("message")).doesNotContain("Grade mismatch");
        assertThat(recorder.awaitClosed()).isTrue();
    }

    @Test
    void subscribe_toWildcardTopic_closesConnection() throws Exception {
        Recorder recorder = new Recorder();
        StompSession session = connect(url(), bearer(accessToken(userId)), recorder)
                .get(TIMEOUT_SEC, TimeUnit.SECONDS);

        subscribe(session, "/topic/**");

        assertThat(recorder.awaitError()).isNotNull();
        assertThat(recorder.awaitClosed()).isTrue();
    }

    // --- SEND ---

    @Test
    void directSendToBroker_isRejected_andNotBroadcast() throws Exception {
        StompSession listener = connectWithHeader(accessToken(userId));
        BlockingQueue<Map<String, Object>> received = subscribe(listener, roomTopic);
        verify(debateService, timeout(2_000)).validateJoin(roomId.toString(), userId);

        Recorder attackerRecorder = new Recorder();
        StompSession attacker = connect(url(), bearer(accessToken(UUID.randomUUID())), attackerRecorder)
                .get(TIMEOUT_SEC, TimeUnit.SECONDS);
        attacker.send(roomTopic, Map.of("type", "SUMMARY", "sender", "teacher", "content", "forged"));

        assertThat(attackerRecorder.awaitError()).isNotNull();
        assertThat(received.poll(1, TimeUnit.SECONDS)).isNull();
    }

    @Test
    void sendThroughApp_isBroadcast() throws Exception {
        StompSession listener = connectWithHeader(accessToken(userId));
        BlockingQueue<Map<String, Object>> received = subscribe(listener, roomTopic);
        verify(debateService, timeout(2_000)).validateJoin(roomId.toString(), userId);

        UUID senderId = UUID.randomUUID();
        StompSession sender = connectWithHeader(accessToken(senderId));
        sender.send("/app/room/" + roomId + "/chat", Map.of("type", "CHAT", "content", "hi"));

        Map<String, Object> message = received.poll(TIMEOUT_SEC, TimeUnit.SECONDS);
        assertThat(message).isNotNull();
        assertThat(message.get("userId")).isEqualTo(senderId.toString());
    }

    // --- helpers ---

    private String url() {
        return "http://localhost:" + port + "/api/ws-stomp";
    }

    private String accessToken(UUID id) {
        return jwtProvider.generateAccessToken(id.toString(), Role.STUDENT);
    }

    private StompHeaders bearer(String token) {
        StompHeaders headers = new StompHeaders();
        headers.add("Authorization", "Bearer " + token);
        return headers;
    }

    private StompSession connectWithHeader(String token) throws Exception {
        return connect(url(), bearer(token), new Recorder()).get(TIMEOUT_SEC, TimeUnit.SECONDS);
    }

    private CompletableFuture<StompSession> connect(String url, StompHeaders headers, Recorder recorder) {
        return stompClient.connectAsync(url, new WebSocketHttpHeaders(), headers, recorder);
    }

    private BlockingQueue<Map<String, Object>> subscribe(StompSession session, String destination) {
        BlockingQueue<Map<String, Object>> queue = new LinkedBlockingQueue<>();
        session.subscribe(destination, new StompFrameHandler() {
            @Override
            public Type getPayloadType(StompHeaders headers) {
                return Map.class;
            }

            @Override
            @SuppressWarnings("unchecked")
            public void handleFrame(StompHeaders headers, Object payload) {
                queue.add((Map<String, Object>) payload);
            }
        });
        return queue;
    }

    /** ERROR 프레임과 연결 종료를 기록하는 세션 핸들러 */
    static class Recorder extends StompSessionHandlerAdapter {
        final BlockingQueue<StompHeaders> errorFrames = new LinkedBlockingQueue<>();
        final CompletableFuture<Boolean> closed = new CompletableFuture<>();

        @Override
        public Type getPayloadType(StompHeaders headers) {
            return byte[].class;
        }

        @Override
        public void handleFrame(StompHeaders headers, Object payload) {
            errorFrames.add(headers); // 구독과 무관한 프레임 = ERROR
        }

        @Override
        public void handleException(StompSession session, StompCommand command, StompHeaders headers,
                byte[] payload, Throwable exception) {
        }

        @Override
        public void handleTransportError(StompSession session, Throwable exception) {
            closed.complete(true);
        }

        StompHeaders awaitError() throws InterruptedException {
            StompHeaders headers = errorFrames.poll(TIMEOUT_SEC, TimeUnit.SECONDS);
            if (headers != null) {
                errorFrames.add(headers);
            }
            return headers;
        }

        boolean awaitClosed() throws Exception {
            return closed.get(TIMEOUT_SEC, TimeUnit.SECONDS);
        }
    }
}
