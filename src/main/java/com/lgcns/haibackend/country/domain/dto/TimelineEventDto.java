package com.lgcns.haibackend.country.domain.dto;

public record TimelineEventDto(
        int year,
        String countryName,
        String capitalName,
        Double capitalLatitude,
        Double capitalLongitude,
        String regnalName
) {}
