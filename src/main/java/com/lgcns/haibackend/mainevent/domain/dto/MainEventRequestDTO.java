package com.lgcns.haibackend.mainevent.domain.dto;

import java.util.UUID;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
@Builder
public class MainEventRequestDTO {
   private UUID countryId;
   private String eventName;
   private Integer year;
   private String era;

   private String description;
}