package com.lgcns.haibackend.country.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;

@Repository
public interface CountryRepository extends JpaRepository<CountryEntity, UUID> {
    
}
