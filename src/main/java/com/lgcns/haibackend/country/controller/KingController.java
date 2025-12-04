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

import com.lgcns.haibackend.country.domain.dto.KingRequestDTO;
import com.lgcns.haibackend.country.domain.dto.KingResponseDTO;
import com.lgcns.haibackend.country.service.KingService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/kings")
@RequiredArgsConstructor
public class KingController {
    
    private final KingService kingService;

    @GetMapping
    public ResponseEntity<List<KingResponseDTO>> getAllKings() {
        List<KingResponseDTO> kings = kingService.getAllKings();
        return ResponseEntity.ok(kings);
    }

    @GetMapping("/{id}")
    public ResponseEntity<KingResponseDTO> getKingById(@PathVariable UUID id) {
        KingResponseDTO king = kingService.getKingById(id);
        return ResponseEntity.ok(king);
    }

    @PostMapping
    public ResponseEntity<KingResponseDTO> createKing(@RequestBody KingRequestDTO requestDTO) {
        KingResponseDTO createdKing = kingService.createKing(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdKing);
    }

    @PutMapping("/{id}")
    public ResponseEntity<KingResponseDTO> updateKing(
            @PathVariable UUID id,
            @RequestBody KingRequestDTO requestDTO) {
        KingResponseDTO updatedKing = kingService.updateKing(id, requestDTO);
        return ResponseEntity.ok(updatedKing);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteKing(@PathVariable UUID id) {
        kingService.deleteKing(id);
        return ResponseEntity.noContent().build();
    }
}
