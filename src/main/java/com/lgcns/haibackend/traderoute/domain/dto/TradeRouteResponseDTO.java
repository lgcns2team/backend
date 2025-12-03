package com.lgcns.haibackend.traderoute.domain.dto;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.core.type.TypeReference;
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
    private List<MarkerDTO> path; 

    public static TradeRouteResponseDTO fromEntity(TradeRouteEntity entity) {
        return new TradeRouteResponseDTO(
            entity.getRouteId(),
            entity.getTrade().getTradeId(),
            fromJson(entity.getPath())
        );
    }

    private static List<MarkerDTO> fromJson(String json) {
        try{
            ObjectMapper mapper = new ObjectMapper();
            return mapper.readValue(json, new TypeReference<List<MarkerDTO>>() {});
        } catch (Exception e) {
            throw new RuntimeException("JSON 파싱 실패");
        }
    }



    
}
