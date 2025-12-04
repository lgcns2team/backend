package com.lgcns.haibackend.country.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.country.domain.dto.TimelineEventDto;
import com.lgcns.haibackend.country.service.TimelineService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/timeline")
@RequiredArgsConstructor
public class TimelineController {
    
    private final TimelineService timelineService;
    
    @GetMapping("/events")
    public ResponseEntity<List<TimelineEventDto>> getTimelineEvents() {
        List<TimelineEventDto> events = timelineService.buildTimelineEvents();
        return ResponseEntity.ok(events);
    }
}