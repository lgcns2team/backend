package com.lgcns.haibackend.king.domain.entity;

import java.util.Date;

import com.lgcns.haibackend.country.ctrl.domain.entity.CountryEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "King")
public class KingEntity {
    
    @Id
    private String kingId;

    private String kingName;
    private String regnalName;
    private Date startedDate;
    private Date endedDate;

    // 국가 fk 매핑
    @ManyToOne
    @JoinColumn(name = "country_id")
    private CountryEntity country;

}
