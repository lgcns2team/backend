package com.lgcns.haibackend.war.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.war.domain.dto.WarHistoryResponseDTO;
import com.lgcns.haibackend.war.domain.dto.WarRequestDTO;
import com.lgcns.haibackend.war.domain.dto.WarResponseDTO;
import com.lgcns.haibackend.war.domain.entity.WarEntity;
import com.lgcns.haibackend.war.repository.WarRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class WarService {

    private final WarRepository warRepository;
    private final CountryRepository countryRepository;

    // 모든 전쟁 조회
    public List<WarResponseDTO> getAllWars() {
        return warRepository.findAll().stream()
                .map(WarResponseDTO::fromEntityWithoutBattles)
                .collect(Collectors.toList());
    }

    // 연도별 전쟁 조회
    public List<WarResponseDTO> getWarsByYear(int year) {
        List<WarEntity> wars = warRepository.findWarsByYear(year);
        
        // 다른 분류된 전쟁이 있는지 확인
        boolean hasClassifiedWar = wars.stream()
                .anyMatch(war -> !"기타/미분류 전쟁".equals(war.getName()));
        
        return wars.stream()
                // 다른 분류된 전쟁이 있으면 기타/미분류 전쟁 제외
                .filter(war -> !hasClassifiedWar || !"기타/미분류 전쟁".equals(war.getName()))
                .map(entity -> WarResponseDTO.fromEntity(entity, year))
                .collect(Collectors.toList());
    }

    // 국가별 전쟁 히스토리 조회
    public WarHistoryResponseDTO getWarHistoryByCountryCode(Integer countryCode) {
        CountryEntity country = countryRepository.findByCountryCode(countryCode)
                .orElseThrow(() -> new RuntimeException("Country not found with code: " + countryCode));
        return WarHistoryResponseDTO.fromEntity(country);
    }

    // 추가 확장 가능성
    // 전쟁 생성
    @Transactional
    public WarResponseDTO createWar(WarRequestDTO requestDTO) {
        CountryEntity attackCountry = countryRepository.findById(requestDTO.getAttackCountryId())
                .orElseThrow(() -> new RuntimeException("Attack country not found"));

        CountryEntity defenceCountry = countryRepository.findById(requestDTO.getDefenceCountryId())
                .orElseThrow(() -> new RuntimeException("Defence country not found"));

        WarEntity war = WarEntity.builder()
                .name(requestDTO.getName())
                .description(requestDTO.getDescription())
                .warStartDate(requestDTO.getWarStartDate())
                .warEndDate(requestDTO.getWarEndDate())
                .result(requestDTO.getResult())
                .summary(requestDTO.getSummary())
                .attackCountry(attackCountry)
                .defenceCountry(defenceCountry)
                .build();

        WarEntity savedWar = warRepository.save(war);
        return WarResponseDTO.fromEntityWithoutBattles(savedWar);
    }

    // 전쟁 수정
    @Transactional
    public WarResponseDTO updateWar(UUID warId, WarRequestDTO requestDTO) {
        WarEntity war = warRepository.findById(warId)
                .orElseThrow(() -> new RuntimeException("War not found with id: " + warId));

        if (requestDTO.getName() != null) {
            war.setName(requestDTO.getName());
        }
        if (requestDTO.getDescription() != null) {
            war.setDescription(requestDTO.getDescription());
        }
        if (requestDTO.getWarStartDate() != null) {
            war.setWarStartDate(requestDTO.getWarStartDate());
        }
        if (requestDTO.getWarEndDate() != null) {
            war.setWarEndDate(requestDTO.getWarEndDate());
        }
        if (requestDTO.getResult() != null) {
            war.setResult(requestDTO.getResult());
        }
        if (requestDTO.getSummary() != null) {
            war.setSummary(requestDTO.getSummary());
        }
        if (requestDTO.getAttackCountryId() != null) {
            CountryEntity attackCountry = countryRepository.findById(requestDTO.getAttackCountryId())
                    .orElseThrow(() -> new RuntimeException("Attack country not found"));
            war.setAttackCountry(attackCountry);
        }
        if (requestDTO.getDefenceCountryId() != null) {
            CountryEntity defenceCountry = countryRepository.findById(requestDTO.getDefenceCountryId())
                    .orElseThrow(() -> new RuntimeException("Defence country not found"));
            war.setDefenceCountry(defenceCountry);
        }

        return WarResponseDTO.fromEntityWithoutBattles(war);
    }

    // 전쟁 삭제
    @Transactional
    public void deleteWar(UUID warId) {
        if (!warRepository.existsById(warId)) {
            throw new RuntimeException("War not found with id: " + warId);
        }
        warRepository.deleteById(warId);
    }
}
