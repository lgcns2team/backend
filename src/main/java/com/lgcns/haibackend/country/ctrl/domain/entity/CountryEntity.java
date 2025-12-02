package com.lgcns.haibackend.country.ctrl.domain.entity;

import java.util.List;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.mainevent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;

import jakarta.persistence.CascadeType;
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
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto incerment
    private Long countryId;

    private String countryName;
    private Integer foundationYear;
    private Integer endedYear;

    @OneToMany(mappedBy = "country", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<CapitalEntity> capitals;

    @OneToMany(mappedBy = "country", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<MainEventEntity> events;

    @OneToMany(mappedBy = "startCountry", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<TradeEntity> startTrades;

    @OneToMany(mappedBy = "endCountry", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<TradeEntity> endTrades;
}