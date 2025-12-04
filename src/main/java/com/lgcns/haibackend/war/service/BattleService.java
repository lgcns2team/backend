package com.lgcns.haibackend.war.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.war.domain.dto.BattleRequestDTO;
import com.lgcns.haibackend.war.domain.dto.BattleResponseDTO;
import com.lgcns.haibackend.war.domain.entity.BattleEntity;
import com.lgcns.haibackend.war.domain.entity.WarEntity;
import com.lgcns.haibackend.war.repository.BattleRepository;
import com.lgcns.haibackend.war.repository.WarRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BattleService {
    
    private final BattleRepository battleRepository;
    private final WarRepository warRepository;

    // 모든 전투 조회
    public List<BattleResponseDTO> getAllBattles() {
        return battleRepository.findAll().stream()
            .map(BattleResponseDTO::fromEntity)
            .collect(Collectors.toList());
    }

    // 전투 상세 조회
    public BattleResponseDTO getBattleById(UUID battleId) {
        BattleEntity battle = battleRepository.findById(battleId)
            .orElseThrow(() -> new RuntimeException("Battle not found with id: " + battleId));
        return BattleResponseDTO.fromEntity(battle);
    }

    // 전쟁별 전투 조회
    public List<BattleResponseDTO> getBattlesByWarId(UUID warId) {
        return battleRepository.findByWarWarId(warId).stream()
            .map(BattleResponseDTO::fromEntity)
            .collect(Collectors.toList());
    }

    // 전투명으로 검색
    public List<BattleResponseDTO> searchBattlesByName(String battleName) {
        return battleRepository.findByBattleNameContaining(battleName).stream()
            .map(BattleResponseDTO::fromEntity)
            .collect(Collectors.toList());
    }

    // 전투 생성
    @Transactional
    public BattleResponseDTO createBattle(BattleRequestDTO requestDTO) {
        WarEntity war = warRepository.findById(requestDTO.getWarId())
            .orElseThrow(() -> new RuntimeException("War not found"));

        BattleEntity battle = BattleEntity.builder()
            .battleName(requestDTO.getBattleName())
            .details(requestDTO.getDetails())
            .latitude(requestDTO.getLatitude())
            .longitude(requestDTO.getLongitude())
            .winnerGeneral(requestDTO.getWinnerGeneral())
            .loserGeneral(requestDTO.getLoserGeneral())
            .battleDate(requestDTO.getBattleDate())
            .markerRoute(requestDTO.getMarkerRoute())
            .war(war)
            .build();

        BattleEntity savedBattle = battleRepository.save(battle);
        return BattleResponseDTO.fromEntity(savedBattle);
    }

    // 전투 수정
    @Transactional
    public BattleResponseDTO updateBattle(UUID battleId, BattleRequestDTO requestDTO) {
        BattleEntity battle = battleRepository.findById(battleId)
            .orElseThrow(() -> new RuntimeException("Battle not found with id: " + battleId));

        if (requestDTO.getBattleName() != null) {
            battle.setBattleName(requestDTO.getBattleName());
        }
        if (requestDTO.getDetails() != null) {
            battle.setDetails(requestDTO.getDetails());
        }
        if (requestDTO.getLatitude() != null) {
            battle.setLatitude(requestDTO.getLatitude());
        }
        if (requestDTO.getLongitude() != null) {
            battle.setLongitude(requestDTO.getLongitude());
        }
        if (requestDTO.getWinnerGeneral() != null) {
            battle.setWinnerGeneral(requestDTO.getWinnerGeneral());
        }
        if (requestDTO.getLoserGeneral() != null) {
            battle.setLoserGeneral(requestDTO.getLoserGeneral());
        }
        if (requestDTO.getBattleDate() != null) {
            battle.setBattleDate(requestDTO.getBattleDate());
        }
        if (requestDTO.getMarkerRoute() != null) {
            battle.setMarkerRoute(requestDTO.getMarkerRoute());
        }
        if (requestDTO.getWarId() != null) {
            WarEntity war = warRepository.findById(requestDTO.getWarId())
                .orElseThrow(() -> new RuntimeException("War not found"));
            battle.setWar(war);
        }

        return BattleResponseDTO.fromEntity(battle);
    }

    // 전투 삭제
    @Transactional
    public void deleteBattle(UUID battleId) {
        if (!battleRepository.existsById(battleId)) {
            throw new RuntimeException("Battle not found with id: " + battleId);
        }
        battleRepository.deleteById(battleId);
    }
}
