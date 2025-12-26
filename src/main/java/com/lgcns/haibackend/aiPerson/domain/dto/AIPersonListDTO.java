package com.lgcns.haibackend.aiPerson.domain.dto;

import com.lgcns.haibackend.aiPerson.domain.entity.AIPersonEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class AIPersonListDTO {

    private String promptId;
    private String name;
    private String era;
    private Integer year;
    private Integer deathYear;
    private Double latitude;
    private Double longitude;
    private String summary;

    public static AIPersonListDTO fromEntity(AIPersonEntity entity) {
        return AIPersonListDTO.builder()
                .promptId(entity.getPromptId())
                .name(entity.getName())
                .era(entity.getEra())
                .year(entity.getYear())
                .deathYear(entity.getDeathYear())
                .latitude(entity.getLatitude())
                .longitude(entity.getLongitude())
                .summary(entity.getSummary())
                .build();
    }
}
