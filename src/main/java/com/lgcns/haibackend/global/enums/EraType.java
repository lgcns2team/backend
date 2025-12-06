package com.lgcns.haibackend.global.enums;

public enum EraType {

    NAMBUKGOOK("남북국 시대", "668년 - 900년"),
    HOOSAMGOOK("후삼국 시대", "900년 - 936년"),
    GORYEO_EARLY("고려 초기", "936년 - 1170년"),
    GORYEO_MIDDLE_MILITARY("고려 중기(무신정권)", "1170년 - 1270년"),
    GORYEO_LATE("고려 후기", "1270년 - 1392년");

    private final String description;
    private final String period;
    
    EraType(String description, String period) {
        this.description = description;
        this.period = period;
    }

    public String getDescription() {
        return description;
    }

    public String getPeriod() {
        return period;
    }
}
