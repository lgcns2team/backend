package com.lgcns.haibackend.traderoute.domain.dto;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;
import com.lgcns.haibackend.traderoute.domain.entity.TradeRouteEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TradeRouteRequestDTO {
    
    private UUID tradeId;
    private Integer tags; // 0=육상, 1=해상
    private List<MarkerDTO> path; // marker + route 구조

    public TradeRouteEntity toEntity(TradeEntity trade) {
        return TradeRouteEntity.builder()
            .trade(trade)
            .path(convertPathToJson(path))
            .build();
    }

    private String convertPathToJson(List<MarkerDTO> path) {
       try {
        return new ObjectMapper().writeValueAsString(path);
       } catch (Exception e) {
        throw new RuntimeException("Failed to convert path to JSON", e);
       }
    }
}
