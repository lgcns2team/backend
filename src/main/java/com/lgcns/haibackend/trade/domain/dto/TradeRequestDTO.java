package com.lgcns.haibackend.trade.domain.dto;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TradeRequestDTO {
    
    private Long startCountryId;
    private Long endCountryId;
    private Integer tradeYear;
    private String product;

    public TradeEntity toEntity() {
        TradeEntity trade = new TradeEntity();
        
        CountryEntity start = new CountryEntity();
        start.setCountryId(startCountryId);

        CountryEntity end = new CountryEntity();
        end.setCountryId(endCountryId);

        trade.setStartCountry(start);
        trade.setEndCountry(end);
        trade.setTradeYear(tradeYear);
        trade.setProduct(product);

        return trade;
    }
}
