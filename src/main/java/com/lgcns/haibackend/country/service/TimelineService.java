package com.lgcns.haibackend.country.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lgcns.haibackend.capital.domain.entity.CapitalEntity;
import com.lgcns.haibackend.country.domain.dto.TimelineEventDto;
import com.lgcns.haibackend.country.domain.entity.CountryEntity;
import com.lgcns.haibackend.country.domain.entity.KingEntity;
import com.lgcns.haibackend.country.repository.CountryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TimelineService {
    private final CountryRepository countryRepository;

    /**
     * 전체 타임라인 이벤트 반환
     * 각 국가별로 실제 변화가 있을 때만 이벤트 생성
     * null 값 방지: 항상 해당 연도의 수도와 왕 정보를 찾아서 채움
     */
    @Cacheable("timelineEvents")
    @Transactional(readOnly = true)
    public List<TimelineEventDto> buildTimelineEvents() {
        // MultipleBagFetchException 방지: 두 번 조회
        countryRepository.findAllWithCapitals();
        List<CountryEntity> countries = countryRepository.findAllWithKings();
        
        List<TimelineEventDto> result = new ArrayList<>();

        // 각 국가별로 개별 처리
        for (CountryEntity country : countries) {
            result.addAll(buildEventsForCountry(country));
        }

        // 연도 오름차순 -> 국가명 오름차순 정렬
        result.sort(Comparator
                .comparingInt(TimelineEventDto::year)
                .thenComparing(TimelineEventDto::countryName, 
                    Comparator.nullsLast(String::compareTo)));

        return result;
    }

    /**
     * 특정 국가의 타임라인 이벤트 생성
     * 실제로 변화가 있을 때만 이벤트 추가 (중복 제거)
     */
    private List<TimelineEventDto> buildEventsForCountry(CountryEntity country) {
        Integer foundationYear = country.getFoundationYear();
        Integer endedYear = country.getEndedYear();
        
        if (foundationYear == null) {
            return new ArrayList<>();
        }

        // 변화가 일어나는 모든 연도 수집 (Set으로 중복 제거)
        Set<Integer> changeYears = new HashSet<>();
        changeYears.add(foundationYear); // 건국년도

        // 수도 변경 연도
        if (country.getCapitals() != null) {
            for (CapitalEntity capital : country.getCapitals()) {
                if (capital.getStartedDate() != null) {
                    int year = capital.getStartedDate().getYear();
                    if (endedYear == null || year <= endedYear) {
                        changeYears.add(year);
                    }
                }
            }
        }

        // 왕 교체 연도
        if (country.getKings() != null) {
            for (KingEntity king : country.getKings()) {
                if (king.getStartedDate() != null) {
                    int year = king.getStartedDate().getYear();
                    if (endedYear == null || year <= endedYear) {
                        changeYears.add(year);
                    }
                }
            }
        }

        // 연도를 정렬하여 순차적으로 처리
        List<Integer> sortedYears = changeYears.stream()
                .sorted()
                .collect(Collectors.toList());

        // 각 연도별 이벤트 생성 (변화가 있을 때만)
        List<TimelineEventDto> events = new ArrayList<>();
        TimelineEventDto previousEvent = null;

        for (int year : sortedYears) {
            TimelineEventDto newEvent = createEventWithLookup(year, country);
            
            // 첫 이벤트이거나, 이전 이벤트와 다를 때만 추가
            if (previousEvent == null || hasSignificantChange(previousEvent, newEvent)) {
                events.add(newEvent);
                previousEvent = newEvent;
            }
        }

        return events;
    }

    /**
     * 두 이벤트 간 의미있는 변화가 있는지 확인
     * 수도, 왕 중 하나라도 바뀌었으면 true
     */
    private boolean hasSignificantChange(TimelineEventDto prev, TimelineEventDto current) {
        // 수도 이름이 변경되었는지
        boolean capitalChanged = !Objects.equals(prev.capitalName(), current.capitalName());
        
        // 왕 이름이 변경되었는지
        boolean kingChanged = !Objects.equals(prev.regnalName(), current.regnalName());
        
        return capitalChanged || kingChanged;
    }

    /**
     * 특정 연도의 이벤트 생성
     * 해당 연도에 유효한 수도와 왕을 반드시 찾아서 설정
     */
    private TimelineEventDto createEventWithLookup(int year, CountryEntity country) {
        // 해당 연도의 수도 찾기
        CapitalEntity capital = findCapitalForYear(country, year);
        
        // 해당 연도의 왕 찾기
        KingEntity king = findKingForYear(country, year);
        
        return new TimelineEventDto(
                year,
                country.getCountryName(),
                capital != null ? capital.getCapitalName() : null,
                capital != null ? capital.getLatitude() : null,
                capital != null ? capital.getLongitude() : null,
                king != null ? king.getRegnalName() : null
        );
    }

    /**
     * 특정 연도의 수도 찾기
     * 해당 연도에 유효한 수도가 없으면 가장 가까운 미래 수도를 소급 적용
     * 같은 연도에 여러 수도가 있으면 시작일이 가장 늦은 것 선택
     */
    private CapitalEntity findCapitalForYear(CountryEntity country, int year) {
        if (country.getCapitals() == null || country.getCapitals().isEmpty()) {
            return null;
        }

        // 1. 정확히 해당 연도에 유효한 수도들 찾기
        List<CapitalEntity> matchingCapitals = country.getCapitals().stream()
                .filter(cap -> isDateInRange(cap.getStartedDate(), cap.getEndedDate(), year))
                .collect(Collectors.toList());
        
        if (!matchingCapitals.isEmpty()) {
            // 같은 연도에 여러 개면 시작일이 가장 늦은 것 선택 (최신 것)
            return matchingCapitals.stream()
                    .max(Comparator.comparing(CapitalEntity::getStartedDate))
                    .orElse(null);
        }
        
        // 2. 정확한 매칭이 없으면, 가장 가까운 미래의 수도를 소급 적용
        return country.getCapitals().stream()
                .filter(cap -> cap.getStartedDate() != null)
                .filter(cap -> cap.getStartedDate().getYear() >= year)
                .min(Comparator.comparing(CapitalEntity::getStartedDate))
                .orElse(null);
    }

    /**
     * 특정 연도의 왕 찾기
     * 해당 연도에 유효한 왕이 없으면 가장 가까운 미래 왕을 소급 적용
     * 같은 연도에 여러 왕이 있으면 시작일이 가장 늦은 것 선택 (즉위가 늦은 것)
     */
    private KingEntity findKingForYear(CountryEntity country, int year) {
        if (country.getKings() == null || country.getKings().isEmpty()) {
            return null;
        }

        // 1. 정확히 해당 연도에 유효한 왕들 찾기
        List<KingEntity> matchingKings = country.getKings().stream()
                .filter(king -> isDateInRange(king.getStartedDate(), king.getEndedDate(), year))
                .collect(Collectors.toList());
        
        if (!matchingKings.isEmpty()) {
            // 같은 연도에 여러 명이면 즉위일이 가장 늦은 것 선택 (최신 왕)
            return matchingKings.stream()
                    .max(Comparator.comparing(KingEntity::getStartedDate))
                    .orElse(null);
        }
        
        // 2. 정확한 매칭이 없으면, 가장 가까운 미래의 왕을 소급 적용
        return country.getKings().stream()
                .filter(king -> king.getStartedDate() != null)
                .filter(king -> king.getStartedDate().getYear() >= year)
                .min(Comparator.comparing(KingEntity::getStartedDate))
                .orElse(null);
    }

    /**
     * 날짜 범위 체크
     * startDate <= year <= endDate 인지 확인
     */
    private boolean isDateInRange(LocalDate startDate, LocalDate endDate, int year) {
        if (startDate == null) {
            return false;
        }
        
        int startYear = startDate.getYear();
        int endYear = (endDate != null) ? endDate.getYear() : Integer.MAX_VALUE;
        
        return startYear <= year && year <= endYear;
    }
}