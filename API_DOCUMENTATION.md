# HAI Backend API 문서

> **한국사 타임라인 시각화를 위한 REST API**  
> 국가, 전쟁, 무역, 수도 데이터를 연도 기반으로 제공

---

## 📋 목차
- [프로젝트 개요](#프로젝트-개요)
- [기술 스택](#기술-스택)
- [데이터베이스 구조](#데이터베이스-구조)
- [API 엔드포인트](#api-엔드포인트)
- [프론트엔드 연동 가이드](#프론트엔드-연동-가이드)
- [빌드 및 실행](#빌드-및-실행)

---

## 🎯 프로젝트 개요

780년~1392년 한국사의 주요 데이터를 연도 기반으로 제공하는 REST API입니다.

### 핵심 기능
- ✅ **연도 기반 필터링**: 특정 연도에 존재하는 국가, 전쟁, 무역 데이터만 제공
- ✅ **GeoJSON 경로 데이터**: 무역 경로, 전투 이동 경로를 지도에 시각화 가능
- ✅ **관계형 데이터**: 국가 ↔ 전쟁 ↔ 전투, 국가 ↔ 무역 ↔ 무역경로
- ✅ **타임라인 이벤트**: 왕, 수도, 주요 사건을 시간순 정렬

---

## 🛠 기술 스택

### Backend
- **Java 17**
- **Spring Boot 3.4.12**
- **Spring Data JPA / Hibernate**
- **PostgreSQL** with JSONB support
- **Gradle 8.14.3**

### 주요 라이브러리
- `Lombok`: Boilerplate 코드 감소
- `Jackson`: JSON 직렬화/역직렬화
- `PostgreSQL JDBC Driver`

---

## 🗄 데이터베이스 구조

### ERD 개요
```
Country (국가)
  ├─ 1:N → King (왕)
  ├─ 1:N → Capital (수도)
  ├─ 1:N → MainEvent (주요사건)
  ├─ 1:N → War (전쟁 - 공격국)
  ├─ 1:N → War (전쟁 - 방어국)
  └─ 1:N → Trade (무역 - 시작국/종료국)

War (전쟁)
  └─ 1:N → Battle (전투)

Trade (무역)
  └─ 1:N → TradeRoute (무역경로)
```

### 핵심 엔티티

#### 1. Country (국가)
| 필드 | 타입 | 설명 |
|------|------|------|
| country_id | UUID | PK |
| country_name | String | 국가명 (예: "고려", "발해") |
| foundation_year | Integer | 건국연도 (예: 918) |
| ended_year | Integer | 멸망연도 (null이면 현존) |

**특징**: `foundationYear`와 `endedYear`로 국가 존속기간 계산

#### 2. War (전쟁)
| 필드 | 타입 | 설명 |
|------|------|------|
| war_id | UUID | PK |
| name | String | 전쟁명 |
| war_start_year | Integer | 시작연도 |
| war_end_year | Integer | 종료연도 |
| result | String | 결과 (승리/패배) |
| attack_country_id | UUID | FK → Country |
| defence_country_id | UUID | FK → Country |

**날짜 형식**: `LocalDate` → `Integer year`로 변경됨 (프론트 연동 간소화)

#### 3. Battle (전투)
| 필드 | 타입 | 설명 |
|------|------|------|
| battle_id | UUID | PK |
| battle_name | String | 전투명 |
| battle_year | Integer | 발생연도 |
| latitude | Double | 위도 |
| longitude | Double | 경도 |
| marker_route | String (JSONB) | GeoJSON 이동경로 |
| war_id | UUID | FK → War |

**GeoJSON 형식**:
```json
{
  "type": "LineString",
  "coordinates": [[lng, lat], [lng, lat], ...]
}
```

#### 4. Trade (무역)
| 필드 | 타입 | 설명 |
|------|------|------|
| trade_id | UUID | PK |
| start_country_id | UUID | FK → Country (수출국) |
| end_country_id | UUID | FK → Country (수입국) |
| trade_year | Integer | 무역 시작연도 |
| product | String | 교역품 |

#### 5. TradeRoute (무역경로)
| 필드 | 타입 | 설명 |
|------|------|------|
| route_id | UUID | PK |
| trade_id | UUID | FK → Trade |
| path | String (JSONB) | 경로 좌표 배열 |

**경로 형식**:
```json
[
  {"latitude": 43.09, "longitude": 131.37},
  {"latitude": 42.85, "longitude": 129.45},
  ...
]
```

#### 6. King (왕)
| 필드 | 타입 | 설명 |
|------|------|------|
| king_id | UUID | PK |
| name | String | 왕명 |
| started_year | Integer | 즉위연도 |
| ended_year | Integer | 퇴위연도 |
| country_id | UUID | FK → Country |

#### 7. Capital (수도)
| 필드 | 타입 | 설명 |
|------|------|------|
| capital_id | UUID | PK |
| name | String | 수도명 |
| started_year | Integer | 수도 시작연도 |
| ended_year | Integer | 수도 종료연도 |
| latitude | Double | 위도 |
| longitude | Double | 경도 |
| country_id | UUID | FK → Country |

---

## 🔌 API 엔드포인트

### 📍 Base URL
```
http://localhost:8080/api
```

---

### 1️⃣ Country API (국가)

#### GET `/countries`
모든 국가 조회
```json
[
  {
    "countryId": "uuid",
    "countryName": "고려",
    "foundationYear": 918,
    "endedYear": 1392
  }
]
```

---

### 2️⃣ War API (전쟁)

#### GET `/wars`
모든 전쟁 조회 (전투 제외)

#### GET `/wars/{year}`
**특정 연도에 진행 중인 전쟁 조회**

**요청 예시**:
```
GET /api/wars/1018
```

**응답**:
```json
[
  {
    "warId": "uuid",
    "name": "거란의 3차 침입",
    "warStartYear": 1018,
    "warEndYear": 1019,
    "result": "고려 승리",
    "summary": "강감찬의 귀주대첩으로 거란군 격퇴",
    "attackCountryId": "거란-uuid",
    "attackCountryName": "거란",
    "defenceCountryId": "고려-uuid",
    "defenceCountryName": "고려",
    "battles": [
      {
        "battleId": "uuid",
        "battleName": "귀주대첩",
        "battleYear": 1019,
        "latitude": 39.9,
        "longitude": 125.2,
        "winnerGeneral": "강감찬",
        "markerRoute": "{\"type\":\"LineString\", ...}"
      }
    ]
  }
]
```

**필터링 로직**:
```
warStartYear <= year AND (warEndYear IS NULL OR warEndYear >= year)
```

---

### 3️⃣ Battle API (전투)

#### GET `/battles`
모든 전투 조회

#### GET `/battles/{battleId}`
특정 전투 상세 조회

#### GET `/battles/war/{warId}`
특정 전쟁의 모든 전투 조회

---

### 4️⃣ Trade API (무역) ⭐

#### GET `/trades/{countryId}/{year}`
**특정 국가의 특정 연도 무역 데이터 조회**

**핵심**: 양쪽 국가가 모두 해당 연도에 존재할 때만 반환

**요청 예시**:
```
GET /api/trades/{발해-UUID}/850
```

**응답**:
```json
[
  {
    "tradeId": "uuid",
    "startCountryId": "발해-uuid",
    "startCountryName": "발해",
    "endCountryId": "당-uuid",
    "endCountryName": "당",
    "tradeYear": 698,
    "product": "모피, 인삼",
    "routes": [
      {
        "routeId": "uuid",
        "tradeId": "uuid",
        "path": [
          {"latitude": 43.09, "longitude": 131.37},
          {"latitude": 42.85, "longitude": 129.45},
          {"latitude": 41.20, "longitude": 125.33}
        ]
      }
    ]
  }
]
```

**필터링 로직**:
```sql
-- 1. 해당 국가가 무역 당사국이어야 함
(startCountryId = :countryId OR endCountryId = :countryId)

-- 2. 무역이 해당 연도 이전에 시작되어야 함
AND tradeYear <= :year

-- 3. 시작 국가가 해당 연도에 존재해야 함
AND startCountry.foundationYear <= :year
AND (startCountry.endedYear IS NULL OR startCountry.endedYear >= :year)

-- 4. 종료 국가가 해당 연도에 존재해야 함
AND endCountry.foundationYear <= :year
AND (endCountry.endedYear IS NULL OR endCountry.endedYear >= :year)
```

#### GET `/trades`
모든 무역 조회 (관리용)

---

### 5️⃣ King API (왕)

#### GET `/kings`
모든 왕 조회

#### GET `/kings/{kingId}`
특정 왕 상세 조회

---

### 6️⃣ Capital API (수도)

#### GET `/capitals`
모든 수도 조회

#### GET `/capitals/{capitalId}`
특정 수도 상세 조회

---

### 7️⃣ Timeline API (타임라인)

#### GET `/timeline/events`
모든 왕, 수도, 주요사건을 시간순 정렬하여 반환

**응답**:
```json
[
  {
    "type": "KING",
    "startYear": 918,
    "endYear": 943,
    "name": "태조 왕건",
    "countryName": "고려",
    "details": "고려 건국"
  },
  {
    "type": "CAPITAL",
    "startYear": 918,
    "endYear": 1392,
    "name": "개경",
    "countryName": "고려",
    "latitude": 37.97,
    "longitude": 126.55
  },
  {
    "type": "EVENT",
    "year": 935,
    "name": "후백제 멸망",
    "countryName": "고려",
    "description": "{\"summary\": \"...\", \"significance\": \"...\"}"
  }
]
```

---

## 🎨 프론트엔드 연동 가이드

### 타임라인 슬라이더 구현 예시

```javascript
// 연도 변경 이벤트
const year = 1018; // 슬라이더에서 선택된 연도

// 1. 해당 연도의 전쟁 가져오기
const wars = await fetch(`/api/wars/${year}`).then(r => r.json());

// 2. 해당 연도의 고려 무역 경로 가져오기
const koreaId = "고려-UUID";
const trades = await fetch(`/api/trades/${koreaId}/${year}`).then(r => r.json());

// 3. 지도에 무역 경로 표시 (Leaflet.js 예시)
trades.forEach(trade => {
  trade.routes.forEach(route => {
    const latlngs = route.path.map(p => [p.latitude, p.longitude]);
    
    L.polyline(latlngs, {
      color: 'blue',
      weight: 3,
      opacity: 0.7
    }).bindPopup(`
      ${trade.startCountryName} → ${trade.endCountryName}<br>
      ${trade.product}
    `).addTo(map);
  });
});

// 4. 전투 마커 표시
wars.forEach(war => {
  war.battles.forEach(battle => {
    L.marker([battle.latitude, battle.longitude])
      .bindPopup(`
        <b>${battle.battleName}</b><br>
        ${battle.battleYear}년<br>
        승자: ${battle.winnerGeneral}
      `).addTo(map);
      
    // 전투 이동 경로 (markerRoute가 있는 경우)
    if (battle.markerRoute) {
      const geojson = JSON.parse(battle.markerRoute);
      L.geoJSON(geojson).addTo(map);
    }
  });
});
```

---

### 국가별 데이터 필터링

```javascript
// 고려만 보기 (918~1392년)
const koreaId = "고려-UUID";
const year = 1100;

// 고려의 왕 정보
const kings = await fetch('/api/kings').then(r => r.json());
const koreaKings = kings.filter(k => 
  k.countryId === koreaId && 
  k.startedYear <= year && 
  k.endedYear >= year
);

// 고려가 참여한 전쟁
const wars = await fetch(`/api/wars/${year}`).then(r => r.json());
const koreaWars = wars.filter(w => 
  w.attackCountryId === koreaId || 
  w.defenceCountryId === koreaId
);

// 고려의 무역
const trades = await fetch(`/api/trades/${koreaId}/${year}`).then(r => r.json());
```

---

### 데이터 구조 활용 팁

#### 1. 무역 경로 시각화
```javascript
// routes 배열이 무역 데이터에 포함되어 있음
trade.routes.forEach(route => {
  // route.path는 [{latitude, longitude}, ...] 형식
  const coordinates = route.path.map(p => [p.latitude, p.longitude]);
  drawLineOnMap(coordinates);
});
```

#### 2. 전투 이동 경로 시각화
```javascript
// markerRoute는 GeoJSON 문자열
const geojson = JSON.parse(battle.markerRoute);

if (geojson.type === 'LineString') {
  // coordinates는 [경도, 위도] 순서 주의!
  const latlngs = geojson.coordinates.map(c => [c[1], c[0]]);
  L.polyline(latlngs).addTo(map);
}
```

#### 3. 연도 범위 필터링 (프론트에서)
```javascript
// 특정 기간의 왕만 표시
const showKingsBetween = (startYear, endYear) => {
  return kings.filter(king => 
    king.startedYear <= endYear && 
    (king.endedYear === null || king.endedYear >= startYear)
  );
};
```

---

## 🚀 빌드 및 실행

### 1. 사전 요구사항
- Java 17 이상
- PostgreSQL 12 이상
- Gradle 8.14.3 (wrapper 포함)

### 2. 데이터베이스 설정

#### PostgreSQL 데이터베이스 생성
```sql
CREATE DATABASE haibackend;
```

#### `application.yaml` 설정
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/haibackend
    username: your_username
    password: your_password
  jpa:
    hibernate:
      ddl-auto: create  # 최초 실행 시
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
```

### 3. 빌드 및 실행

#### 프로젝트 빌드
```powershell
./gradlew clean build
```

#### 애플리케이션 실행
```powershell
./gradlew bootRun
```

#### 테스트 제외 빌드
```powershell
./gradlew clean build -x test
```

### 4. API 테스트

#### Postman/Insomnia 테스트
```
GET http://localhost:8080/api/wars/1018
GET http://localhost:8080/api/trades/{countryId}/1100
GET http://localhost:8080/api/timeline/events
```

#### cURL 테스트
```bash
curl http://localhost:8080/api/wars/1018
```

---

## 📝 코드 구조

```
src/main/java/com/lgcns/haibackend/
├── war/
│   ├── controller/      # WarController, BattleController
│   ├── service/         # WarService, BattleService
│   ├── repository/      # WarRepository, BattleRepository
│   └── domain/
│       ├── entity/      # WarEntity, BattleEntity
│       └── dto/         # Request/Response DTO
├── trade/
│   ├── controller/      # TradeController
│   ├── service/         # TradeService
│   ├── repository/      # TradeRepository
│   └── domain/
│       ├── entity/      # TradeEntity
│       └── dto/         # TradeRequestDTO, TradeResponseDTO
├── traderoute/
│   └── domain/
│       ├── entity/      # TradeRouteEntity
│       └── dto/         # TradeRouteResponseDTO, MarkerDTO
├── country/
│   ├── controller/      # CountryController, KingController, TimelineController
│   ├── service/         # CountryService, KingService, TimelineService
│   ├── repository/      # CountryRepository, KingRepository
│   └── domain/
│       ├── entity/      # CountryEntity, KingEntity
│       └── dto/         # DTO classes
└── capital/
    ├── controller/      # CapitalController
    ├── service/         # CapitalService
    ├── repository/      # CapitalRepository
    └── domain/
        ├── entity/      # CapitalEntity
        └── dto/         # DTO classes
```

---

## 🔍 주요 설계 패턴

### 1. 연도 기반 필터링
모든 날짜 필드가 `Integer year` 형식으로 통일되어 프론트엔드 연동이 간단합니다.

**Before (LocalDate)**:
```json
{
  "warStartDate": "0918-06-15",
  "warEndDate": "0935-10-20"
}
```

**After (Integer year)**:
```json
{
  "warStartYear": 918,
  "warEndYear": 935
}
```

### 2. N+1 문제 해결
`LEFT JOIN FETCH`로 연관 데이터를 한번에 조회합니다.

```java
@Query("SELECT DISTINCT t FROM TradeEntity t LEFT JOIN FETCH t.routes WHERE ...")
List<TradeEntity> findTradesByCountryAndYear(@Param("countryId") UUID countryId, @Param("year") int year);
```

### 3. DTO 변환 패턴
Entity → DTO 변환을 정적 메서드로 처리합니다.

```java
public static TradeResponseDTO fromEntity(TradeEntity entity) {
    return TradeResponseDTO.builder()
        .tradeId(entity.getTradeId())
        .startCountryName(entity.getStartCountry().getCountryName())
        .routes(entity.getRoutes().stream()
            .map(TradeRouteResponseDTO::fromEntity)
            .collect(Collectors.toList()))
        .build();
}
```

---

## 🎯 프론트엔드 체크리스트

### 필수 구현 사항
- [ ] 연도 슬라이더 (780~1392)
- [ ] 선택된 연도로 War/Trade API 호출
- [ ] 지도 라이브러리 (Leaflet.js / Google Maps / Mapbox)
- [ ] GeoJSON 경로 렌더링
- [ ] 국가별 색상/필터링

### 권장 구현 사항
- [ ] 타임라인 이벤트 표시 (왕, 수도 변경)
- [ ] 전쟁/전투 마커 표시
- [ ] 무역 경로 애니메이션
- [ ] 국가 정보 툴팁/모달
- [ ] 연도별 자동 재생 기능

---

## 🐛 문제 해결

### 1. JSONB 타입 에러
**증상**: `column "path" is of type jsonb but expression is of type character varying`

**해결**: Entity에서 `@Column(columnDefinition = "jsonb")` 추가

### 2. N+1 쿼리 문제
**증상**: 무역 조회 시 경로마다 추가 쿼리 발생

**해결**: `LEFT JOIN FETCH` 사용

### 3. 날짜 형식 불일치
**증상**: 프론트에서 `LocalDate` 파싱 어려움

**해결**: 모든 날짜를 `Integer year`로 변경

---

## 📞 API 호출 순서 (권장)

```javascript
// 1. 초기 로딩 - 모든 국가 가져오기
const countries = await fetch('/api/countries').then(r => r.json());

// 2. 사용자가 연도 선택 (예: 1018)
const selectedYear = 1018;

// 3. 해당 연도의 전쟁 가져오기
const wars = await fetch(`/api/wars/${selectedYear}`).then(r => r.json());

// 4. 각 국가의 무역 경로 가져오기
const trades = await Promise.all(
  countries.map(country => 
    fetch(`/api/trades/${country.countryId}/${selectedYear}`).then(r => r.json())
  )
);

// 5. 타임라인 이벤트 가져오기 (선택사항)
const timeline = await fetch('/api/timeline/events').then(r => r.json());
const yearEvents = timeline.filter(e => 
  (e.startYear <= selectedYear && (e.endYear || Infinity) >= selectedYear) ||
  e.year === selectedYear
);

// 6. 지도에 데이터 렌더링
renderWars(wars);
renderTrades(trades.flat());
renderTimelineEvents(yearEvents);
```

---

## 📚 추가 문서

- `README.md`: 프로젝트 개요
- `README_GeoJSON.md`: GeoJSON 형식 상세 가이드
- `PROJECT_SETUP.md`: 개발 환경 설정

---

## 💡 팁

### 성능 최적화
1. **페이지네이션**: 대량 데이터 조회 시 페이징 적용 권장
2. **캐싱**: 국가 데이터는 변경이 적으므로 프론트엔드 캐싱 추천
3. **인덱싱**: `foundationYear`, `endedYear`, `tradeYear`에 DB 인덱스 적용

### 데이터 정합성
- 무역 데이터는 양쪽 국가가 모두 존재하는 연도만 반환됨
- 전쟁 데이터는 전투 정보를 포함하여 반환
- 타임라인은 왕/수도/사건이 혼합되므로 `type` 필드로 구분

---

## 📄 라이선스

이 프로젝트는 교육 목적으로 제작되었습니다.

---

## 👥 Contact

- Backend Team: lgcns2team
- Repository: backend
- Branch: main

---

**Happy Coding! 🚀**
