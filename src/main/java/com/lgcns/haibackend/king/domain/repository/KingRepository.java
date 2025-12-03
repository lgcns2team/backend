package com.lgcns.haibackend.king.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.king.domain.entity.KingEntity;

@Repository
public interface KingRepository extends JpaRepository<KingEntity, String> {
    
}
