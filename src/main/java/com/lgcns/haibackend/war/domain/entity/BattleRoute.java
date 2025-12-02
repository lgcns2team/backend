package com.lgcns.haibackend.war.domain.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = "battle")
public class BattleRoute {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "routeId")
    private Long routeId;

    private String tag; //육전, 해전

    // markerRoute : 이동 경로 (지도에서 사용할 좌표)
    @Column(name = "markerRoute", columnDefinition = "jsonb")
    private String markerRoute;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "battleId", nullable = false)
    private Battle battle;
}
