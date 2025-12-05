package com.lgcns.haibackend.traderoute.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MarkerDTO {
    @JsonProperty("lat")
    private double latitude;
    
    @JsonProperty("lng")
    private double longitude;
}
