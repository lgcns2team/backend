package com.lgcns.haibackend.trade.domain.entity;

import com.lgcns.haibackend.country.ctrl.domain.entity.CountryEntity;

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

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "trade")
public class TradeEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tradeId;

    @ManyToOne
    @JoinColumn(name = "start_country_id")
    private CountryEntity startCountryId;

    @ManyToOne
    @JoinColumn(name = "end_country_id")
    private CountryEntity endCountryId;

    private Integer tradeYear;
    private String product;
    
}
