package com.lgcns.haibackend.capital.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;

public interface CapitalRepository extends JpaRepository<CapitalEntity, UUID> {
    
}
