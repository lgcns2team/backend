package com.lgcns.haibackend.war.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.war.domain.dto.BattleRequestDTO;
import com.lgcns.haibackend.war.domain.dto.BattleResponseDTO;
import com.lgcns.haibackend.war.service.BattleService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/battles")
@RequiredArgsConstructor
public class BattleController {
    
    private final BattleService battleService;

    // 모든 전투 조회
    @GetMapping
    public ResponseEntity<List<BattleResponseDTO>> getAllBattles() {
        List<BattleResponseDTO> battles = battleService.getAllBattles();
        return ResponseEntity.ok(battles);
    }

    // 전투 상세 조회
    @GetMapping("/{battleId}")
    public ResponseEntity<BattleResponseDTO> getBattleById(@PathVariable UUID battleId) {
        BattleResponseDTO battle = battleService.getBattleById(battleId);
        return ResponseEntity.ok(battle);
    }

    // 전쟁별 전투 조회
    @GetMapping("/war/{warId}")
    public ResponseEntity<List<BattleResponseDTO>> getBattlesByWarId(@PathVariable UUID warId) {
        List<BattleResponseDTO> battles = battleService.getBattlesByWarId(warId);
        return ResponseEntity.ok(battles);
    }

    // 전투명으로 검색
    @GetMapping("/search")
    public ResponseEntity<List<BattleResponseDTO>> searchBattles(
            @RequestParam String name) {
        List<BattleResponseDTO> battles = battleService.searchBattlesByName(name);
        return ResponseEntity.ok(battles);
    }

    // 전투 생성
    @PostMapping
    public ResponseEntity<BattleResponseDTO> createBattle(@RequestBody BattleRequestDTO requestDTO) {
        BattleResponseDTO createdBattle = battleService.createBattle(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdBattle);
    }

    // 전투 수정
    @PutMapping("/{battleId}")
    public ResponseEntity<BattleResponseDTO> updateBattle(
            @PathVariable UUID battleId,
            @RequestBody BattleRequestDTO requestDTO) {
        BattleResponseDTO updatedBattle = battleService.updateBattle(battleId, requestDTO);
        return ResponseEntity.ok(updatedBattle);
    }

    // 전투 삭제
    @DeleteMapping("/{battleId}")
    public ResponseEntity<Void> deleteBattle(@PathVariable UUID battleId) {
        battleService.deleteBattle(battleId);
        return ResponseEntity.noContent().build();
    }
}
