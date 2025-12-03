# API 엔드포인트 가이드

## 개요
이 문서는 전쟁(War)과 전투(Battle) 관리를 위한 REST API 엔드포인트를 설명합니다.

---

## War (전쟁) API

### Base URL
```
/api/wars
```

### 엔드포인트

#### 1. 모든 전쟁 조회
```http
GET /api/wars
```

**응답 예시:**
```json
[
  {
    "warId": "uuid",
    "name": "후삼국 통일 전쟁",
    "details": "왕건이 궁예를 몰아내고...",
    "warStartDate": "0918-06-15",
    "warEndDate": "0936-09-01",
    "result": "고려 승리, 후삼국 통일",
    "summary": "고창 전투와 일리천 전투에서...",
    "attackCountryId": "uuid",
    "attackCountryName": "고려",
    "defenceCountryId": "uuid",
    "defenceCountryName": "후백제"
  }
]
```

#### 2. 전쟁 상세 조회 (전투 포함)
```http
GET /api/wars/{warId}
```

**응답 예시:**
```json
{
  "warId": "uuid",
  "name": "여몽전쟁(대몽항쟁)",
  "details": "몽골 사신 피살 사건을 계기로...",
  "warStartDate": "1231-08-01",
  "warEndDate": "1270-05-01",
  "result": "강화 체결, 원 간섭기 시작",
  "summary": "귀주성·처인성·충주성 등에서...",
  "attackCountryId": "uuid",
  "attackCountryName": "몽골 제국",
  "defenceCountryId": "uuid",
  "defenceCountryName": "고려",
  "battles": [
    {
      "battleId": "uuid",
      "battleName": "처인성 전투",
      "details": "승려 김윤후가...",
      "latitude": 37.15,
      "longitude": 127.2,
      "winnerGeneral": "김윤후",
      "loserGeneral": "살리타",
      "battleDate": "1232-12-16",
      "markerRoute": {
        "type": "LineString",
        "coordinates": [[127.20, 37.15], ...]
      },
      "warId": "uuid",
      "warName": "여몽전쟁(대몽항쟁)"
    }
  ]
}
```

#### 3. 전쟁 생성
```http
POST /api/wars
Content-Type: application/json
```

**요청 예시:**
```json
{
  "name": "임진왜란",
  "details": "1592년 일본의 침략으로 시작된 전쟁",
  "warStartDate": "1592-04-13",
  "warEndDate": "1598-12-16",
  "result": "조선 승리",
  "summary": "이순신 장군의 활약으로...",
  "attackCountryId": "uuid",
  "defenceCountryId": "uuid"
}
```

#### 4. 전쟁 수정
```http
PUT /api/wars/{warId}
Content-Type: application/json
```

**요청 예시:**
```json
{
  "name": "임진왜란 (수정)",
  "summary": "이순신과 권율 장군의 활약으로..."
}
```

#### 5. 전쟁 삭제
```http
DELETE /api/wars/{warId}
```

---

## Battle (전투) API

### Base URL
```
/api/battles
```

### 엔드포인트

#### 1. 모든 전투 조회
```http
GET /api/battles
```

**응답 예시:**
```json
[
  {
    "battleId": "uuid",
    "battleName": "처인성 전투",
    "details": "승려 김윤후가 처인 부곡민과 함께...",
    "latitude": 37.15,
    "longitude": 127.2,
    "winnerGeneral": "김윤후",
    "loserGeneral": "살리타",
    "battleDate": "1232-12-16",
    "markerRoute": {
      "type": "LineString",
      "coordinates": [
        [127.20274993936692, 37.15092143813358],
        [127.19834015653862, 37.14652999816638]
      ]
    },
    "warId": "uuid",
    "warName": "여몽전쟁(대몽항쟁)"
  }
]
```

#### 2. 전투 상세 조회
```http
GET /api/battles/{battleId}
```

#### 3. 전쟁별 전투 조회
```http
GET /api/battles/war/{warId}
```

**응답:** 해당 전쟁에 속한 모든 전투 목록

#### 4. 전투명으로 검색
```http
GET /api/battles/search?name=처인성
```

**응답:** 전투명에 "처인성"이 포함된 전투 목록

#### 5. 전투 생성
```http
POST /api/battles
Content-Type: application/json
```

**요청 예시:**
```json
{
  "battleName": "명량 해전",
  "details": "이순신 장군이 12척의 배로...",
  "latitude": 34.57,
  "longitude": 126.31,
  "winnerGeneral": "이순신",
  "loserGeneral": "구루시마 미치후사",
  "battleDate": "1597-09-16",
  "markerRoute": "{\"type\":\"LineString\",\"coordinates\":[[126.31,34.57],[126.32,34.58]]}",
  "warId": "uuid"
}
```

