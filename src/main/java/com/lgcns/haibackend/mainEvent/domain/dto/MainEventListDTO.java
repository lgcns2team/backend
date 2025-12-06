package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.Comparator;
import java.util.List;
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
    private String countryName;
    
    private String summary;
    private String type;

    private static final List<String> KOREAN_CORE_COUNTRIES = List.of(
        "고구려",
        "백제",
        "신라",
        "통일 신라",
        "발해",
        "후백제",
        "후고구려(태봉)",
        "고려",
        "조선"
    );

    // mainEventEntity -> dto
    public static MainEventListDTO fromEntity(MainEventEntity entity) {
        if (entity == null) return null;

        return MainEventListDTO.builder()
            .eventId(entity.getEventId())
            .eventName(entity.getEventName())
            .year(entity.getYear())
            .countryName(entity.getCountry().getCountryName())
            .summary(entity.getSummary())
            .type("MAIN_EVENT")
            .build();
    }

     // country -> dto (title 이 null x)
    public static MainEventListDTO fromCountry(CountryEntity country) {
        if (country == null) return null;

        if (country.getTitle() == null || country.getTitle().isBlank()) {
            return null;
        }

        return MainEventListDTO.builder()
            .eventId(country.getCountryId())
            .eventName(country.getTitle())
            .year(country.getFoundationYear())
            .countryName(country.getCountryName())
            .summary(country.getSummary())
            .type("COUNTRY")
            .build();
    }

    // capital -> dto (title 이 null x)
    public static MainEventListDTO fromCapital(CapitalEntity capital) {
        if (capital == null) return null;

        if (capital.getTitle() == null || capital.getTitle().isBlank()) {
            return null;
        }

        Integer year = null;
        if (capital.getStartedDate() != null) {
            year = capital.getStartedDate().getYear();
        }

        return MainEventListDTO.builder()
            .eventId(capital.getCapitalId())
            .eventName(capital.getTitle())                         
            .year(year)
            .countryName(capital.getCountry().getCountryName())
            .summary(capital.getSummary())
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

        String countryName = resolveWarCountryName(war);

        return MainEventListDTO.builder()
            .eventId(war.getWarId())
            .eventName(war.getName())
            .year(year)
            .countryName(countryName)
            .summary(war.getSummary())
            .type("WAR")
            .build();
    }

    private static String resolveWarCountryName(WarEntity war) {
        CountryEntity attack  = war.getAttackCountry();
        CountryEntity defence = war.getDefenceCountry();
        CountryEntity winner  = war.getWinnerCountry();

        String attackName  = (attack  != null ? attack.getCountryName()  : null);
        String defenceName = (defence != null ? defence.getCountryName() : null);
        String winnerName  = (winner  != null ? winner.getCountryName()  : null);

        boolean attackKorean  = isKoreanCountry(attack);
        boolean defenceKorean = isKoreanCountry(defence);

        if (!attackKorean && !defenceKorean) {
            return null;
        }

        if (attackKorean && defenceKorean) {
            if (winner != null && isKoreanCountry(winner) && winnerName != null) {
                return winnerName;
            }
            // 승리국이 없는 경우
            if (defenceName != null) return defenceName;
            if (attackName  != null) return attackName;
            return null;
        }

        if (attackKorean) {
            return attackName;
        }
        if (defenceKorean) {
            return defenceName;
        }

        return null;
    }

    // 특정 CountryEntity가 핵심 국가인지
    private static boolean isKoreanCountry(CountryEntity country) {
        if (country == null || country.getCountryName() == null) return false;
        return KOREAN_CORE_COUNTRIES.contains(country.getCountryName());
    }

    public static Comparator<MainEventListDTO> defaultComparator() {
    return Comparator
        .comparing(MainEventListDTO::getYear, Comparator.nullsLast(Integer::compareTo))
        .thenComparing(MainEventListDTO::getEventName, Comparator.nullsLast(String::compareTo));
    }

    
}
