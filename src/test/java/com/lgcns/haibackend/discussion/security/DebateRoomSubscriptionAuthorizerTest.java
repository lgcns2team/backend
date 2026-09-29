package com.lgcns.haibackend.discussion.security;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.server.ResponseStatusException;

import com.lgcns.haibackend.discussion.service.DebateService;

class DebateRoomSubscriptionAuthorizerTest {

    private DebateService debateService;
    private DebateRoomSubscriptionAuthorizer authorizer;

    private final UUID userId = UUID.randomUUID();
    private final String roomId = UUID.randomUUID().toString();

    @BeforeEach
    void setUp() {
        debateService = mock(DebateService.class);
        authorizer = new DebateRoomSubscriptionAuthorizer(debateService);
    }

    @Test
    void supports_roomTopicsOnly() {
        assertThat(authorizer.supports("/topic/room/" + roomId)).isTrue();
        assertThat(authorizer.supports("/topic/room/*")).isTrue();
        assertThat(authorizer.supports("/topic/public")).isFalse();
        assertThat(authorizer.supports("/topic/**")).isFalse();
        assertThat(authorizer.supports("/user/queue/moderation")).isFalse();
    }

    @Test
    void authorize_member_passes() {
        assertThatCode(() -> authorizer.authorize("/topic/room/" + roomId, userId))
                .doesNotThrowAnyException();

        verify(debateService).validateJoin(roomId, userId);
    }

    @Test
    void authorize_nonMember_isDeniedWithoutLeakingReason() {
        doThrow(new ResponseStatusException(HttpStatus.FORBIDDEN, "Grade mismatch"))
                .when(debateService).validateJoin(roomId, userId);

        assertThatThrownBy(() -> authorizer.authorize("/topic/room/" + roomId, userId))
                .isInstanceOf(AccessDeniedException.class)
                .hasMessage("Access denied");
    }

    @Test
    void authorize_missingRoom_isDenied() {
        doThrow(new ResponseStatusException(HttpStatus.NOT_FOUND, "Room not found"))
                .when(debateService).validateJoin(roomId, userId);

        assertThatThrownBy(() -> authorizer.authorize("/topic/room/" + roomId, userId))
                .isInstanceOf(AccessDeniedException.class)
                .hasMessage("Access denied");
    }

    @ParameterizedTest
    @ValueSource(strings = {
            "/topic/room/*",
            "/topic/room/**",
            "/topic/room/not-a-uuid",
            "/topic/room/",
            "/topic/room/11111111-1111-1111-1111-111111111111/extra",
            "/topic/room/11111111-1111-1111-1111-111111111111*"
    })
    void authorize_patternOrMalformedDestination_isDenied(String destination) {
        assertThatThrownBy(() -> authorizer.authorize(destination, userId))
                .isInstanceOf(AccessDeniedException.class);

        verify(debateService, never()).validateJoin(any(), any());
    }
}
