package com.lgcns.haibackend.chatbot.service;

import com.lgcns.haibackend.chatbot.domain.dto.MessageDTO;
import com.lgcns.haibackend.common.redis.RedisChatRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotService {
        
        private final RedisChatRepository redisChatRepository;
        
        // 챗봇 대화 히스토리 조회
        public List<MessageDTO> getChatbotHistory(UUID userId) {
                String historyKey = "chatbot:chat:" + userId.toString();
                log.info("[CHATBOT HISTORY] Fetching history for user: {}", userId);
                
                return redisChatRepository.getMessages(historyKey);
        }
}