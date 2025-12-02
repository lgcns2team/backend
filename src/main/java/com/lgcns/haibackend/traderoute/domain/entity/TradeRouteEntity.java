package com.lgcns.haibackend.traderoute.domain.entity;

import com.lgcns.haibackend.trade.domain.entity.TradeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@Entity
@Table(name = "tradeRoute")
public class TradeRouteEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long routeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "trade_id")
    private TradeEntity trade;

    private Integer tags; // 0=육상, 1=해상

    @Column(columnDefinition = "jsonb")
    private String path; // db에는 json 문자열로 저장
}
