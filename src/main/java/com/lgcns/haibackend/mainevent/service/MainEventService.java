package com.lgcns.haibackend.mainEvent.service;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventDetailDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventListDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventRequestDTO;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.mainEvent.repository.MainEventRepository;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MainEventService {
    
    private final MainEventRepository mainEventRepository;
    private final CountryRepository countryRepository;

    public List<MainEventListDTO> getMainEvents() {
        List<MainEventEntity> entities =
            mainEventRepository.findAllByOrderByYearAscEventNameAsc();

        return entities.stream()
            .map(MainEventListDTO::fromEntity)
            .toList();
    }

    public MainEventDetailDTO getMainEventDetail(UUID eventId) {
        MainEventEntity entity = mainEventRepository.findById(eventId)
            .orElseThrow(() -> new EntityNotFoundException("MainEvent not found: " + eventId));

        return MainEventDetailDTO.fromEntity(entity);
    }

    @Transactional
    public MainEventDetailDTO createMainEvent(MainEventRequestDTO requestDTO) {
        CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
            .orElseThrow(() -> new EntityNotFoundException(
                "Country not found: " + requestDTO.getCountryId()
            ));

        MainEventEntity entity = MainEventEntity.builder()
            .eventName(requestDTO.getEventName())
            .year(requestDTO.getYear())
            .era(requestDTO.getEra())
            .description(requestDTO.getDescription())
            .country(country)
            .build();

        MainEventEntity saved = mainEventRepository.save(entity);

        return MainEventDetailDTO.fromEntity(saved);
    }

    @Transactional
    public MainEventDetailDTO updateMainEvent(UUID eventId, MainEventRequestDTO requestDTO) {
        MainEventEntity entity = mainEventRepository.findById(eventId)
            .orElseThrow(() -> new EntityNotFoundException("MainEvent not found: " + eventId));

        if (requestDTO.getCountryId() != null &&
            (entity.getCountry() == null ||
             !entity.getCountry().getCountryId().equals(requestDTO.getCountryId()))) {

            CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
                .orElseThrow(() -> new EntityNotFoundException(
                    "Country not found: " + requestDTO.getCountryId()
                ));
            entity.setCountry(country);
        }

        if (requestDTO.getEventName() != null) {
            entity.setEventName(requestDTO.getEventName());
        }
        if (requestDTO.getYear() != null) {
            entity.setYear(requestDTO.getYear());
        }
        if (requestDTO.getEra() != null) {
            entity.setEra(requestDTO.getEra());
        }
        if (requestDTO.getDescription() != null) {
            entity.setDescription(requestDTO.getDescription());
        }

        return MainEventDetailDTO.fromEntity(entity);
    }

    @Transactional
    public void deleteMainEvent(UUID eventId) {
        MainEventEntity entity = mainEventRepository.findById(eventId)
            .orElseThrow(() -> new EntityNotFoundException("MainEvent not found: " + eventId));

        mainEventRepository.delete(entity);
    }

}
