package com.lgcns.haibackend.war.domain.dto;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class WarHistoryResponseDTO {
    private Integer countryCode;
    private String countryName;
    private String warHistory;

    public static WarHistoryResponseDTO fromEntity(CountryEntity entity) {
        if (entity == null) return null;

        return WarHistoryResponseDTO.builder()
            .countryCode(entity.getCountryCode())
            .countryName(entity.getCountryName())
            .warHistory(entity.getWarHistory())
            .build();
    }
}
