package com.lgcns.haibackend.mainEvent.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.lgcns.haibackend.mainEvent.domain.dto.MainEventDetailDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventListDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventRequestDTO;
import com.lgcns.haibackend.mainEvent.service.MainEventService;

@RestController
@RequestMapping("/api/main-event")
public class MainEventController {

    @Autowired
    private MainEventService mainEventService;
    
    // 주요 사건 전체 목록 조회
    @GetMapping
    public ResponseEntity<List<MainEventListDTO>> getMainEvents() {
        List<MainEventListDTO> response =
            mainEventService.getMainEvents();
        if( response != null ) {
            return new ResponseEntity<>(response , HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // 주요 사건 상세 조회
    @GetMapping("/{eventId}")
    public ResponseEntity<MainEventDetailDTO> getMainEventDetail(
        @PathVariable UUID eventId
    ) {
        MainEventDetailDTO response = mainEventService.getMainEventDetail(eventId);
        if( response != null ) {
            return new ResponseEntity<>(response , HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // 주요 사건 생성
    @PostMapping
    public ResponseEntity<MainEventDetailDTO> createMainEvent(
        @RequestBody MainEventRequestDTO requestDTO
    ) {
        MainEventDetailDTO created = mainEventService.createMainEvent(requestDTO);
        if( created != null ) {
            return ResponseEntity.status(HttpStatus.CREATED).body(created);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // 주요 사건 수정
    @PutMapping("/{eventId}")
    public ResponseEntity<MainEventDetailDTO> updateMainEvent(
        @PathVariable UUID eventId,
        @RequestBody MainEventRequestDTO requestDTO
    ) {
        MainEventDetailDTO updated = mainEventService.updateMainEvent(eventId, requestDTO);
        if( updated != null ) {
            return ResponseEntity.status(HttpStatus.CREATED).body(updated);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // 주요 사건 삭제
    @DeleteMapping("/{eventId}")
    public ResponseEntity<Void> deleteMainEvent(
        @PathVariable UUID eventId
    ) {
        mainEventService.deleteMainEvent(eventId);
        return ResponseEntity.noContent().build();
    }
}
