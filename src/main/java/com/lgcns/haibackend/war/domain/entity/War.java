package com.lgcns.haibackend.war.domain.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
// @ToString(exclude = {"attackCountry", "defenceCountry"})
@ToString

public class War {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "warId")
    private Long id;

    private String name;

    @Column(columnDefinition = "TEXT")
    private String details;

    private LocalDate warStartDate;
    private LocalDate warEndDate;

    private String result;

    @Column(columnDefinition = "TEXT")
    private String summary;

    @OneToMany(mappedBy = "war", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Battle> battles = new ArrayList<>();

    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "attackCountryId", nullable = false)
    // private Country attackCountry;

    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "defenceCountryId", nullable = false)
    // private Country defenceCountry;

}
