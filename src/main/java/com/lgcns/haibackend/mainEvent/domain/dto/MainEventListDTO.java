package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.global.enums.EraType;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MainEventListDTO {
    
    private UUID eventId;
    private String eventName;
    private Integer year;
    private String countryName;
    private EraType era;
    // entity -> dto
    public static MainEventListDTO fromEntity(MainEventEntity entity) {
        if (entity == null) return null;

        return MainEventListDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .era(entity.getEra())
            .countryName(entity.getCountry().getCountryName())
            .build();
    }

    
}
