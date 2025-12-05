package com.lgcns.haibackend.country.domain.dto;

import com.lgcns.haibackend.global.enums.EraType;

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
public class CountryRequestDTO {
    
    private String countryName;
    private Integer foundationYear;
    private Integer endedYear;
    private EraType era;
}
