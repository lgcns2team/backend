package com.lgcns.haibackend.capital.domain.entity;

import java.time.LocalDate;
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
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "Capital")
public class CapitalEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID capitalId;

    private String capitalName;
    private LocalDate startedDate;
    private LocalDate endedDate;
    private Double latitude;
    private Double longitude;
    private String summary;

    @Column(columnDefinition = "TEXT")
    private String description;

    // 국가 fk 매핑
    @ManyToOne
    @JoinColumn(name = "country_id")
    private CountryEntity country;


}
