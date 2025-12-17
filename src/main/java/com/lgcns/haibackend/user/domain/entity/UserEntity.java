package com.lgcns.haibackend.user.domain.entity;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.lgcns.haibackend.global.Role;

import java.time.LocalDateTime;
import java.util.UUID;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "users")
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID userId;

    private Integer teacherCode;

    @Column(nullable = true, updatable = true)
    private Integer grade;

    @Column(nullable = true, updatable = true)
    private Integer classroom;

    @Column(nullable = false, updatable = true)
    private Role role;

    @Column(nullable = false, updatable = true)
    private String name;
    
    @Column(nullable = false, updatable = true)
    private String password;

    @Column(nullable = false, updatable = true, unique = true)
    private String nickname;

    @Column
    private UUID classCode;

    // 토론, AI챗봇, 교과서 그리기 연결 필요
}
