package com.lgcns.haibackend.trade.controller;

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

import com.lgcns.haibackend.trade.domain.dto.TradeRequestDTO;
import com.lgcns.haibackend.trade.domain.dto.TradeResponseDTO;
import com.lgcns.haibackend.trade.service.TradeService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/trades")
@RequiredArgsConstructor
public class TradeController {

    private final TradeService tradeService;

    // 모든 무역 조회
    @GetMapping
    public ResponseEntity<List<TradeResponseDTO>> getAllTrades() {
        List<TradeResponseDTO> trades = tradeService.getAllTrades();
        return ResponseEntity.ok(trades);
    }

    // 특정 국가의 특정 연도 무역 조회 (국가 존속기간 필터링)
    @GetMapping("/{countryId}/{year}")
    public ResponseEntity<List<TradeResponseDTO>> getTradesByCountryAndYear(
            @PathVariable("countryId") UUID countryId,
            @PathVariable("year") int year) {
        List<TradeResponseDTO> trades = tradeService.getTradesByCountryAndYear(countryId, year);
        return ResponseEntity.ok(trades);
    }

    // 무역 생성
    @PostMapping
    public ResponseEntity<TradeResponseDTO> createTrade(@RequestBody TradeRequestDTO requestDTO) {
        TradeResponseDTO createdTrade = tradeService.createTrade(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdTrade);
    }

    // 무역 수정
    @PutMapping("/{tradeId}")
    public ResponseEntity<TradeResponseDTO> updateTrade(
            @PathVariable("tradeId") UUID tradeId,
            @RequestBody TradeRequestDTO requestDTO) {
        TradeResponseDTO updatedTrade = tradeService.updateTrade(tradeId, requestDTO);
        return ResponseEntity.ok(updatedTrade);
    }

    // 무역 삭제
    @DeleteMapping("/{tradeId}")
    public ResponseEntity<Void> deleteTrade(@PathVariable("tradeId") UUID tradeId) {
        tradeService.deleteTrade(tradeId);
        return ResponseEntity.noContent().build();
    }
}
