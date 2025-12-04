package com.lgcns.haibackend.country.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
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
     * 전체 타임라인 이벤트 반환 (캐싱 적용)
     * 프론트엔드에서 한 번에 로드해서 사용
     */
    @Cacheable("timelineEvents")
    @Transactional(readOnly = true)
    public List<TimelineEventDto> buildTimelineEvents() {
        List<CountryEntity> countries = countryRepository.findAll();
        
        // 변화가 일어나는 연도 수집
        Set<Integer> changeYears = collectChangeYears(countries);
        
        // 연도 정렬
        List<Integer> years = changeYears.stream()
                .sorted()
                .collect(Collectors.toList());

        List<TimelineEventDto> result = new ArrayList<>();

        // 각 연도별 스냅샷 생성
        for (int year : years) {
            for (CountryEntity country : countries) {
                if (!isCountryActiveInYear(country, year)) {
                    continue;
                }

                CapitalEntity currentCapital = findCapitalForYear(country, year);
                KingEntity currentKing = findKingForYear(country, year);

                result.add(new TimelineEventDto(
                        year,
                        country.getCountryName(),
                        currentCapital != null ? currentCapital.getCapitalName() : null,
                        currentCapital != null ? currentCapital.getLatitude() : null,
                        currentCapital != null ? currentCapital.getLongitude() : null,
                        currentKing != null ? currentKing.getRegnalName() : null
                ));
            }
        }

        // 정렬: 연도 오름차순 -> 국가명 오름차순
        result.sort(Comparator
                .comparingInt(TimelineEventDto::year)
                .thenComparing(TimelineEventDto::countryName, 
                    Comparator.nullsLast(String::compareTo)));

        return result;
    }

    /**
     * 연도별로 그룹화된 데이터 반환
     * 프론트에서 Map 형태로 바로 사용 가능
     */
    @Cacheable("timelineByYear")
    public Map<Integer, List<TimelineEventDto>> buildTimelineEventsByYear() {
        List<TimelineEventDto> events = buildTimelineEvents();
        
        return events.stream()
                .collect(Collectors.groupingBy(TimelineEventDto::year));
    }

    /**
     * 변화가 일어나는 모든 연도 수집
     */
    private Set<Integer> collectChangeYears(List<CountryEntity> countries) {
        Set<Integer> changeYears = new HashSet<>();

        for (CountryEntity c : countries) {
            // 국가 건국 연도
            if (c.getFoundationYear() != null) {
                changeYears.add(c.getFoundationYear());
            }
            
            // 수도 변경 연도
            if (c.getCapitals() != null) {
                for (CapitalEntity cap : c.getCapitals()) {
                    if (cap.getStartedDate() != null) {
                        changeYears.add(cap.getStartedDate().getYear());
                    }
                }
            }
            
            // 왕 즉위 연도
            if (c.getKings() != null) {
                for (KingEntity k : c.getKings()) {
                    if (k.getStartedDate() != null) {
                        changeYears.add(k.getStartedDate().getYear());
                    }
                }
            }
        }

        return changeYears;
    }

    /**
     * 해당 연도에 국가가 존재하는지 확인
     */
    private boolean isCountryActiveInYear(CountryEntity country, int year) {
        Integer foundationYear = country.getFoundationYear();
        Integer endedYear = country.getEndedYear();

        if (foundationYear != null && year < foundationYear) {
            return false;
        }
        if (endedYear != null && year > endedYear) {
            return false;
        }
        return true;
    }

    /**
     * 특정 연도의 수도 찾기
     */
    private CapitalEntity findCapitalForYear(CountryEntity country, int year) {
        if (country.getCapitals() == null) {
            return null;
        }

        return country.getCapitals().stream()
                .filter(cap -> isDateInRange(cap.getStartedDate(), cap.getEndedDate(), year))
                .findFirst()
                .orElse(null);
    }

    /**
     * 특정 연도의 왕 찾기
     */
    private KingEntity findKingForYear(CountryEntity country, int year) {
        if (country.getKings() == null) {
            return null;
        }

        return country.getKings().stream()
                .filter(king -> isDateInRange(king.getStartedDate(), king.getEndedDate(), year))
                .findFirst()
                .orElse(null);
    }

    /**
     * 날짜 범위 체크 헬퍼 메서드
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