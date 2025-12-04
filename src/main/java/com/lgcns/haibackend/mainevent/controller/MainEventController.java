package com.lgcns.haibackend.mainevent.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.mainevent.MainEventService;
import com.lgcns.haibackend.mainevent.domain.dto.MainEventResponseDTO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/main-events")
@RequiredArgsConstructor
public class MainEventController {
    private final MainEventService mainEventService;

    // 모든 주요사건 조회
    @GetMapping
    public ResponseEntity<List<MainEventResponseDTO>> getAllEvents() {

        List<MainEventResponseDTO> events = mainEventService.getAllEvents();

        return ResponseEntity.ok(events);
    }

}
