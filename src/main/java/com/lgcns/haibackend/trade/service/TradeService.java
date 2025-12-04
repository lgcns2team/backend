package com.lgcns.haibackend.trade.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;
import com.lgcns.haibackend.trade.domain.dto.TradeRequestDTO;
import com.lgcns.haibackend.trade.domain.dto.TradeResponseDTO;
import com.lgcns.haibackend.trade.domain.entity.TradeEntity;
import com.lgcns.haibackend.trade.repository.TradeRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TradeService {

    private final TradeRepository tradeRepository;
    private final CountryRepository countryRepository;

    // 특정 국가의 특정 연도 무역 조회 (국가 존속기간 필터링)
    public List<TradeResponseDTO> getTradesByCountryAndYear(UUID countryId, int year) {
        return tradeRepository.findTradesByCountryAndYear(countryId, year).stream()
                .map(TradeResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    // 모든 무역 조회
    public List<TradeResponseDTO> getAllTrades() {
        return tradeRepository.findAllWithRoutes().stream()
                .map(TradeResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    // 무역 생성
    @Transactional
    public TradeResponseDTO createTrade(TradeRequestDTO requestDTO) {
        CountryEntity startCountry = countryRepository.findById(requestDTO.getStartCountryId())
                .orElseThrow(() -> new RuntimeException("Start country not found"));

        CountryEntity endCountry = countryRepository.findById(requestDTO.getEndCountryId())
                .orElseThrow(() -> new RuntimeException("End country not found"));

        TradeEntity trade = TradeEntity.builder()
                .startCountry(startCountry)
                .endCountry(endCountry)
                .tradeYear(requestDTO.getTradeYear())
                .product(requestDTO.getProduct())
                .build();

        TradeEntity savedTrade = tradeRepository.save(trade);
        return TradeResponseDTO.fromEntity(savedTrade);
    }

    // 무역 수정
    @Transactional
    public TradeResponseDTO updateTrade(UUID tradeId, TradeRequestDTO requestDTO) {
        TradeEntity trade = tradeRepository.findById(tradeId)
                .orElseThrow(() -> new RuntimeException("Trade not found with id: " + tradeId));

        if (requestDTO.getStartCountryId() != null) {
            CountryEntity startCountry = countryRepository.findById(requestDTO.getStartCountryId())
                    .orElseThrow(() -> new RuntimeException("Start country not found"));
            trade.setStartCountry(startCountry);
        }
        if (requestDTO.getEndCountryId() != null) {
            CountryEntity endCountry = countryRepository.findById(requestDTO.getEndCountryId())
                    .orElseThrow(() -> new RuntimeException("End country not found"));
            trade.setEndCountry(endCountry);
        }
        if (requestDTO.getTradeYear() != null) {
            trade.setTradeYear(requestDTO.getTradeYear());
        }
        if (requestDTO.getProduct() != null) {
            trade.setProduct(requestDTO.getProduct());
        }

        return TradeResponseDTO.fromEntity(trade);
    }

    // 무역 삭제
    @Transactional
    public void deleteTrade(UUID tradeId) {
        if (!tradeRepository.existsById(tradeId)) {
            throw new RuntimeException("Trade not found with id: " + tradeId);
        }
        tradeRepository.deleteById(tradeId);
    }
}
