# Backend API Documentation

## 프로젝트 개요
한국 고대 및 중세 역사 지리 정보 시스템 백엔드 API

### 기술 스택
- **Framework**: Spring Boot 3.4.12
- **Language**: Java 17
- **Database**: PostgreSQL
- **ORM**: Spring Data JPA
- **Build Tool**: Gradle

---

## 데이터베이스 ERD

### 주요 엔티티

#### 1. Country (국가)
국가 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| countryId | Long | 국가 ID (PK, Auto Increment) |
| countryName | String | 국가명 |
| foundationYear | Integer | 건국 연도 |
| endedYear | Integer | 멸망 연도 |

**관계**
- War (attackCountry, defenceCountry) - OneToMany
- Capital - OneToMany
- King - OneToMany
- Trade - OneToMany

---

#### 2. Capital (수도)
국가의 수도 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| capitalId | Long | 수도 ID (PK, Auto Increment) |
| capitalName | String | 수도명 |
| startedDate | Date | 수도 시작 일자 |
| endedDate | Date | 수도 종료 일자 |
| longitude | Double | 경도 |
| latitude | Double | 위도 |
| description | String(1000) | 수도 설명 |
| country | CountryEntity | 국가 FK (ManyToOne) |

**샘플 데이터**
- 금성(경주) - 신라
- 상경 용천부 - 발해
- 완산주(전주) - 후백제
- 송악(개성) - 고려
- 철원 - 후고구려
- 강화도 - 고려 임시 수도

---

#### 3. King (왕)
왕의 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| kingId | String | 왕 ID (PK, 예: KING_001) |
| kingName | String | 왕 이름 |
| regnalName | String | 묘호/시호 |
| startedDate | Date | 재위 시작일 |
| endedDate | Date | 재위 종료일 |
| country | CountryEntity | 국가 FK (ManyToOne) |

**샘플 데이터**
- 견훤 (후백제), 신검 (후백제)
- 궁예 (후고구려)
- 왕건(태조), 왕소(광종), 왕치(성종), 왕순(현종), 왕해(인종), 왕철(고종), 왕전(공민왕) - 고려
- 김만(진성여왕), 김부(경순왕) - 신라
- 대인수(선왕) - 발해

---

#### 4. War (전쟁)
전쟁 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| id (warId) | Long | 전쟁 ID (PK, Auto Increment) |
| name | String | 전쟁명 |
| details | Text | 전쟁 상세 설명 |
| warStartDate | LocalDate | 전쟁 시작일 |
| warEndDate | LocalDate | 전쟁 종료일 |
| result | String | 전쟁 결과 |
| summary | Text | 전쟁 요약 |
| attackCountry | CountryEntity | 공격국 FK (ManyToOne) |
| defenceCountry | CountryEntity | 방어국 FK (ManyToOne) |

**관계**
- Battle - OneToMany (cascade)

---

#### 5. Battle (전투)
전쟁 내 개별 전투 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| id (battleId) | Long | 전투 ID (PK, Auto Increment) |
| battleName | String | 전투명 |
| details | Text | 전투 상세 설명 |
| latitude | Double | 위도 |
| longitude | Double | 경도 |
| winnerGeneral | String | 승리 장군 |
| loserGeneral | String | 패배 장군 |
| battleDate | LocalDate | 전투 일자 |
| markerRoute | JSONB | 이동 경로 (지도 마커용) |
| war | War | 전쟁 FK (ManyToOne) |

---

#### 6. Trade (무역)
국가 간 무역 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| tradeId | Long | 무역 ID (PK, Auto Increment) |
| startCountryId | CountryEntity | 시작 국가 FK (ManyToOne) |
| endCountryId | CountryEntity | 종료 국가 FK (ManyToOne) |
| tradeYear | Integer | 무역 연도 |
| product | String | 무역 품목 |

**관계**
- TradeRoute - OneToMany

---

#### 7. TradeRoute (무역 경로)
무역의 구체적인 경로 정보를 관리하는 엔티티

| 필드명 | 타입 | 설명 |
|--------|------|------|
| routeId | Long | 경로 ID (PK, Auto Increment) |
| trade | TradeEntity | 무역 FK (ManyToOne) |
| tags | Integer | 경로 유형 (0=육상, 1=해상) |
| path | JSONB | 경로 좌표 배열 (JSON 문자열) |

---

## API 엔드포인트 (예정)

