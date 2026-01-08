package com.lgcns.haibackend.chatbot.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.lgcns.haibackend.chatbot.domain.dto.MessageDTO;
import com.lgcns.haibackend.chatbot.service.ChatbotService;

import java.util.List;
import java.util.UUID;

/**
 * Bedrock AI API 컨트롤러
 */
@Slf4j
@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatbotController {

    private final ChatbotService bedrockService;

    // 챗봇 대화 히스토리 조회
    @GetMapping("/history")
    public ResponseEntity<List<MessageDTO>> getChatbotHistory(Authentication authentication) {
        
        UUID userId = UUID.fromString(authentication.getPrincipal().toString());
        log.info("[CHATBOT HISTORY REQUEST] UserID: {}", userId);
        
        List<MessageDTO> history = bedrockService.getChatbotHistory(userId);
        
        return ResponseEntity.ok(history);
    }

}