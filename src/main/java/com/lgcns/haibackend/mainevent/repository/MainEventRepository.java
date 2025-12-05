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

    List<MainEventEntity> findAllByOrderByYearAscEventNameAsc();

}
