package com.lgcns.haibackend.country.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.lgcns.haibackend.country.domain.dto.TimelineEventDto;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
@Profile("timeline-export")
public class TimelineExporter implements CommandLineRunner{
    private final TimelineService timelineService;

    @Override
    public void run(String... args) throws Exception {
        List<TimelineEventDto> events = timelineService.buildTimelineEvents();

        ObjectMapper mapper = new ObjectMapper()
                .enable(SerializationFeature.INDENT_OUTPUT);

        // 원하는 경로로 저장 (예: 프로젝트 루트의 /export/history-timeline.json)
        Path exportDir = Path.of("export");
        Files.createDirectories(exportDir);

        File outFile = exportDir.resolve("history-timeline.json").toFile();

        mapper.writeValue(outFile, events);

        System.out.println("역사 타임라인 JSON 파일 생성 완료: " + outFile.getAbsolutePath());
    }
}
