package com.lgcns.haibackend.trade.domain.dto;

import com.lgcns.haibackend.trade.domain.entity.TradeEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TradeResponseDTO {
    private Long tradeId;
    private Long startCountryId;
    private Long endCountryId;
    private Integer tradeYear;
    private String product;

    public static TradeResponseDTO fromEntity(TradeEntity trade) {
        return TradeResponseDTO.builder()
            .tradeId(trade.getTradeId())
            .startCountryId(trade.getStartCountry().getCountryId())
            .endCountryId(trade.getEndCountry().getCountryId())
            .tradeYear(trade.getTradeYear())
            .product(trade.getProduct())
            .build();
    }
}
