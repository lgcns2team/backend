package com.lgcns.haibackend.mainEvent.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.mainEvent.domain.dto.MainEventDetailDTO;
import com.lgcns.haibackend.mainEvent.domain.dto.MainEventListDTO;
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
    @GetMapping("/detail")
    public ResponseEntity<MainEventDetailDTO> getMainEventDetail(
        @RequestParam("type") String type, @RequestParam("id") UUID eventId
    ) {
        MainEventDetailDTO response = mainEventService.getDetail(type, eventId);
        if( response != null ) {
            return new ResponseEntity<>(response , HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

}
