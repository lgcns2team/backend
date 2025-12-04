package com.lgcns.haibackend.mainEvent.domain.entity;

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
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "mainEvent")
@Getter
@Setter
@Builder
public class MainEventEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID eventId;

    private String eventName;
    private Integer year;
    private String era;
    private String description;

    @ManyToOne
    @JoinColumn(name = "country_id")
    private CountryEntity country;

}
