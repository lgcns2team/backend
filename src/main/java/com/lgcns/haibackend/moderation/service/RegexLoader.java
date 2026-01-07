package com.lgcns.haibackend.moderation.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;
import java.util.stream.Collectors;

@Slf4j
@Component
public class RegexLoader {

    public Pattern loadProfanityPattern() {
        // 1) 리소스 읽기 실패해도 서버는 떠야 함
        List<String> lines = new ArrayList<>();
        lines.addAll(readLinesSafe("moderation/profanity_base.regex"));
        lines.addAll(readLinesSafe("moderation/profanity_evasion.regex"));

        String joined = lines.stream()
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .filter(s -> !s.startsWith("#"))
                .map(s -> "(?:" + s + ")")
                .collect(Collectors.joining("|"));

        // 2) 컴파일 실패해도 서버는 떠야 함
        try {
            if (joined.isBlank()) {
                log.warn("profanity patterns empty");
                return Pattern.compile("$^");
            }
            return Pattern.compile(joined, Pattern.UNICODE_CASE);
        } catch (PatternSyntaxException e) {
            log.error("profanity regex compile failed", e);
            return Pattern.compile("$^");
        }
    }

    private List<String> readLinesSafe(String classpathLocation) {
        try {
            ClassPathResource res = new ClassPathResource(classpathLocation);
            try (var in = res.getInputStream();
                 var br = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8))) {
                return br.lines().toList();
            }
        } catch (Exception e) {
            log.error("Cannot read regex resource: {}", classpathLocation, e);
            return List.of();
        }
    }
}
