package com.lgcns.haibackend.mainEvent.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;

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

   private String description;
   private String summary;
   public MainEventEntity toEntity(CountryEntity countryEntity) {
      if (countryEntity == null) {
         // Country Entity가 없는 경우 유효성 검사
         throw new IllegalArgumentException("Country Entity가 유효하지 않아 MainEventEntity를 생성할 수 없습니다.");
      }

      // MainEventEntity의 builder를 사용하여 객체 생성
      return MainEventEntity.builder()
            .eventName(this.eventName)
            .year(this.year)
            .description(this.description)
            .summary(this.summary)
            .country(countryEntity)
            .build();
   }
}