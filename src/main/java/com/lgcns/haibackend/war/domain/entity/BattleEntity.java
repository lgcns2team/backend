package com.lgcns.haibackend.war.domain.entity;

import java.time.LocalDate;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "war")
@Table(name = "battle")
public class BattleEntity {
   
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID battleId;

    private String battleName;

    @Column(columnDefinition = "TEXT")
    private String details;

    private Double latitude;
    private Double longitude;

    private String winnerGeneral;
    private String loserGeneral;

    private LocalDate battleDate;

    // 이동 경로 (지도에서 사용할 좌표)
    @Column(name = "markerRoute", columnDefinition = "jsonb")
    private String markerRoute;

    // 경로 색상 (hex 코드, 예: #3b82f6)
    @Column(name = "route_color", length = 7)
    private String routeColor;

    // 전쟁 FK
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "war_id", nullable = false)
    private WarEntity war;

}
