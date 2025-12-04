package com.lgcns.haibackend.capital.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CapitalResponseDTO {
    private UUID capitalId;
    private String capitalName;
    private LocalDate startedDate;
    private LocalDate endedDate;
    private Double latitude;
    private Double longitude;
    private String description;
    private UUID countryId;
    private String countryName;

    public static CapitalResponseDTO fromEntity(CapitalEntity entity) {
        return CapitalResponseDTO.builder()
                .capitalId(entity.getCapitalId())
                .capitalName(entity.getCapitalName())
                .startedDate(entity.getStartedDate())
                .endedDate(entity.getEndedDate())
                .latitude(entity.getLatitude())
                .longitude(entity.getLongitude())
                .description(entity.getDescription())
                .countryId(entity.getCountry() != null ? entity.getCountry().getCountryId() : null)
                .countryName(entity.getCountry() != null ? entity.getCountry().getCountryName() : null)
                .build();
    }
}
