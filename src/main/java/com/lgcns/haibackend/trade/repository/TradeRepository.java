package com.lgcns.haibackend.trade.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.trade.domain.entity.TradeEntity;

@Repository
public interface TradeRepository extends JpaRepository<TradeEntity, UUID> {

    // 특정 국가의 무역 조회 (국가의 존속기간만 필터링, 무역 연도는 무시)
    @Query("""
        SELECT DISTINCT t FROM TradeEntity t
        LEFT JOIN FETCH t.routes
        WHERE (t.startCountry.countryId = :countryId OR t.endCountry.countryId = :countryId)
        AND t.startCountry.foundationYear <= :year
        AND (t.startCountry.endedYear IS NULL OR t.startCountry.endedYear >= :year)
        AND t.endCountry.foundationYear <= :year
        AND (t.endCountry.endedYear IS NULL OR t.endCountry.endedYear >= :year)
        """)
    List<TradeEntity> findTradesByCountryAndYear(@Param("countryId") UUID countryId, @Param("year") int year);

    // 모든 무역 조회 (routes 포함)
    @Query("SELECT DISTINCT t FROM TradeEntity t LEFT JOIN FETCH t.routes")
    List<TradeEntity> findAllWithRoutes();
}
