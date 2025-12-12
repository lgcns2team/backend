package com.lgcns.haibackend.common.redis;

import java.util.Set;
import java.util.UUID;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;


import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RedisChatRepository {

    private final RedisTemplate<String, String> redisTemplate;
    
    public void deleteAllAIPersonChats(UUID userId) {
        // aiperson:chat:*:userId 패턴으로 모든 키 검색
        String pattern = "aiperson:chat:*:" + userId;
        Set<String> keys = redisTemplate.keys(pattern);
        
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
            System.out.println("[REDIS] Deleted " + keys.size() + " AI Person chat keys for user: " + userId);
        }
    }

    public void deleteAllChatbotChats(UUID userId) {
        // chatbot:chat:*:userId 패턴으로 모든 키 검색
        String pattern = "chatbot:chat:" + userId;
        Set<String> keys = redisTemplate.keys(pattern);
        
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
            System.out.println("[REDIS] Deleted " + keys.size() + " AI Person chat keys for user: " + userId);
        }
    }

}
