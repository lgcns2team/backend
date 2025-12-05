package com.lgcns.haibackend.war.domain.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;


import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
// @ToString(exclude = {"attackCountry", "defenceCountry"})
@ToString

@Table(name = "war")
public class WarEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID warId;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    private LocalDate warStartDate;
    private LocalDate warEndDate;

    private String result;

    @Column(columnDefinition = "TEXT")
    private String summary;

    @OneToMany(mappedBy = "war", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    @Builder.Default
    private List<BattleEntity> battles = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "attack_country_id", nullable = false)
    private CountryEntity attackCountry;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "defence_country_id", nullable = false)
    private CountryEntity defenceCountry;

}