#### 6. 전투 수정
```http
PUT /api/battles/{battleId}
Content-Type: application/json
```

**요청 예시:**
```json
{
  "battleName": "명량 대첩",
  "details": "이순신 장군이 13척의 배로... (수정)"
}
```

#### 7. 전투 삭제
```http
DELETE /api/battles/{battleId}
```

---

## Country (국가) API

### Base URL
```
/api/countries
```

### 엔드포인트

#### 1. 모든 국가 조회
```http
GET /api/countries
```

**응답 예시:**
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

#### 2. 국가 상세 조회
```http
GET /api/countries/{countryId}
```

#### 3. 국가 생성
```http
POST /api/countries
Content-Type: application/json
```

**요청 예시:**
```json
{
  "countryName": "조선",
  "foundationYear": 1392,
  "endedYear": 1910
}
```

#### 4. 국가 수정
```http
PUT /api/countries/{countryId}
Content-Type: application/json
```

#### 5. 국가 삭제
```http
DELETE /api/countries/{countryId}
```

---

## 테스트 가이드

### 1. 애플리케이션 실행
```bash
# 터미널에서 실행
./gradlew bootRun

# 또는 빌드 후 실행
./gradlew build
java -jar build/libs/haibackend-0.0.1-SNAPSHOT.jar
```

### 2. cURL로 테스트

#### 모든 전쟁 조회
```bash
curl -X GET http://localhost:8080/api/wars
```

#### 모든 전투 조회
```bash
curl -X GET http://localhost:8080/api/battles
```

#### 전투명으로 검색
```bash
curl -X GET "http://localhost:8080/api/battles/search?name=처인성"
```

#### 특정 전쟁의 전투 조회
```bash
curl -X GET http://localhost:8080/api/battles/war/{warId}
```

### 3. Postman으로 테스트

1. Postman 실행
2. Import → Raw text
3. 위의 예시 JSON을 붙여넣기
4. Send 버튼 클릭

---

## GeoJSON 데이터 활용

### 프론트엔드에서 지도에 표시하기

```javascript
// 전투 데이터 가져오기
fetch('http://localhost:8080/api/battles')
  .then(response => response.json())
  .then(battles => {
    battles.forEach(battle => {
      // 전투 위치 마커
      const marker = L.marker([battle.latitude, battle.longitude])
        .bindPopup(`<b>${battle.battleName}</b><br>${battle.details}`);
      
      // 이동 경로 표시
      if (battle.markerRoute) {
        const coordinates = battle.markerRoute.coordinates.map(
          coord => [coord[1], coord[0]] // [경도, 위도] → [위도, 경도]
        );
        
        const polyline = L.polyline(coordinates, {
          color: '#ef4444',
          weight: 2
        });
        
        marker.addTo(map);
        polyline.addTo(map);
      }
    });
  });
```

---

## 에러 응답

### 404 Not Found
```json
{
  "error": "War not found with id: {warId}"
}
```

### 500 Internal Server Error
```json
{
  "error": "Internal server error message"
}
```

---

## 데이터베이스 초기화

애플리케이션 실행 시 자동으로 다음 순서로 초기화됩니다:

1. `schema.sql` - 테이블 생성 및 기본값 설정
2. `data.sql` - 초기 국가/전쟁/전투 데이터 삽입
3. `update_battles.sql` - GeoJSON 경로 데이터 업데이트

수동으로 초기화하려면:
```bash
psql -d your_database -f src/main/resources/schema.sql
psql -d your_database -f src/main/resources/data.sql
psql -d your_database -f src/main/resources/update_battles.sql
```

---

## 프로젝트 구조

```
src/main/java/com/lgcns/haibackend/
├── country/
│   ├── controller/
│   │   └── CountryController.java
│   ├── service/
│   │   └── CountryService.java
│   ├── repository/
│   │   └── CountryRepository.java
│   └── domain/
│       ├── entity/
│       │   └── CountryEntity.java
│       └── dto/
│           ├── CountryRequestDTO.java
│           └── CountryResponseDTO.java
│
└── war/
    ├── controller/
    │   ├── WarController.java
    │   └── BattleController.java
    ├── service/
    │   ├── WarService.java
    │   └── BattleService.java
    ├── repository/
    │   ├── WarRepository.java
    │   └── BattleRepository.java
    └── domain/
        ├── entity/
        │   ├── WarEntity.java
        │   └── BattleEntity.java
        └── dto/
            ├── WarRequestDTO.java
            ├── WarResponseDTO.java
            ├── BattleRequestDTO.java
            └── BattleResponseDTO.java
```
