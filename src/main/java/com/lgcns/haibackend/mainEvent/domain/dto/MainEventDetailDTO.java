package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MainEventDetailDTO {

    private UUID eventId;
    private String eventName;
    private Integer year;
    private String description;
    private String summary;
    private String countryName;

    public static MainEventDetailDTO fromEntity(MainEventEntity entity) {
        return MainEventDetailDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .description(entity.getDescription())
            .summary(entity.getSummary())
            .countryName(entity.getCountry().getCountryName())
            .build();
    }
}
