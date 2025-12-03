package com.lgcns.haibackend.war.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BattleRequestDTO {
    
    private String battleName;
    private String details;
    private Double latitude;
    private Double longitude;
    private String winnerGeneral;
    private String loserGeneral;
    private LocalDate battleDate;
    private String markerRoute;  // JSON string
    private UUID warId;
}
