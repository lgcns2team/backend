package com.lgcns.haibackend;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;

@Component
public class DbConnectionChecker {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @PostConstruct
    public void checkConnection() {
        System.out.println("====================================");
        System.out.println(">>>> PostgreSQL 연결 테스트 시작");

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            System.out.println("PostgreSQL 연결 성공!");
            System.out.println(" - URL: " + url);
            System.out.println(" - USER: " + username);
        } catch (Exception e) {
            System.out.println("PostgreSQL 연결 실패!");
            e.printStackTrace();
        }

        System.out.println("====================================");
    }
}
