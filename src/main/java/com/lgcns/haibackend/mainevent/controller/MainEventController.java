package com.lgcns.haibackend.mainEvent.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.mainEvent.domain.dto.MainEventResponseDTO;
import com.lgcns.haibackend.mainEvent.service.MainEventService;

@RestController
@RequestMapping("/api/main-event")
public class MainEventController {

    @Autowired
    private MainEventService mainEventService;
    
    // 주요 사건 전체 목록 조회
    @GetMapping
    public ResponseEntity<List<MainEventResponseDTO>> getMainEvents() {
        List<MainEventResponseDTO> response =
            mainEventService.getMainEvents();
        return ResponseEntity.ok(response);
    }
}
