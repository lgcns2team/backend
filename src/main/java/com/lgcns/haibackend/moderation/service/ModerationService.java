package com.lgcns.haibackend.moderation.service;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import com.lgcns.haibackend.moderation.dto.ModerationResult;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ModerationService {

    private final StringRedisTemplate redis;

    @Value("${moderation.warn-ttl-seconds:86400}")
    private long warnTtlSeconds;

    @Value("${moderation.mute-seconds:300}")
    private long muteSeconds;

    private Pattern badPattern;

    @PostConstruct
    public void init() throws IOException {
        List<String> patterns = new ArrayList<>();

        // 분리된 파일 2개 로드
        patterns.addAll(loadPatterns("profanity_base.regex"));
        patterns.addAll(loadPatterns("profanity_evasion.regex"));

        if (patterns.isEmpty()) {
            throw new IllegalStateException("No profanity patterns loaded. Check regex files.");
        }

        String joined = patterns.stream()
                .map(s -> "(?:" + s + ")")
                .collect(Collectors.joining("|"));

        // 영문 회피도 잡기 위해 CASE_INSENSITIVE 추가 권장
        this.badPattern = Pattern.compile(
                joined,
                Pattern.UNICODE_CHARACTER_CLASS | Pattern.CASE_INSENSITIVE
        );
    }

    private List<String> loadPatterns(String classpathName) throws IOException {
        ClassPathResource resource = new ClassPathResource(classpathName);
        if (!resource.exists()) return List.of();

        try (InputStream is = resource.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {

            return br.lines()
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .filter(s -> !s.startsWith("#"))      // 주석 제거
                    .filter(s -> !s.matches("=+"))        // 구분선 제거(있을 경우)
                    .collect(Collectors.toList());
        }
    }


    private String warnKey(String userId) { return "moderation:warn:" + userId; }
    private String muteKey(String userId) { return "moderation:mute:" + userId; }

    public ModerationResult check(String userId, String incoming) {
        // 1) mute 체크
        String mk = muteKey(userId);
        Boolean muted = redis.hasKey(mk);
        if (Boolean.TRUE.equals(muted)) {
            Long ttl = redis.getExpire(mk);
            long left = (ttl != null && ttl > 0) ? ttl : muteSeconds;
            return new ModerationResult(false, true, null,
                    "현재 채팅이 5분간 제한되었습니다.", left);
        }

        // 2) 정규식 매칭
        if (incoming == null) incoming = "";
        boolean hit = badPattern.matcher(incoming).find();
        if (!hit) {
            return new ModerationResult(true, false, incoming, null, 0);
        }

        // 3) 경고 증가
        String wk = warnKey(userId);
        Long warn = redis.opsForValue().increment(wk);
        //처음 경고 시점부터 24h
        redis.expire(wk, Duration.ofSeconds(warnTtlSeconds));

        if (warn != null && warn == 1L) {
            String masked = badPattern.matcher(incoming).replaceAll("***");
            return new ModerationResult(true, false, masked,
                    "비속어/부적절한 표현이 감지되어 일부가 마스킹되었습니다. 표현을 정제해 주세요.", 0);
        }

        // 2회 이상 → mute 5분
        redis.opsForValue().set(mk, "1", Duration.ofSeconds(muteSeconds));
        return new ModerationResult(false, true, null,
                "비속어/부적절한 표현이 반복되어 5분간 채팅이 제한됩니다.", muteSeconds);
    }
}
