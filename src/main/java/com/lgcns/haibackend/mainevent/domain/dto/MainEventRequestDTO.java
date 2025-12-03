package com.lgcns.haibackend.mainevent.domain.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
public class MainEventRequestDTO {
   private Long countryId;
   private String eventName;
   private Integer year;
   private String era;

   private String description;
}