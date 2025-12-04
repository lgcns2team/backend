package com.lgcns.haibackend.mainevent.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lgcns.haibackend.mainevent.domain.entity.MainEventEntity;

public interface MainEventRepository extends JpaRepository<MainEventEntity, UUID> {

}
