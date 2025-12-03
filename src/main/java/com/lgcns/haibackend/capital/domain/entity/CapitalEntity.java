package com.lgcns.haibackend.capital.domain.entity;

import java.util.Date;
import java.util.UUID;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Capital")
public class CapitalEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID capitalId;

    private String capitalName;
    private Date startedDate;
    private Date endedDate;

    // 국가 fk 매핑
    @ManyToOne
    @JoinColumn(name = "country_id")
    private CountryEntity country;


}
