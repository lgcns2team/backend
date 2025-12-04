# HAI Backend - 한국사 GeoJSON 시각화 API

> **Spring Boot 기반 한국사 전쟁·전투 데이터 REST API**  
> GeoJSON 이동경로 데이터를 활용한 역사 시각화 프로젝트

## 프로젝트 개요

780년~1392년 한국사의 주요 국가, 전쟁, 전투, 주요사건, 무역, 수도 등의 데이터를 제공하는 REST API입니다.
전투 이동 경로는 GeoJSON LineString/MultiLineString 형식으로 PostgreSQL JSONB에 저장됩니다.

## 기술 스택

- **Java 17**
- **Spring Boot 3.4.12**
- **Spring Data JPA / Hibernate**
- **PostgreSQL** (JSONB for GeoJSON)
- **Lombok**
- **Gradle 8.14.3**

## 데이터베이스 구조

### 핵심 엔티티

#### 1. Country (국가)
```
- country_id (UUID, PK)
- country_name (String)
- foundation_year (Integer)
- ended_year (Integer)
```

#### 2. War (전쟁)
```
- war_id (UUID, PK)
- name (String)
- details (String)
- war_start_date (LocalDate)
- war_end_date (LocalDate)
- result (String)
- summary (String)
- attack_country_id (UUID, FK → Country)
- defence_country_id (UUID, FK → Country)
```

#### 3. Battle (전투)
```
- battle_id (UUID, PK)
- battle_name (String)
- details (String)
- latitude (Double)
- longitude (Double)
- winner_general (String)
- loser_general (String)
- battle_date (LocalDate)
- marker_route (String/JSONB) ← GeoJSON 경로
- war_id (UUID, FK → War)
```

#### 4. MainEvent (주요사건)
```
- event_id (UUID, PK)
- event_name (String)
- year (Integer)
- era (String)
- description (String/JSONB)
- country_id (UUID, FK → Country)
```

#### 5. King (왕)
```
- king_id (UUID, PK)
- king_name (String)
- reign_start (LocalDate)
- reign_end (LocalDate)
- country_id (UUID, FK → Country)
```

#### 6. Capital (수도)
```
- capital_id (UUID, PK)
- capital_name (String)
- started_date (LocalDate)
- ended_date (LocalDate)
- latitude (Double)
- longitude (Double)
- country_id (UUID, FK → Country)
```

#### 7. Trade (무역)
```
- trade_id (UUID, PK)
- trade_name (String)
- start_year (Integer)
- end_year (Integer)
- start_country_id (UUID, FK → Country)
- end_country_id (UUID, FK → Country)
- trade_routes (OneToMany → TradeRoute)
```

#### 8. TradeRoute (무역경로)
```
- route_id (UUID, PK)
- route_order (Integer)
- markers (String/JSONB) ← 경유지 좌표
- trade_id (UUID, FK → Trade)
```

## 프로젝트 구조

```
src/main/java/com/lgcns/haibackend/
├── HaibackendApplication.java
│
├── war/ 
│   ├── controller/
│   ├── service/
│   ├── repository/
│   └── domain/
│       ├── entity/
│       └── dto/
├── country/
│   ├── controller/
│   │   └── CountryController.java
│   ├── ctrl/
│   │   ├── CountryController.java
│   │   └── TimelineController.java    ← 타임라인 API
│   ├── service/
│   │   └── CountryService.java
│   ├── repository/
│   │   └── CountryRepository.java
│   └── domain/
│       ├── entity/
│       └── dto/
│           ├── CountryRequestDTO.java
│           └── CountryResponseDTO.java
│
├── mainevent/                    ⚠️ Entity만 존재 (Controller, Service, Repository, DTO 미구현)
│   └── domain/
│       └── entity/
│           └── MainEventEntity.java
│
├── capital/                      ⚠️ Entity만 존재 (Controller, Service, Repository, DTO 미구현)
│   └── domain/
│       └── entity/
│           └── CapitalEntity.java
│
├── trade/                        ⚠️ Entity만 존재 (Controller, Service, Repository, DTO 미구현)
│   └── domain/
│       └── entity/
│           └── TradeEntity.java
│
├── traderoute/                   ⚠️ DTO만 존재 (Controller, Service, Repository 미구현)
│   └── domain/
│       ├── entity/
│       └── dto/
└── alliance/
    └── domain/
        └── entity/
```

## 구현 완료 API

### 1. War API (전쟁)
- `GET /api/wars` - 전쟁 목록 조회
- `GET /api/wars/{id}` - 전쟁 상세 조회 (전투 목록 포함 가능)
- `POST /api/wars` - 전쟁 생성
- `PUT /api/wars/{id}` - 전쟁 수정
- `DELETE /api/wars/{id}` - 전쟁 삭제

### 2. Battle API (전투)
- `GET /api/battles` - 전투 목록 조회
- `GET /api/battles/{id}` - 전투 상세 조회 (GeoJSON 경로 포함)
- `GET /api/battles/war/{warId}` - 특정 전쟁의 전투 목록
- `GET /api/battles/search?name={name}` - 전투명 검색
- `POST /api/battles` - 전투 생성
- `PUT /api/battles/{id}` - 전투 수정
- `DELETE /api/battles/{id}` - 전투 삭제

