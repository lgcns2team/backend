package com.lgcns.haibackend.discussion.security;

import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import com.lgcns.haibackend.common.security.SubscriptionAuthorizer;
import com.lgcns.haibackend.discussion.service.DebateService;

import lombok.RequiredArgsConstructor;

/**
 * 토론방 topic(/topic/room/{roomId}) 구독 인가.
 * 방 참여 자격(validateJoin)이 있는 사용자만 구독할 수 있다.
 */
@Component
@RequiredArgsConstructor
public class DebateRoomSubscriptionAuthorizer implements SubscriptionAuthorizer {

    private static final String ROOM_TOPIC_PREFIX = "/topic/room/";

    // 정확한 UUID만 허용 (/topic/room/*, /topic/room/** 같은 패턴 구독 차단)
    private static final Pattern ROOM_TOPIC = Pattern.compile(
            "^/topic/room/([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})$");

    private final DebateService debateService;

    @Override
    public boolean supports(String destination) {
        return destination.startsWith(ROOM_TOPIC_PREFIX);
    }

    @Override
    public void authorize(String destination, UUID userId) {
        Matcher matcher = ROOM_TOPIC.matcher(destination);
        if (!matcher.matches()) {
            throw new AccessDeniedException("Access denied");
        }
        try {
            debateService.validateJoin(matcher.group(1), userId);
        } catch (ResponseStatusException e) {
            // 거부 사유(Grade mismatch 등)는 클라이언트에 노출하지 않음
            throw new AccessDeniedException("Access denied");
        }
    }
}
