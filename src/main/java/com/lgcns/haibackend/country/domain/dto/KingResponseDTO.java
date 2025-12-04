package com.lgcns.haibackend.country.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import com.lgcns.haibackend.country.domain.entity.KingEntity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class KingResponseDTO {
    private UUID kingId;
    private String kingName;
    private String regnalName;
    private LocalDate startedDate;
    private LocalDate endedDate;
    private UUID countryId;
    private String countryName;

    public static KingResponseDTO fromEntity(KingEntity entity) {
        return KingResponseDTO.builder()
                .kingId(entity.getKingId())
                .kingName(entity.getKingName())
                .regnalName(entity.getRegnalName())
                .startedDate(entity.getStartedDate())
                .endedDate(entity.getEndedDate())
                .countryId(entity.getCountry() != null ? entity.getCountry().getCountryId() : null)
                .countryName(entity.getCountry() != null ? entity.getCountry().getCountryName() : null)
                .build();
    }
}
