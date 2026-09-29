package com.lgcns.haibackend.discussion.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;
import org.mockito.ArgumentCaptor;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.server.ResponseStatusException;

import com.lgcns.haibackend.discussion.domain.dto.ChatMessage;
import com.lgcns.haibackend.discussion.domain.dto.DebateStatus;
import com.lgcns.haibackend.discussion.domain.dto.StatusSelectMessage;
import com.lgcns.haibackend.discussion.service.DebateService;
import com.lgcns.haibackend.moderation.dto.ModerationResult;
import com.lgcns.haibackend.moderation.service.ModerationService;

class DebateControllerTest {

    private DebateService debateService;
    private SimpMessagingTemplate messagingTemplate;
    private ModerationService moderationService;
    private DebateController controller;

    private final UUID userId = UUID.randomUUID();
    private final UUID roomId = UUID.randomUUID();
    private final String roomTopic = "/topic/room/" + roomId;

    @BeforeEach
    void setUp() {
        debateService = mock(DebateService.class);
        messagingTemplate = mock(SimpMessagingTemplate.class);
        moderationService = mock(ModerationService.class);
        controller = new DebateController(debateService, messagingTemplate, moderationService);
    }

    @Nested
    class SelectStatus {

        @ParameterizedTest
        @EnumSource(value = DebateStatus.class, names = { "MODE_CHANGE", "ANONYMOUS", "END_SESSION", "SUMMARY" })
        void teacherOnlyStatus_fromStudent_isRejected(DebateStatus status) {
            denyTeacher();

            assertThatThrownBy(() -> controller.selectStatus(roomId.toString(), status(status, "x"), accessor()))
                    .isInstanceOf(ResponseStatusException.class);

            verify(debateService, never()).updateRoomMode(anyString(), anyString());
            verify(messagingTemplate, never()).convertAndSend(anyString(), any(Object.class));
        }

        @ParameterizedTest
        @EnumSource(value = DebateStatus.class, names = { "MODE_CHANGE", "ANONYMOUS", "END_SESSION", "SUMMARY" })
        void teacherOnlyStatus_fromTeacher_isBroadcast(DebateStatus status) {
            controller.selectStatus(roomId.toString(), status(status, "chat"), accessor());

            verify(debateService).validateTeacher(userId);
            ChatMessage out = captureBroadcast();
            assertThat(out.getStatus()).isEqualTo(status);
            assertThat(out.getType()).isEqualTo(status == DebateStatus.SUMMARY
                    ? ChatMessage.MessageType.SUMMARY
                    : ChatMessage.MessageType.STATUS);
        }

        @Test
        void modeChange_fromTeacher_updatesRoomMode() {
            controller.selectStatus(roomId.toString(), status(DebateStatus.MODE_CHANGE, "verify"), accessor());

            verify(debateService).updateRoomMode(roomId.toString(), "verify");
        }

        @ParameterizedTest
        @EnumSource(value = DebateStatus.class, names = { "PRO", "CON", "CANCEL" })
        void voteStatus_fromStudent_isAllowed(DebateStatus status) {
            denyTeacher();

            controller.selectStatus(roomId.toString(), status(status, null), accessor());

            verify(debateService, never()).validateTeacher(any());
            verify(debateService).saveStatus(roomId.toString(), userId, status);
            assertThat(captureBroadcast().getStatus()).isEqualTo(status);
        }

        @Test
        void nonMember_isRejectedBeforeTeacherCheck() {
            doThrow(new ResponseStatusException(HttpStatus.FORBIDDEN))
                    .when(debateService).validateJoin(roomId.toString(), userId);

            assertThatThrownBy(() -> controller.selectStatus(
                    roomId.toString(), status(DebateStatus.MODE_CHANGE, "chat"), accessor()))
                    .isInstanceOf(ResponseStatusException.class);

            verify(debateService, never()).validateTeacher(any());
        }
    }

    @Nested
    class UpdateMode {

        @Test
        void teacher_updatesAndBroadcasts() {
            controller.updateMode(roomId.toString(), Map.of("viewMode", "result"), accessor());

            verify(debateService).validateJoin(roomId.toString(), userId);
            verify(debateService).updateRoomMode(roomId.toString(), "result");
            assertThat(captureBroadcast().getType()).isEqualTo(ChatMessage.MessageType.MODE_CHANGE);
        }