### Country API
```
GET    /api/countries           # 모든 국가 목록 조회
GET    /api/countries/{id}      # 특정 국가 상세 조회
POST   /api/countries           # 국가 생성
PUT    /api/countries/{id}      # 국가 수정
DELETE /api/countries/{id}      # 국가 삭제
```

### Capital API
```
GET    /api/capitals            # 모든 수도 목록 조회
GET    /api/capitals/{id}       # 특정 수도 상세 조회
GET    /api/capitals/country/{countryId}  # 특정 국가의 수도 목록
POST   /api/capitals            # 수도 생성
PUT    /api/capitals/{id}       # 수도 수정
DELETE /api/capitals/{id}       # 수도 삭제
```

### King API
```
GET    /api/kings               # 모든 왕 목록 조회
GET    /api/kings/{id}          # 특정 왕 상세 조회
GET    /api/kings/country/{countryId}  # 특정 국가의 왕 목록
POST   /api/kings               # 왕 생성
PUT    /api/kings/{id}          # 왕 수정
DELETE /api/kings/{id}          # 왕 삭제
```

### War API
```
GET    /api/wars                # 모든 전쟁 목록 조회
GET    /api/wars/{id}           # 특정 전쟁 상세 조회 (전투 목록 포함)
GET    /api/wars/country/{countryId}  # 특정 국가가 참여한 전쟁 목록
POST   /api/wars                # 전쟁 생성
PUT    /api/wars/{id}           # 전쟁 수정
DELETE /api/wars/{id}           # 전쟁 삭제
```

### Battle API
```
GET    /api/battles             # 모든 전투 목록 조회
GET    /api/battles/{id}        # 특정 전투 상세 조회
GET    /api/battles/war/{warId} # 특정 전쟁의 전투 목록
POST   /api/battles             # 전투 생성
PUT    /api/battles/{id}        # 전투 수정
DELETE /api/battles/{id}        # 전투 삭제
```

### Trade API
```
GET    /api/trades              # 모든 무역 목록 조회
GET    /api/trades/{id}         # 특정 무역 상세 조회 (경로 포함)
GET    /api/trades/country/{countryId}  # 특정 국가의 무역 목록
POST   /api/trades              # 무역 생성
PUT    /api/trades/{id}         # 무역 수정
DELETE /api/trades/{id}         # 무역 삭제
```

### TradeRoute API
```
GET    /api/trade-routes        # 모든 무역 경로 목록 조회
GET    /api/trade-routes/{id}   # 특정 무역 경로 상세 조회
GET    /api/trade-routes/trade/{tradeId}  # 특정 무역의 경로 목록
POST   /api/trade-routes        # 무역 경로 생성
PUT    /api/trade-routes/{id}   # 무역 경로 수정
DELETE /api/trade-routes/{id}   # 무역 경로 삭제
```

---

## 환경 설정

### application.yaml
```yaml
spring:
  datasource:
    url: ${SPRING_DATASOURCE_URL}
    username: ${SPRING_DATASOURCE_USERNAME}
    password: ${SPRING_DATASOURCE_PASSWORD}
    driver-class-name: org.postgresql.Driver
  
  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
    show-sql: true
```

### 환경 변수
프로젝트 루트에 `.env` 파일 생성:
```env
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/your_database
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_password
```

---

## 실행 방법

### 1. 프로젝트 클론
```bash
git clone https://github.com/lgcns2team/backend.git
cd backend
```

### 2. 환경 변수 설정
`.env` 파일을 생성하고 데이터베이스 연결 정보를 입력합니다.

### 3. 빌드 및 실행
```bash
# Gradle 빌드
./gradlew build

# 애플리케이션 실행
./gradlew bootRun
```

### 4. 데이터 초기화
애플리케이션 실행 시 `data.sql` 파일의 초기 데이터가 자동으로 로드됩니다.

---

## 개발 현황

### 완료
- ✅ Country 엔티티
- ✅ Capital 엔티티 및 초기 데이터
- ✅ King 엔티티 및 초기 데이터
- ✅ War 엔티티
- ✅ Battle 엔티티
- ✅ Trade 엔티티
- ✅ TradeRoute 엔티티

### 진행 중
- 🚧 REST API 컨트롤러 개발
- 🚧 서비스 레이어 구현
- 🚧 DTO 정의

### 예정
- 📋 API 문서화 (Swagger/OpenAPI)
- 📋 인증/인가
- 📋 테스트 코드 작성

---

## 브랜치 전략
- `main`: 프로덕션 브랜치
- `develop`: 개발 브랜치
- `feature/*`: 기능 개발 브랜치

## 라이센스
MIT License
