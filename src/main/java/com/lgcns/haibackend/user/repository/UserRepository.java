package com.lgcns.haibackend.user.repository;


import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.user.domain.entity.UserClassInfo;
import com.lgcns.haibackend.user.domain.entity.UserEntity;


@Repository
public interface UserRepository extends JpaRepository<UserEntity, UUID> {

    public Optional<UserEntity> findByNicknameAndPassword(String nickname, String password);
    public Optional<UserEntity> findByUserId(UUID userId);
    public Optional<UserEntity> findByNickname(String nickname);
    public boolean existsByNickname(String nickname);
    // 코드가 이미 사용 중인지, 또는 존재하는지 확인하는 메서드 (Integer 타입으로 변경)
    public boolean existsByTeacherCodeAndRole(Integer teacherCode, Role role);

    public Optional<UserEntity> findByNameAndPassword(String name, String password);

    @Query("select u.teacherCode from UserEntity u where u.userId = :userId")
    Integer findTeacherCodeByUserId(@Param("userId") UUID userId);

    @Query("select u.nickname from UserEntity u where u.userId = :userId")
    String findNickNameByUserId(@Param("userId") UUID userId);

    @Query("""
        select u.teacherCode as teacherCode,
            u.grade as grade,
            u.classroom as classroom,
            u.nickname as nickname
        from UserEntity u
        where u.userId = :userId
    """)
    UserClassInfo findClassInfoByUserId(@Param("userId") UUID userId);
}
