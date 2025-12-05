package com.lgcns.haibackend.traderoute.domain.dto;

import java.util.UUID;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.traderoute.domain.entity.TradeRouteEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TradeRouteResponseDTO {
    
    private UUID routeId;
    private UUID tradeId;
    private JsonNode path;
    private String routeColor; // 경로 색상

    public static TradeRouteResponseDTO fromEntity(TradeRouteEntity entity) {
        return TradeRouteResponseDTO.builder()
            .routeId(entity.getRouteId())
            .tradeId(entity.getTrade().getTradeId())
            .path(fromJson(entity.getPath()))
            .routeColor(entity.getRouteColor())
            .build();
    }

    private static JsonNode fromJson(String json) {
        try{
            ObjectMapper mapper = new ObjectMapper();
            return mapper.readTree(json);
        } catch (Exception e) {
            throw new RuntimeException("JSON 파싱 실패: " + e.getMessage() + ", JSON: " + json, e);
        }
    }



    
}
