package com.lgcns.haibackend.discussion.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import com.lgcns.haibackend.user.domain.entity.UserEntity;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "debate_room")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DebateRoomEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID roomId; // 방ID (PK)

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt; // 생성일시

    @Column(name = "participant_count")
    private Integer participantCount; // 참가인원

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private UserEntity teacher;

    @Column(name = "topic_title", length = 255)
    private String topicTitle; // 주제이름

    @Column(name = "topic_description", length = 1000)
    private String topicDescription; // 주제설명

    @Column(name = "grade")
    private Integer grade; // 학년

    @Column(name = "classroom")
    private Integer classroom; // 반
    
    @Column(name = "teacher_code")
    private Integer teacherCode;

    @Column(name = "time")
    private Integer time; // 타이머

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        if (this.teacher != null) {
            this.teacherCode = this.teacher.getTeacherCode();
        }
    }


}