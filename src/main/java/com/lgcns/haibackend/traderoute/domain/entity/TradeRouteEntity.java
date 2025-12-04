package com.lgcns.haibackend.traderoute.domain.entity;

import java.util.UUID;

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
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tradeRoute")
public class TradeRouteEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID routeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "trade_id")
    private TradeEntity trade;

    @Column(columnDefinition = "jsonb")
    private String path; // db에는 json 문자열로 저장

    @Column(name = "route_color", length = 7)
    private String routeColor; // 경로 색상 (hex code, e.g., #3b82f6)
}
