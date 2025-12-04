package com.lgcns.haibackend.country.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lgcns.haibackend.country.domain.entity.KingEntity;

public interface KingRepository extends JpaRepository<KingEntity, UUID> {
    
}
