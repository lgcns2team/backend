package com.lgcns.haibackend.country.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.domain.dto.KingRequestDTO;
import com.lgcns.haibackend.country.domain.dto.KingResponseDTO;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.domain.entity.KingEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.country.repository.KingRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class KingService {
    
    private final KingRepository kingRepository;
    private final CountryRepository countryRepository;

    public List<KingResponseDTO> getAllKings() {
        return kingRepository.findAll().stream()
                .map(KingResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public KingResponseDTO getKingById(UUID id) {
        KingEntity king = kingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("King not found with id: " + id));
        return KingResponseDTO.fromEntity(king);
    }

    @Transactional
    public KingResponseDTO createKing(KingRequestDTO requestDTO) {
        CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + requestDTO.getCountryId()));

        KingEntity king = KingEntity.builder()
                .kingName(requestDTO.getKingName())
                .regnalName(requestDTO.getRegnalName())
                .startedDate(requestDTO.getStartedDate())
                .endedDate(requestDTO.getEndedDate())
                .country(country)
                .build();

        KingEntity savedKing = kingRepository.save(king);
        return KingResponseDTO.fromEntity(savedKing);
    }

    @Transactional
    public KingResponseDTO updateKing(UUID id, KingRequestDTO requestDTO) {
        KingEntity king = kingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("King not found with id: " + id));

        CountryEntity country = countryRepository.findById(requestDTO.getCountryId())
                .orElseThrow(() -> new RuntimeException("Country not found with id: " + requestDTO.getCountryId()));

        king.setKingName(requestDTO.getKingName());
        king.setRegnalName(requestDTO.getRegnalName());
        king.setStartedDate(requestDTO.getStartedDate());
        king.setEndedDate(requestDTO.getEndedDate());
        king.setCountry(country);

        return KingResponseDTO.fromEntity(king);
    }

    @Transactional
    public void deleteKing(UUID id) {
        if (!kingRepository.existsById(id)) {
            throw new RuntimeException("King not found with id: " + id);
        }
        kingRepository.deleteById(id);
    }
}