        @Test
        void student_isRejected() {
            denyTeacher();

            assertThatThrownBy(() -> controller.updateMode(roomId.toString(), Map.of("viewMode", "result"), accessor()))
                    .isInstanceOf(ResponseStatusException.class);

            verify(debateService, never()).updateRoomMode(anyString(), anyString());
        }

        @Test
        void nonMember_isRejected() {
            doThrow(new ResponseStatusException(HttpStatus.FORBIDDEN))
                    .when(debateService).validateJoin(roomId.toString(), userId);

            assertThatThrownBy(() -> controller.updateMode(roomId.toString(), Map.of("viewMode", "result"), accessor()))
                    .isInstanceOf(ResponseStatusException.class);

            verify(debateService, never()).updateRoomMode(anyString(), anyString());
        }
    }

    @Nested
    class SendMessage {

        @BeforeEach
        void allowChat() {
            when(debateService.requireStatusSelected(eq(roomId.toString()), eq(userId), any()))
                    .thenReturn(DebateStatus.PRO);
            when(debateService.resolveNickname(eq(userId), any())).thenReturn("nick");
            when(moderationService.check(eq(userId.toString()), anyString()))
                    .thenAnswer(inv -> new ModerationResult(true, false, inv.getArgument(1), null, 0));
        }

        @Test
        void summaryType_fromStudent_isStoredAsChat() {
            when(debateService.isTeacher(userId)).thenReturn(false);

            controller.sendMessage(roomId, chat(ChatMessage.MessageType.SUMMARY), accessor());

            assertThat(captureBroadcast().getType()).isEqualTo(ChatMessage.MessageType.CHAT);
        }

        @Test
        void summaryType_fromTeacher_isKept() {
            when(debateService.isTeacher(userId)).thenReturn(true);

            controller.sendMessage(roomId, chat(ChatMessage.MessageType.SUMMARY), accessor());

            assertThat(captureBroadcast().getType()).isEqualTo(ChatMessage.MessageType.SUMMARY);
        }

        @Test
        void chatType_doesNotQueryTeacherRole() {
            controller.sendMessage(roomId, chat(ChatMessage.MessageType.CHAT), accessor());

            verify(debateService, never()).isTeacher(any());
            assertThat(captureBroadcast().getType()).isEqualTo(ChatMessage.MessageType.CHAT);
        }
    }

    @Test
    void join_withoutUser_isRejected() {
        SimpMessageHeaderAccessor accessor = SimpMessageHeaderAccessor.create();
        accessor.setSessionAttributes(new HashMap<>());

        assertThatThrownBy(() -> controller.join(roomId.toString(), Map.of("token", "anything"), accessor))
                .isInstanceOf(ResponseStatusException.class);

        verify(debateService, never()).validateJoin(anyString(), any());
    }

    // --- helpers ---

    private void denyTeacher() {
        doThrow(new ResponseStatusException(HttpStatus.FORBIDDEN))
                .when(debateService).validateTeacher(userId);
    }

    private SimpMessageHeaderAccessor accessor() {
        SimpMessageHeaderAccessor accessor = SimpMessageHeaderAccessor.create();
        accessor.setUser(new UsernamePasswordAuthenticationToken(userId.toString(), null, List.of()));
        accessor.setSessionAttributes(new HashMap<>());
        return accessor;
    }

    private StatusSelectMessage status(DebateStatus status, String content) {
        StatusSelectMessage msg = new StatusSelectMessage();
        msg.setStatus(status);
        msg.setContent(content);
        return msg;
    }

    private ChatMessage chat(ChatMessage.MessageType type) {
        return ChatMessage.builder().type(type).content("hello").build();
    }

    private ChatMessage captureBroadcast() {
        ArgumentCaptor<Object> captor = ArgumentCaptor.forClass(Object.class);
        verify(messagingTemplate).convertAndSend(eq(roomTopic), captor.capture());
        return (ChatMessage) captor.getValue();
    }
}
