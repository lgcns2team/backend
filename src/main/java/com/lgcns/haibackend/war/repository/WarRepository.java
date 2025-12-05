package com.lgcns.haibackend.war.repository;

import java.util.UUID;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.war.domain.entity.WarEntity;

@Repository
public interface WarRepository extends JpaRepository<WarEntity, UUID> {

    @Query("SELECT w FROM WarEntity w WHERE YEAR(w.warStartDate) <= :year AND (w.warEndDate IS NULL OR YEAR(w.warEndDate) >= :year)")
    List<WarEntity> findWarsByYear(@Param("year") int year);
}