### 3. Country API (국가)
- `GET /api/countries` - 국가 목록 조회
- `GET /api/countries/{id}` - 국가 상세 조회
- `POST /api/countries` - 국가 생성
- `PUT /api/countries/{id}` - 국가 수정
- `DELETE /api/countries/{id}` - 국가 삭제

### 4. Timeline API (타임라인)
- `GET /api/timeline/events` - 전체 타임라인 이벤트 조회 (국가, 왕, 수도, 주요사건 통합)

## 설치 및 실행

### 1. 환경 변수 설정 (.env 파일)
```env
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/your_db
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_password
```

### 2. PostgreSQL 데이터베이스 생성
```sql
CREATE DATABASE your_db;
```

### 3. 프로젝트 기본 실행
```bash
# Gradle 빌드
./gradlew clean build

# Spring Boot 실행
./gradlew bootRun
```

### 4. 타임라인 JSON 자동 생성
실행 후 프로젝트 루트에 export/history-timeline.json 자동 생성
```bash
gradlew bootRun --args='--spring.profiles.active=timeline-export'
```

### 5. 초기 데이터 자동 로드
SQL 파일들이 Spring Boot 시작 시 자동 실행됩니다.
- `schema.sql`: UUID 기본값 및 스키마 생성
- `data.sql`: 국가, 주요사건, 왕, 전쟁, 전투 초기 데이터 삽입
- `update_battles.sql`: 전투 GeoJSON 경로 업데이트

## GeoJSON 데이터 형식

### LineString (단일 경로)
```json
{
  "type": "LineString",
  "coordinates": [
    [127.18561, 37.14921],
    [127.16227, 37.00567],
    [127.13309, 36.83970]
  ]
}
```

### MultiLineString (복수 경로)
```json
{
  "type": "MultiLineString",
  "coordinates": [
    [[126.97, 37.56], [127.19, 37.15]],
    [[127.19, 37.15], [127.43, 37.08]]
  ]
}
```

## 주요 데이터 (780-1392년)

### 국가
- 통일신라 (668-935)
- 발해 (698-926)
- 후백제 (892-936)
- 후고구려/태봉 (901-918)
- 고려 (918-1392)
- 당, 요, 송, 금, 원, 명
- 일본, 여진, 홍건적, 왜구

### 전쟁 (예시)
- 후삼국 통일전쟁 (927-936)
- 여요전쟁 (993-1019)
- 여진정벌 (1107-1109)
- 여몽전쟁(대몽항쟁) (1231-1273)
- 홍건적의 침입 (1359-1362)
- 왜구의 침입 (1350-1392)

### 전투 (예시)
- 공산전투 (927) - 견훤의 신라 왕경 침공
- 고창전투 (930) - 왕건 vs 견훤
- 귀주대첩 (1019) - 강감찬의 요군 격퇴
- 충주성 전투 (1231) - 몽골군의 침공
- 처인성 전투 (1232) - 살리타 사살
- 황산대첩 (1380) - 최무선의 화포 활용
- 진포대첩 (1380) - 최무선 vs 왜구

## 추가 개발 필요 항목

### 1. MainEvent (주요사건)
- ✅ Entity, DTO 완료
- ❌ Controller, Service, Repository 미구현
- API: `/api/events` (예정)

### 2. Capital (수도)
- ✅ Entity, Repository 완료
- ❌ Controller, Service, DTO 미구현
- API: `/api/capitals` (예정)
- 참고: TimelineService에서 Capital 데이터 조회 가능

### 3. King (왕)
- ✅ Entity, Repository 완료
- ❌ Controller, Service, DTO 미구현
- API: `/api/kings` (예정)
- 참고: TimelineService에서 King 데이터 조회 가능

### 4. Trade & TradeRoute (무역/무역경로)
- ✅ Entity, DTO 완료
- ❌ Controller, Service, Repository 미구현
- API: `/api/trades`, `/api/trade-routes` (예정)

### 5. Alliance (동맹)
- 현재 주석 처리됨 - 사용 여부 결정 필요

## 참고 문서

- [API_GUIDE.md](./API_GUIDE.md) - REST API 상세 가이드 (curl 예제 포함)
- [README_GeoJSON.md](./README_GeoJSON.md) - GeoJSON 데이터 구조 설명
- [PROJECT_SETUP.md](./PROJECT_SETUP.md) - 프로젝트 완료 보고서

## 🤝 기여

프로젝트에 기여하시려면:
1. develop 브랜치에서 작업
2. 미완성 API 구현 (mainevent, capital, trade, king)
3. 테스트 코드 작성
4. Pull Request 생성

## 📄 라이선스

This project is licensed under the MIT License.

## 팀

- Repository: [lgcns2team/backend](https://github.com/lgcns2team/backend)
- Branch: war (현재 작업 브랜치)
- Main Branch: develop

---

**마지막 업데이트:** 2025년 12월 4일
