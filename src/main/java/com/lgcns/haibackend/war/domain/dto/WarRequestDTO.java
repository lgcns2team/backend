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
public class WarRequestDTO {
    
    private String name;
    private String details;
    private LocalDate warStartDate;
    private LocalDate warEndDate;
    private String result;
    private String summary;
    private UUID attackCountryId;
    private UUID defenceCountryId;
}
