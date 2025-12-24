package com.lgcns.haibackend.discussion.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lgcns.haibackend.discussion.domain.entity.DebateRoomEntity;

public interface DebateRoomRepository extends JpaRepository<DebateRoomEntity, UUID> {
    List<DebateRoomEntity> findByTeacherCodeOrderByCreatedAtDesc(Integer teacherCode);

    List<DebateRoomEntity> findByTeacherCodeAndGradeOrderByCreatedAtDesc(Integer teacherCode, Integer grade);
}
