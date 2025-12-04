package com.lgcns.haibackend.capital.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CapitalRequestDTO {
    private String capitalName;
    private LocalDate startedDate;
    private LocalDate endedDate;
    private Double latitude;
    private Double longitude;
    private String description;
    private UUID countryId;
}
