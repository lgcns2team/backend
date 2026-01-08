package com.lgcns.haibackend.aiPerson.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.lgcns.haibackend.chatbot.domain.dto.MessageDTO;
import com.lgcns.haibackend.common.redis.RedisChatRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AIPersonChatService {

    private final RedisChatRepository redisChatRepository;

    @Value("${aws.bedrock.prompt.ai-person}")
    private String aiPersonPromptId;

    // 특정 AI 인물과의 대화 히스토리 조회
    public List<MessageDTO> getChatHistory(String promptId, UUID userId) {
        String historyKey = "aiperson:chat:" + promptId + ":" + userId.toString();
        
        return redisChatRepository.getMessages(historyKey);
    }
}