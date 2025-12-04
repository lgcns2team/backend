package com.lgcns.haibackend.country.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.country.domain.dto.CountryRequestDTO;
import com.lgcns.haibackend.country.domain.dto.CountryResponseDTO;
import com.lgcns.haibackend.country.service.CountryService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/countries")
@RequiredArgsConstructor
public class CountryController {
    
    private final CountryService countryService;

    // 모든 국가 조회
    @GetMapping
    public ResponseEntity<List<CountryResponseDTO>> getAllCountries() {
        List<CountryResponseDTO> countries = countryService.getAllCountries();
        return ResponseEntity.ok(countries);
    }

    // 국가 상세 조회
    @GetMapping("/{countryId}")
    public ResponseEntity<CountryResponseDTO> getCountryById(@PathVariable UUID countryId) {
        CountryResponseDTO country = countryService.getCountryById(countryId);
        return ResponseEntity.ok(country);
    }

    // 국가 생성
    @PostMapping
    public ResponseEntity<CountryResponseDTO> createCountry(@RequestBody CountryRequestDTO requestDTO) {
        CountryResponseDTO createdCountry = countryService.createCountry(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCountry);
    }

    // 국가 수정
    @PutMapping("/{countryId}")
    public ResponseEntity<CountryResponseDTO> updateCountry(
            @PathVariable UUID countryId,
            @RequestBody CountryRequestDTO requestDTO) {
        CountryResponseDTO updatedCountry = countryService.updateCountry(countryId, requestDTO);
        return ResponseEntity.ok(updatedCountry);
    }

    // 국가 삭제
    @DeleteMapping("/{countryId}")
    public ResponseEntity<Void> deleteCountry(@PathVariable UUID countryId) {
        countryService.deleteCountry(countryId);
        return ResponseEntity.noContent().build();
    }
}
