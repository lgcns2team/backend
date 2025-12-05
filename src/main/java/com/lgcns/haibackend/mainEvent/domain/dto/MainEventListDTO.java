package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.war.domain.entity.WarEntity;

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
    private String era;
    private String countryName;
    private String summary;
    private String type;

    // entity -> dto
    public static MainEventListDTO fromEntity(MainEventEntity entity) {
        if (entity == null) return null;

        return MainEventListDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .era(entity.getEra())
            .countryName(entity.getCountry().getCountryName())
            .summary(entity.getSummary())
            .type("MAIN_EVENT")
            .build();
    }

     // country -> dto (title 이 null x)
    public static MainEventListDTO fromCountry(CountryEntity country) {
        if (country == null) return null;

        return MainEventListDTO.builder()
            .eventId(country.getCountryId())
            .eventName(country.getTitle())
            .year(country.getFoundationYear())
            .era(null)               
            .countryName(country.getCountryName())
            .summary(country.getSummary())
            .type("COUNTRY")
            .build();
    }

    // capital -> dto (title 이 null x)
    public static MainEventListDTO fromCapital(CapitalEntity capital) {
        if (capital == null) return null;

        Integer year = null;
        if (capital.getStartedDate() != null) {
            year = capital.getStartedDate().getYear();
        }

        return MainEventListDTO.builder()
            .eventId(null)
            .eventName(capital.getTitle())                         // 예: "고려 송악 천도"
            .year(year)
            .era(null)
            .countryName(capital.getCountry().getCountryName())    // 해당 국가 이름
            .type("CAPITAL")
            .build();
    }

    // war -> dto (전쟁 시작 연도 기준)
    public static MainEventListDTO fromWar(WarEntity war) {
        if (war == null) return null;

        Integer year = null;
        if (war.getWarStartDate() != null) {
            year = war.getWarStartDate().getYear();
        }

        // 어느 나라 이름을 쓸지 정책이 필요하지만,
        // 일단 방어국(defence)을 기준으로 표기한다고 가정
        String countryName = null;
        if (war.getDefenceCountry() != null) {
            countryName = war.getDefenceCountry().getCountryName();
        } else if (war.getAttackCountry() != null) {
            countryName = war.getAttackCountry().getCountryName();
        }

        return MainEventListDTO.builder()
            .eventId(null)
            .eventName(war.getName())   // "여요전쟁", "여몽전쟁" 등
            .year(year)
            .era(null)
            .countryName(countryName)
            .type("WAR")
            .build();
    }
    
}
