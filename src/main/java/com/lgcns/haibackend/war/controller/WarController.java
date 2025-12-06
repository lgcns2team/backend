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
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.war.domain.dto.WarRequestDTO;
import com.lgcns.haibackend.war.domain.dto.WarResponseDTO;
import com.lgcns.haibackend.war.service.WarService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/wars")
@RequiredArgsConstructor
public class WarController {

    private final WarService warService;

    // 모든 전쟁 조회
    @GetMapping
    public ResponseEntity<List<WarResponseDTO>> getAllWars() {
        List<WarResponseDTO> wars = warService.getAllWars();
        return ResponseEntity.ok(wars);
    }

    // 연도별 전쟁 조회
    @GetMapping("/{year}")
    public ResponseEntity<List<WarResponseDTO>> getWarsByYear(@PathVariable int year) {
        List<WarResponseDTO> wars = warService.getWarsByYear(year);
        return ResponseEntity.ok(wars);
    }

    // 국가별 전쟁 히스토리 조회
    @GetMapping("/history/{countryCode}")
    public ResponseEntity<?> getWarHistoryByCountryCode(@PathVariable Integer countryCode) {
        return ResponseEntity.ok(warService.getWarHistoryByCountryCode(countryCode));
    }

    // 추가 확장 가능성
    // 전쟁 생성
    @PostMapping
    public ResponseEntity<WarResponseDTO> createWar(@RequestBody WarRequestDTO requestDTO) {
        WarResponseDTO createdWar = warService.createWar(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdWar);
    }


    // 전쟁 수정
    @PutMapping("/{warId}")
    public ResponseEntity<WarResponseDTO> updateWar(
            @PathVariable UUID warId,
            @RequestBody WarRequestDTO requestDTO) {
        WarResponseDTO updatedWar = warService.updateWar(warId, requestDTO);
        return ResponseEntity.ok(updatedWar);
    }

    // 전쟁 삭제
    @DeleteMapping("/{warId}")
    public ResponseEntity<Void> deleteWar(@PathVariable UUID warId) {
        warService.deleteWar(warId);
        return ResponseEntity.noContent().build();
    }
}
