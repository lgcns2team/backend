package com.lgcns.haibackend.country.ctrl.domain.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.lgcns.haibackend.war.domain.entity.War;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;


@Getter
@Setter
@Entity
@Table(name = "Country")
public class CountryEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto incerment
    private Long countryId;

    private String countryName;
    private Integer foundationYear;
    private Integer endedYear;

    @OneToMany(mappedBy = "attackCountry", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<War> attackWars;

    @OneToMany(mappedBy = "defenceCountry", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<War> defenceWars;

    // public CountryEntity(String countryName, Double longitude, Double latitude, Integer foundationYear) {
    //     this.countryName = countryName;
    //     this.longitude = longitude;
    //     this.latitude = latitude;
    //     this.foundationYear = foundationYear;
    // }

    // getter
    // public Long getCountryId() {
    //     return countryId;
    // }
    // public String getCountryName() {
    //     return countryName;
    // }
    // public Double getLongitude() {
    //     return longitude;
    // }
    // public Double getLatitude() {
    //     return latitude;
    // }
    // public Integer getFoundationYear() {
    //     return foundationYear;
    // }

}