package com.lgcns.haibackend.war.domain.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.lgcns.haibackend.war.domain.entity.WarEntity;

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
public class WarResponseDTO {
    
    private UUID warId;
    private String name;
    private String description;
    private LocalDate warStartDate;
    private LocalDate warEndDate;
    private String result;
    private String summary;
    
    private UUID attackCountryId;
    private String attackCountryName;
    
    private UUID defenceCountryId;
    private String defenceCountryName;
    
    private List<BattleResponseDTO> battles;

    // Entity -> DTO
    public static WarResponseDTO fromEntity(WarEntity entity) {
        if (entity == null) return null;

        return WarResponseDTO.builder()
            .warId(entity.getWarId())
            .name(entity.getName())
            .description(entity.getDescription())
            .warStartDate(entity.getWarStartDate())
            .warEndDate(entity.getWarEndDate())
            .result(entity.getResult())
            .summary(entity.getSummary())
            .attackCountryId(entity.getAttackCountry().getCountryId())
            .attackCountryName(entity.getAttackCountry().getCountryName())
            .defenceCountryId(entity.getDefenceCountry().getCountryId())
            .defenceCountryName(entity.getDefenceCountry().getCountryName())
            .battles(entity.getBattles() != null ? 
                entity.getBattles().stream()
                    .map(BattleResponseDTO::fromEntity)
                    .collect(Collectors.toList()) : null)
            .build();
    }

    // Entity -> DTO (battles 제외)
    public static WarResponseDTO fromEntityWithoutBattles(WarEntity entity) {
        if (entity == null) return null;

        return WarResponseDTO.builder()
            .warId(entity.getWarId())
            .name(entity.getName())
            .description(entity.getDescription())
            .warStartDate(entity.getWarStartDate())
            .warEndDate(entity.getWarEndDate())
            .result(entity.getResult())
            .summary(entity.getSummary())
            .attackCountryId(entity.getAttackCountry().getCountryId())
            .attackCountryName(entity.getAttackCountry().getCountryName())
            .defenceCountryId(entity.getDefenceCountry().getCountryId())
            .defenceCountryName(entity.getDefenceCountry().getCountryName())
            .build();
    }
}
