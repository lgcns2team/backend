# GeoJSON 이동 경로 데이터 통합 가이드

## 개요
이 프로젝트는 역사적 전투 데이터를 관리하며, 각 전투의 이동 경로를 GeoJSON 형식으로 저장합니다.

## 데이터베이스 스키마

### Battle 테이블
- `battleId` (UUID): 전투 고유 ID
- `battleName` (VARCHAR): 전투 이름
- `details` (TEXT): 전투 상세 설명
- `latitude` (DOUBLE): 전투 위치 위도
- `longitude` (DOUBLE): 전투 위치 경도
- `winnerGeneral` (VARCHAR): 승자 장군
- `loserGeneral` (VARCHAR): 패자 장군
- `battleDate` (DATE): 전투 날짜
- `markerRoute` (JSONB): **이동 경로 데이터 (GeoJSON 형식)**
- `warId` (UUID): 전쟁 FK

## GeoJSON 데이터 형식

### 단일 경로 (LineString)
```json
{
  "type": "LineString",
  "coordinates": [
    [경도, 위도],
    [경도, 위도],
    ...
  ]
}
```

### 다중 경로 (MultiLineString)
```json
{
  "type": "MultiLineString",
  "coordinates": [
    [
      [경도, 위도],
      [경도, 위도]
    ],
    [
      [경도, 위도],
      [경도, 위도]
    ]
  ]
}
```

## 포함된 전투 경로 데이터

### 1235-1239년 여몽전쟁 관련 전투

#### 1. 처인성 전투 (1232년)
- **전투명**: 처인성 전투
- **장소**: 경기도 용인 (37.15°N, 127.2°E)
- **경로 타입**: LineString
- **설명**: 승려 김윤후가 처인 부곡민과 함께 몽골군 사령관 살리타를 사살

#### 2. 충주성 전투 (1253년)
- **전투명**: 충주성 전투
- **장소**: 충청북도 충주 (36.97°N, 127.93°E)
- **경로 타입**: LineString
- **설명**: 김윤후가 노비 문서를 불태우며 관노비들을 격려하여 몽골군을 격퇴

#### 3. 삼별초의 항쟁 (1270년)
- **전투명**: 삼별초의 항쟁
- **장소**: 진도/제주 (34.48°N, 126.26°E)
- **경로 타입**: MultiLineString (여러 이동 경로)
- **설명**: 개경 환도에 반대하여 진도와 제주도로 이동하며 벌인 최후의 항전

#### 4. 합천 전투 (1270년)
- **전투명**: 합천 전투
- **장소**: 경상남도 합천 (35.56°N, 128.16°E)
- **경로 타입**: LineString
- **설명**: 여몽연합군이 삼별초를 추격하며 합천 일대에서 벌인 전투

## 데이터 적용 방법

### 1. 초기 데이터 로드
```bash
# schema.sql 실행 (테이블 생성 및 기본값 설정)
psql -d your_database -f src/main/resources/schema.sql

# data.sql 실행 (초기 데이터 삽입)
psql -d your_database -f src/main/resources/data.sql

# update_battles.sql 실행 (GeoJSON 경로 데이터 업데이트)
psql -d your_database -f src/main/resources/update_battles.sql
```

### 2. Spring Boot 애플리케이션에서 자동 실행
`application.properties` 또는 `application.yml`에 다음 설정 추가:

```properties
spring.sql.init.mode=always
spring.sql.init.schema-locations=classpath:schema.sql
spring.sql.init.data-locations=classpath:data.sql,classpath:update_battles.sql
```

## API 응답 예시

### Battle Entity 조회
```json
{
  "battleId": "uuid-here",
  "battleName": "처인성 전투",
  "details": "승려 김윤후가 처인 부곡민과 함께 몽골군 사령관 살리타를 사살하여 물리침.",
  "latitude": 37.15,
  "longitude": 127.2,
  "winnerGeneral": "김윤후",
  "loserGeneral": "살리타",
  "battleDate": "1232-12-16",
  "markerRoute": {
    "type": "LineString",
    "coordinates": [
      [127.20274993936692, 37.15092143813358],
      [127.19834015653862, 37.14652999816638],
      ...
    ]
  }
}
```

## 프론트엔드에서 사용하기

### Leaflet.js 예시
```javascript
// Battle 데이터 가져오기
fetch('/api/battles/처인성 전투')
  .then(response => response.json())
  .then(battle => {
    // 지도에 이동 경로 그리기
    const routeCoordinates = battle.markerRoute.coordinates.map(
      coord => [coord[1], coord[0]] // [경도, 위도] -> [위도, 경도]
    );
    
    const polyline = L.polyline(routeCoordinates, {
      color: '#ef4444',
      weight: 2,
      opacity: 0.8
    }).addTo(map);
    
    // 전투 위치 마커
    const marker = L.marker([battle.latitude, battle.longitude])
      .bindPopup(`<b>${battle.battleName}</b><br>${battle.details}`)
      .addTo(map);
  });
```

### Google Maps API 예시
```javascript
fetch('/api/battles/처인성 전투')
  .then(response => response.json())
  .then(battle => {
    const path = battle.markerRoute.coordinates.map(
      coord => ({ lat: coord[1], lng: coord[0] })
    );
    
    const routePath = new google.maps.Polyline({
      path: path,
      geodesic: true,
      strokeColor: '#ef4444',
      strokeOpacity: 0.8,
      strokeWeight: 2
    });
    
    routePath.setMap(map);
  });
```

## 주의사항

1. **좌표 순서**: GeoJSON은 [경도, 위도] 순서를 사용하지만, 대부분의 지도 라이브러리는 [위도, 경도] 순서를 사용합니다.
2. **JSONB 타입**: PostgreSQL의 JSONB 타입을 사용하여 효율적인 쿼리와 인덱싱이 가능합니다.
3. **데이터 크기**: 전체 경로 데이터가 큰 경우 페이지네이션이나 간소화된 경로를 사용하는 것을 권장합니다.

## 파일 구조
```
backend/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/lgcns/haibackend/
│   │   │       └── war/
│   │   │           └── domain/
│   │   │               └── entity/
│   │   │                   └── BattleEntity.java
│   │   └── resources/
│   │       ├── schema.sql           # 테이블 스키마 및 기본값 설정
│   │       ├── data.sql             # 초기 국가/전쟁/전투 데이터
│   │       └── update_battles.sql   # GeoJSON 경로 데이터 업데이트
│   └── test/
├── build.gradle
└── README_GeoJSON.md
```

## 참고 자료
- [GeoJSON 스펙](https://geojson.org/)
- [PostgreSQL JSONB 문서](https://www.postgresql.org/docs/current/datatype-json.html)
- [Leaflet.js](https://leafletjs.com/)
- [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript)
