package com.lgcns.haibackend.country.domain.dto;

import java.time.LocalDate;
import java.util.UUID;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class KingRequestDTO {
    private String kingName;
    private String regnalName;
    private LocalDate startedDate;
    private LocalDate endedDate;
    private UUID countryId;
}
