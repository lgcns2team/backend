package com.lgcns.haibackend.moderation.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ModerationResult {
    private final boolean allowed;       // 브로드캐스트/저장 진행 여부
    private final boolean muted;         // 현재 mute 상태인지
    private final String content;        // allowed=true일 때 사용할 content(마스킹 반영)
    private final String notice;         // 사용자에게 보여줄 안내문(없으면 null)
    private final long muteSecondsLeft;  // mute 남은 시간(가능하면 TTL로)
}
