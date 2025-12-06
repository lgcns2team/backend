package com.lgcns.haibackend.country.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.global.enums.EraType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CountryResponseDTO {
    
    private UUID countryId;
    private String countryName;
    private Integer foundationYear;
    private Integer endedYear;
    private EraType era;

    // Entity -> DTO
    public static CountryResponseDTO fromEntity(CountryEntity entity) {
        if (entity == null) return null;

        return CountryResponseDTO.builder()
            .countryId(entity.getCountryId())
            .countryName(entity.getCountryName())
            .foundationYear(entity.getFoundationYear())
            .endedYear(entity.getEndedYear())
            .era(entity.getEra())
            .build();
    }
}
