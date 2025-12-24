package com.lgcns.haibackend.global.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 모든 경로에 대해
                .allowedOrigins("http://localhost:5173", "http://localhost:8080") // 이 주소에서 오는 요청은 허락해줘!
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 이 방식들은 다 괜찮아!
                .allowCredentials(true) // 쿠키나 인증 정보도 포함해도 돼!
                .maxAge(3600); // 1시간 동안은 이 설정을 기억해!
    }
}