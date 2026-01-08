package com.lgcns.haibackend.aiPerson.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.lgcns.haibackend.aiPerson.service.AIPersonChatService;
import com.lgcns.haibackend.chatbot.domain.dto.MessageDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/ai-person")
@RequiredArgsConstructor
public class AIPersonChatController {

    private final AIPersonChatService aiPersonChatService;

    // 특정 AI 인물과의 대화 히스토리 조회
    @GetMapping("/{promptId}/history")
    public ResponseEntity<List<MessageDTO>> getChatHistory(
            @PathVariable("promptId") String promptId,
            Authentication authentication) {
        
        UUID userId = UUID.fromString(authentication.getName()); 
        List<MessageDTO> history = aiPersonChatService.getChatHistory(promptId, userId);
        
        return ResponseEntity.ok(history);
    }

}