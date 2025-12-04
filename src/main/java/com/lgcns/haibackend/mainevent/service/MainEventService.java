package com.lgcns.haibackend.mainEvent.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventResponseDTO;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.mainEvent.repository.MainEventRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MainEventService {
    
    private final MainEventRepository mainEventRepository;
    private final CountryRepository countryRepository;

    public List<MainEventResponseDTO> getMainEvents() {
        List<MainEventEntity> entities =
            mainEventRepository.findAllByOrderByYearAscEventNameAsc();

        return entities.stream()
            .map(MainEventResponseDTO::fromEntity)
            .toList();
    }

}
