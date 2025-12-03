package com.lgcns.haibackend.war.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lgcns.haibackend.war.domain.entity.BattleEntity;

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
public class BattleResponseDTO {
    
    private UUID battleId;
    private String battleName;
    private String details;
    private Double latitude;
    private Double longitude;
    private String winnerGeneral;
    private String loserGeneral;
    private LocalDate battleDate;
    private JsonNode markerRoute;  // JSON object
    
    private UUID warId;
    private String warName;

    // Entity -> DTO
    public static BattleResponseDTO fromEntity(BattleEntity entity) {
        if (entity == null) return null;

        JsonNode routeJson = null;
        if (entity.getMarkerRoute() != null) {
            try {
                ObjectMapper mapper = new ObjectMapper();
                routeJson = mapper.readTree(entity.getMarkerRoute());
            } catch (Exception e) {
                // JSON 파싱 실패 시 null
            }
        }

        return BattleResponseDTO.builder()
            .battleId(entity.getBattleId())
            .battleName(entity.getBattleName())
            .details(entity.getDetails())
            .latitude(entity.getLatitude())
            .longitude(entity.getLongitude())
            .winnerGeneral(entity.getWinnerGeneral())
            .loserGeneral(entity.getLoserGeneral())
            .battleDate(entity.getBattleDate())
            .markerRoute(routeJson)
            .warId(entity.getWar().getWarId())
            .warName(entity.getWar().getName())
            .build();
    }

    // Entity -> DTO (war 정보 제외)
    public static BattleResponseDTO fromEntityWithoutWar(BattleEntity entity) {
        if (entity == null) return null;

        JsonNode routeJson = null;
        if (entity.getMarkerRoute() != null) {
            try {
                ObjectMapper mapper = new ObjectMapper();
                routeJson = mapper.readTree(entity.getMarkerRoute());
            } catch (Exception e) {
                // JSON 파싱 실패 시 null
            }
        }

        return BattleResponseDTO.builder()
            .battleId(entity.getBattleId())
            .battleName(entity.getBattleName())
            .details(entity.getDetails())
            .latitude(entity.getLatitude())
            .longitude(entity.getLongitude())
            .winnerGeneral(entity.getWinnerGeneral())
            .loserGeneral(entity.getLoserGeneral())
            .battleDate(entity.getBattleDate())
            .markerRoute(routeJson)
            .build();
    }
}
