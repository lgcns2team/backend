package com.lgcns.haibackend.war.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.war.domain.entity.BattleEntity;

@Repository
public interface BattleRepository extends JpaRepository<BattleEntity, UUID> {
    
    List<BattleEntity> findByWarWarId(UUID warId);
    
    List<BattleEntity> findByBattleNameContaining(String battleName);
}
