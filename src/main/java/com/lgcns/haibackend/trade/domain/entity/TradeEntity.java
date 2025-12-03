package com.lgcns.haibackend.trade.domain.entity;

import java.util.List;
import java.util.UUID;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.traderoute.domain.entity.TradeRouteEntity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
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

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "trade")
public class TradeEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID tradeId;

    @ManyToOne
    @JoinColumn(name = "start_country_id")
    private CountryEntity startCountry;

    @ManyToOne
    @JoinColumn(name = "end_country_id")
    private CountryEntity endCountry;

    private Integer tradeYear;
    private String product;

    @OneToMany(mappedBy = "trade", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<TradeRouteEntity> routes;
    
}
