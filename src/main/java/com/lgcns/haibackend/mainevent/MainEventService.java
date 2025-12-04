package com.lgcns.haibackend.mainevent;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.lgcns.haibackend.mainevent.domain.dto.MainEventResponseDTO;
import com.lgcns.haibackend.mainevent.domain.entity.MainEventEntity;
import com.lgcns.haibackend.mainevent.repository.MainEventRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainEventService {
    private final MainEventRepository mainEventRepository;

    @Transactional
    public List<MainEventResponseDTO> getAllEvents() {
        // 1. Repository를 통해 데이터베이스에서 모든 MainEventEntity를 조회합니다.
        List<MainEventEntity> entities = mainEventRepository.findAll();

        // 2. 조회된 Entity 리스트를 Stream을 활용하여 Response DTO 리스트로 변환합니다.
        // (Response DTO의 fromEntity() 메소드를 사용)
        return entities.stream()
                .map(MainEventResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }
}
