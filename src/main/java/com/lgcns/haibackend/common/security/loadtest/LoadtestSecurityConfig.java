package com.lgcns.haibackend.common.security.loadtest;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@Profile({"local", "loadtest"})
public class LoadtestSecurityConfig {

    private final GatewayHeaderAuthFilter gatewayHeaderAuthFilter;

    public LoadtestSecurityConfig(GatewayHeaderAuthFilter gatewayHeaderAuthFilter) {
        this.gatewayHeaderAuthFilter = gatewayHeaderAuthFilter;
    }

    @Bean
    public SecurityFilterChain loadtestChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            // 운영과 비슷하게 "인증 필요"를 유지하고 싶으면 authenticated() 유지
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/actuator/health", "/health").permitAll()
                .anyRequest().authenticated()
            )
            // 인증이 필요하기 전에 헤더로 Authentication 먼저 만들어야 함
            .addFilterBefore(gatewayHeaderAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}