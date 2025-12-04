package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MainEventResponseDTO {
    
    private UUID eventId;
    private String eventName;
    private Integer year;
    private String era;
    private String description;

    private UUID countryId;
    private String countryName;

    // entity -> dto
    public static MainEventResponseDTO fromEntity(MainEventEntity entity) {
        if (entity == null) return null;

        return MainEventResponseDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .era(entity.getEra())
            .description(entity.getDescription())
            .countryId(entity.getCountry().getCountryId())
            .countryName(entity.getCountry().getCountryName())
            .build();
    }

    
}
