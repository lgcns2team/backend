package com.lgcns.haibackend.user.repository;


import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.user.domain.entity.UserEntity;


@Repository
public interface UserRepository extends JpaRepository<UserEntity, UUID> {

    public Optional<UserEntity> findByNicknameAndPassword(String nickname, String password);
    public Optional<UserEntity> findByUserId(UUID userId);
    
    // 코드가 이미 사용 중인지, 또는 존재하는지 확인하는 메서드 (Integer 타입으로 변경)
    public boolean existsByTeacherCodeAndRole(Integer teacherCode, Role role);
}
