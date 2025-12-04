package com.lgcns.haibackend.trade.domain.dto;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.lgcns.haibackend.country.domain.dto.CountryResponseDTO;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;
import com.lgcns.haibackend.traderoute.domain.dto.TradeRouteResponseDTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TradeResponseDTO {
    private UUID tradeId;
    private CountryResponseDTO startCountry;
    private CountryResponseDTO endCountry;
    private Integer tradeYear;
    private String product;
    private List<TradeRouteResponseDTO> routes;

    public static TradeResponseDTO fromEntity(TradeEntity entity) {
        return TradeResponseDTO.builder()
                .tradeId(entity.getTradeId())
                .startCountry(CountryResponseDTO.fromEntity(entity.getStartCountry()))
                .endCountry(CountryResponseDTO.fromEntity(entity.getEndCountry()))
                .tradeYear(entity.getTradeYear())
                .product(entity.getProduct())
                .routes(entity.getRoutes() != null 
                    ? entity.getRoutes().stream()
                        .map(TradeRouteResponseDTO::fromEntity)
                        .collect(Collectors.toList())
                    : null)
                .build();
    }
}
