package com.lgcns.haibackend.war.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.war.domain.entity.WarEntity;

@Repository
public interface WarRepository extends JpaRepository<WarEntity, UUID> {
    
}
