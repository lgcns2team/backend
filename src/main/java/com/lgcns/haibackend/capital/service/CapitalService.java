package com.lgcns.haibackend.capital.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.capital.domain.dto.CapitalRequestDTO;
import com.lgcns.haibackend.capital.domain.dto.CapitalResponseDTO;
import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.capital.repository.CapitalRepository;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CapitalService {
    
    private final CapitalRepository capitalRepository;
    private final CountryRepository countryRepository;

    public List<CapitalResponseDTO> getAllCapitals() {
        return capitalRepository.findAll().stream()
                .map(CapitalResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public CapitalResponseDTO getCapitalById(UUID id) {
        CapitalEntity capital = capitalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Capital not found with id: " + id));
        return CapitalResponseDTO.fromEntity(capital);
    }

    @Transactional
    public CapitalResponseDTO createCapital(CapitalRequestDTO requestDTO) {
        CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + requestDTO.getCountryId()));

        CapitalEntity capital = CapitalEntity.builder()
                .capitalName(requestDTO.getCapitalName())
                .startedDate(requestDTO.getStartedDate())
                .endedDate(requestDTO.getEndedDate())
                .latitude(requestDTO.getLatitude())
                .longitude(requestDTO.getLongitude())
                .description(requestDTO.getDescription())
                .country(country)
                .build();

        CapitalEntity savedCapital = capitalRepository.save(capital);
        return CapitalResponseDTO.fromEntity(savedCapital);
    }

    @Transactional
    public CapitalResponseDTO updateCapital(UUID id, CapitalRequestDTO requestDTO) {
        CapitalEntity capital = capitalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Capital not found with id: " + id));

        CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + requestDTO.getCountryId()));

        capital.setCapitalName(requestDTO.getCapitalName());
        capital.setStartedDate(requestDTO.getStartedDate());
        capital.setEndedDate(requestDTO.getEndedDate());
        capital.setLatitude(requestDTO.getLatitude());
        capital.setLongitude(requestDTO.getLongitude());
        capital.setDescription(requestDTO.getDescription());
        capital.setCountry(country);

        return CapitalResponseDTO.fromEntity(capital);
    }

    @Transactional
    public void deleteCapital(UUID id) {
        if (!capitalRepository.existsById(id)) {
            throw new RuntimeException("Capital not found with id: " + id);
        }
        capitalRepository.deleteById(id);
    }
}
