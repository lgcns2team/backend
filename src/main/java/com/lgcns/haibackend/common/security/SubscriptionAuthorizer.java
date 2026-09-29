package com.lgcns.haibackend.common.security;

import java.util.UUID;

/**
 * STOMP SUBSCRIBE 목적지별 인가.
 * 어떤 구현체도 supports 하지 않는 목적지는 구독이 거부된다.
 */
public interface SubscriptionAuthorizer {

    boolean supports(String destination);

    /** 권한이 없으면 AccessDeniedException */
    void authorize(String destination, UUID userId);
}
