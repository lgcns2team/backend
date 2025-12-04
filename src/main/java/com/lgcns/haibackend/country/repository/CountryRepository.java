package com.lgcns.haibackend.country.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;

@Repository
public interface CountryRepository extends JpaRepository<CountryEntity, UUID> {
    
    @EntityGraph(attributePaths = {"capitals"})
    @Query("SELECT DISTINCT c FROM CountryEntity c")
    List<CountryEntity> findAllWithCapitals();
    
    /**
     * 타임라인용: kings를 로드 (capitals는 이미 로드된 상태)
     */
    @EntityGraph(attributePaths = {"kings"})
    @Query("SELECT DISTINCT c FROM CountryEntity c")
    List<CountryEntity> findAllWithKings();
}
