package com.lgcns.haibackend.mainEvent.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lgcns.haibackend.mainEvent.domain.entity.MainEventEntity;

@Repository
public interface MainEventRepository extends JpaRepository<MainEventEntity, UUID> {
    
    @Query("""
        SELECT e FROM MainEventEntity e
        JOIN FETCH e.country c
        WHERE (:countryId IS NULL OR c.countryId = :countryId)
        AND (:era IS NULL OR e.era = :era)
        AND (:fromYear IS NULL OR e.year >= :fromYear)
        AND (:toYear IS NULL OR e.year <= :toYear)
        ORDER BY e.year ASC, e.eventName ASC
    """)
    List<MainEventEntity> searchMainEvents(
        @Param("countryId") UUID countryId,
        @Param("era") String era,
        @Param("fromYear") Integer fromYear,
        @Param("toYear") Integer toYear
    );

    List<MainEventEntity> findAllByOrderByYearAscEventNameAsc();

}
