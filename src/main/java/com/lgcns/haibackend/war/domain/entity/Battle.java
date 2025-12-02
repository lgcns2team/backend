package com.lgcns.haibackend.war.domain.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
public class Battle {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "battleId")
    private Long id;

    private String battleName;

    @Column(columnDefinition = "TEXT")
    private String details;

    private Double latitude;
    private Double longitude;

    private String winnerGeneral;
    private String loserGeneral;

    private LocalDate battleDate;

    @OneToMany(mappedBy = "battle", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<BattleRoute> battleRoutes = new ArrayList<>();

    // 전쟁 FK
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "warId", nullable = false)
    private War war;

}
