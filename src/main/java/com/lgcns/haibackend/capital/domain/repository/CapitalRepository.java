package com.lgcns.haibackend.capital.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;

@Repository
public interface CapitalRepository extends JpaRepository<CapitalEntity, Long> {
    
}
