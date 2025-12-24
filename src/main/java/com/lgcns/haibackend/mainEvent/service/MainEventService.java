package com.lgcns.haibackend.mainEvent.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.capital.repository.CapitalRepository;
import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventDetailDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventListDTO;
import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.mainEvent.repository.MainEventRepository;
import com.lgcns.haibackend.war.domain.entity.WarEntity;
import com.lgcns.haibackend.war.repository.WarRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MainEventService {
    
    private final MainEventRepository mainEventRepository;
    private final CountryRepository countryRepository;
    private final CapitalRepository capitalRepository;
    private final WarRepository warRepository;

    public List<MainEventListDTO> getMainEvents() {
        // 1) main_event 테이블
        List<MainEventListDTO> mainEventList = mainEventRepository
            .findAllByOrderByYearAscEventNameAsc()
            .stream()
            .map(MainEventListDTO::fromEntity)
            .toList();

        // 2) capital 테이블 (title not null)
        List<MainEventListDTO> capitalEvents = capitalRepository.findAll()
            .stream()
            .map(MainEventListDTO::fromCapital)
            .filter(Objects::nonNull)
            .toList();

        // 3) war 테이블
        List<MainEventListDTO> warEvents = warRepository.findAll()
            .stream()
            .map(MainEventListDTO::fromWar)
            .filter(Objects::nonNull)
            .toList();

        // 4) 합치고 정렬
        List<MainEventListDTO> merged = new ArrayList<>();

        Stream.of(mainEventList, capitalEvents, warEvents)
            .forEach(merged::addAll);

        return merged.stream()
            .sorted(MainEventListDTO.defaultComparator())
            .toList();

    }

    public MainEventDetailDTO getDetail(String type, UUID eventId) {

        return switch (type) {
            case "MAIN_EVENT" -> {
                MainEventEntity entity = mainEventRepository.findById(eventId)
                    .orElseThrow(() -> new IllegalArgumentException("MainEvent not found: " + eventId));
                yield MainEventDetailDTO.fromMainEvent(entity);
            }

            case "CAPITAL" -> {
                CapitalEntity entity = capitalRepository.findById(eventId)
                    .orElseThrow(() -> new IllegalArgumentException("Capital not found: " + eventId));
                yield MainEventDetailDTO.fromCapital(entity);
            }

            case "WAR" -> {
                WarEntity entity = warRepository.findById(eventId)
                    .orElseThrow(() -> new IllegalArgumentException("War not found: " + eventId));
                yield MainEventDetailDTO.fromWar(entity);
            }

            default -> throw new IllegalArgumentException("Unsupported type: " + type);
        };
    }

}
