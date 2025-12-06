package com.lgcns.haibackend.mainEvent.domain.dto;

import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.war.domain.entity.WarEntity;

import java.util.UUID;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.global.enums.EraType;

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
    private EraType era;
    private String description;
    private String countryName;

    public static MainEventDetailDTO fromMainEvent(MainEventEntity entity) {
        return MainEventDetailDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .era(entity.getEra())
            .description(entity.getDescription())
            .countryName(entity.getCountry().getCountryName())
            .build();
    }

    public static MainEventDetailDTO fromCountry(CountryEntity entity) {
        Integer year = entity.getFoundationYear();
        return MainEventDetailDTO.builder()
            .eventId(entity.getCountryId())
            .eventName(entity.getTitle()) 
            .year(year)
            .era(entity.getEra())                        
            .description(entity.getDescription())
            .countryName(entity.getCountryName())
            .build();
    }

    // CAPITAL -> DTO
    public static MainEventDetailDTO fromCapital(CapitalEntity entity) {
        Integer year = null;
        if (entity.getStartedDate() != null) {
            year = entity.getStartedDate().getYear();
        }

        return MainEventDetailDTO.builder()
            .eventId(entity.getCapitalId())
            .eventName(entity.getTitle())
            .year(year)
            .era(null)
            .description(entity.getDescription()) 
            .countryName(entity.getCountry().getCountryName())
            .build();
    }

    // WAR -> DTO
    public static MainEventDetailDTO fromWar(WarEntity entity) {
        Integer year = null;
        if (entity.getWarStartDate() != null) {
            year = entity.getWarStartDate().getYear();
        }

        String countryName = MainEventListDTO.resolveWarCountryName(entity);

        return MainEventDetailDTO.builder()
            .eventId(entity.getWarId())
            .eventName(entity.getName())
            .year(year)
            .era(null)
            .description(entity.getDescription())
            .countryName(countryName)
            .build();
    }
}
