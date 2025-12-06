package com.lgcns.haibackend.country.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.domain.dto.CountryRequestDTO;
import com.lgcns.haibackend.country.domain.dto.CountryResponseDTO;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CountryService {
    
    private final CountryRepository countryRepository;

    // 모든 국가 조회
    public List<CountryResponseDTO> getAllCountries() {
        return countryRepository.findAll().stream()
            .map(CountryResponseDTO::fromEntity)
            .collect(Collectors.toList());
    }

    // 국가 코드로 국가 상세 조회
    public CountryResponseDTO getCountryByCode(Integer countryCode) {
        CountryEntity country = countryRepository.findByCountryCode(countryCode)
            .orElseThrow(() -> new RuntimeException("Country not found with code: " + countryCode));
        return CountryResponseDTO.fromEntity(country);
    }

    // 국가 생성
    @Transactional
    public CountryResponseDTO createCountry(CountryRequestDTO requestDTO) {
        CountryEntity country = new CountryEntity();
        country.setCountryName(requestDTO.getCountryName());
        country.setFoundationYear(requestDTO.getFoundationYear());
        country.setEndedYear(requestDTO.getEndedYear());
        country.setCountryCode(requestDTO.getCountryCode());

        CountryEntity savedCountry = countryRepository.save(country);
        return CountryResponseDTO.fromEntity(savedCountry);
    }

    // 국가 수정
    @Transactional
    public CountryResponseDTO updateCountry(UUID countryId, CountryRequestDTO requestDTO) {
        CountryEntity country = countryRepository.findById(countryId)
            .orElseThrow(() -> new RuntimeException("Country not found with id: " + countryId));

        if (requestDTO.getCountryName() != null) {
            country.setCountryName(requestDTO.getCountryName());
        }
        if (requestDTO.getFoundationYear() != null) {
            country.setFoundationYear(requestDTO.getFoundationYear());
        }
        if (requestDTO.getEndedYear() != null) {
            country.setEndedYear(requestDTO.getEndedYear());
        }

        return CountryResponseDTO.fromEntity(country);
    }

    // 국가 삭제
    @Transactional
    public void deleteCountry(UUID countryId) {
        if (!countryRepository.existsById(countryId)) {
            throw new RuntimeException("Country not found with id: " + countryId);
        }
        countryRepository.deleteById(countryId);
    }
}
