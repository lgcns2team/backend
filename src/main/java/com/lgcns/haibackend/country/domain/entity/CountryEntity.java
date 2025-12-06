package com.lgcns.haibackend.country.domain.entity;

import java.util.List;
import java.util.UUID;


import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.lgcns.haibackend.war.domain.entity.WarEntity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;


@Getter
@Setter
@Entity
@Table(name = "Country")
public class CountryEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID countryId;
    private Integer countryCode;
    private String countryName;
    private String countryEnName;

    private Integer foundationYear;
    private Integer endedYear;

    private String title;

    private String summary;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String warHistory;

    @OneToMany(mappedBy = "country", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<CapitalEntity> capitals;

    @OneToMany(mappedBy = "country", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<MainEventEntity> events;

    @OneToMany(mappedBy = "startCountry", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<TradeEntity> startTrades;
  
    @OneToMany(mappedBy = "endCountry", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<TradeEntity> endTrades;
    
    @OneToMany(mappedBy = "attackCountry", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<WarEntity> attackWars;

    @OneToMany(mappedBy = "defenceCountry", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<WarEntity> defenceWars;

    @OneToMany(mappedBy = "country", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<KingEntity> kings;

    @OneToMany(mappedBy = "winnerCountry", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<WarEntity> winnerCountires;

}