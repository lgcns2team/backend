package com.lgcns.haibackend.capital.controller;

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

import com.lgcns.haibackend.capital.domain.dto.CapitalRequestDTO;
import com.lgcns.haibackend.capital.domain.dto.CapitalResponseDTO;
import com.lgcns.haibackend.capital.service.CapitalService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/capitals")
@RequiredArgsConstructor
public class CapitalController {
    
    private final CapitalService capitalService;

    @GetMapping
    public ResponseEntity<List<CapitalResponseDTO>> getAllCapitals() {
        List<CapitalResponseDTO> capitals = capitalService.getAllCapitals();
        return ResponseEntity.ok(capitals);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CapitalResponseDTO> getCapitalById(@PathVariable UUID id) {
        CapitalResponseDTO capital = capitalService.getCapitalById(id);
        return ResponseEntity.ok(capital);
    }

    @PostMapping
    public ResponseEntity<CapitalResponseDTO> createCapital(@RequestBody CapitalRequestDTO requestDTO) {
        CapitalResponseDTO createdCapital = capitalService.createCapital(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCapital);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CapitalResponseDTO> updateCapital(
            @PathVariable UUID id,
            @RequestBody CapitalRequestDTO requestDTO) {
        CapitalResponseDTO updatedCapital = capitalService.updateCapital(id, requestDTO);
        return ResponseEntity.ok(updatedCapital);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCapital(@PathVariable UUID id) {
        capitalService.deleteCapital(id);
        return ResponseEntity.noContent().build();
    }
}
