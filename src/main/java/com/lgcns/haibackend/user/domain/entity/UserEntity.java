package com.lgcns.haibackend.user.domain.entity;

import com.lgcns.haibackend.discussion.domain.entity.DebateRoomEntity;
import com.lgcns.haibackend.global.Role;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.CascadeType;
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

    // 토론, AI챗봇, 교과서 그리기 연결 필요

    @OneToMany(mappedBy = "teacher", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DebateRoomEntity> debateRooms = new ArrayList<>();
}
