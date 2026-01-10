# H.AI Backend (Spring Boot)

본 저장소는 **H.AI (History AI)** 프로젝트의 **Spring Boot 기반 핵심 백엔드 레포지토리**입니다.

H.AI는 한국사 데이터를 중심으로 국가·전쟁·전투·주요사건·무역·수도·인물(왕) 정보를 구조화하여 제공하고, 프론트엔드와 연동해 **지도 기반 역사 시각화**, **회원 관리**, **웹소켓 기반 실시간 토론**, **AI 역사 인물 서비스**를 구현하는 것을 목표로 합니다.

## (1) 프로젝트 구성 안내
### 프로젝트 개요
H.AI는 “살아있는 역사 교과서”를 목표로 하는 역사 정보 플랫폼입니다.

본 백엔드 레포지토리는 다음 역할을 담당합니다.

- 역사 도메인 데이터 제공 (국가, 전쟁, 전투, 주요 사건, 무역, 수도, 왕)
- 지도 기반 시각화를 위한 위치 및 경로 데이터 제공
- 회원 관리
- 웹소켓 기반 실시간 토론 기능
- AI 인물 및 챗봇 기능과 연계되는 서버 사이드 로직

### 기술 스택
- Java 17
- Spring Boot 3.x
- Spring Data JPA / Hibernate
- WebSocket (STOMP)
- PostgreSQL (JSONB 활용)
- Redis (채팅, 세션, 제재 관리)
- Gradle

---

## (2) 프로젝트 설치하는 방법
### 1. 사전 요구 사항
- JDK 17 이상
- PostgreSQL
- Redis
- Gradle Wrapper 사용 가능 환경

### 2. 환경 변수 설정
```env
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/hai_db
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_password

REDIS_HOST=localhost
REDIS_PORT=6379
```

### 3. 데이터베이스 생성
```sql
CREATE DATABASE hai_db;
```

### 4. 프로젝트 실행
```bash
./gradlew clean build
./gradlew bootRun
```

## (3) 프로젝트 사용법

### 기본 동작 방식

- 프론트엔드는 본 API를 호출하여 다음 기능을 수행합니다.
  - 지도 위에 역사 정보 표시
  - 타임라인 기반 데이터 탐색
  - 실시간 토론 참여
- 인증된 사용자는 토론 참여 및 AI 인물과의 상호작용이 가능합니다.

### 주요 접근 URL

- REST API Base URL: `http://localhost:8081`
- WebSocket Endpoint: `/ws`

---

## (4) 프로젝트 기능 설명

### 1. 역사 데이터 제공

다음 도메인 데이터를 REST API 형태로 제공합니다.

- 국가 (Country)
- 전쟁 (War)
- 전투 (Battle)
- 주요사건 (MainEvent)
- 무역 및 무역 경로 (Trade, TradeRoute)
- 수도 (Capital)
- 인물 및 왕 (King)

해당 데이터는 프론트엔드에서 지도 및 타임라인 UI와 연동되어 시각화됩니다.

### 2. 지도 기반 시각화 지원

- 전투 및 무역 이동 경로 데이터 제공
- 좌표 및 경로 기반 정보 조회 지원

### 3. 회원 관리

- 회원 가입 및 로그인
- 사용자 권한 관리

### 4. 실시간 토론 기능

- WebSocket(STOMP) 기반 실시간 토론
- 역사 주제별 토론방 운영 가능
- Redis를 활용한 메시지 처리 및 관리
- 욕설/비속어 필터링 및 제재

### 5. AI 인물 및 챗봇 연계

- AI 역사 인물(aiPerson) 조회 기능
- 챗봇(chatbot) 메세지 조회 기능 제공

---

## (5) 저작권 및 사용권 정보

본 프로젝트는 학습 및 연구 목적의 프로젝트입니다.

- 소스 코드는 MIT License를 따릅니다.
- 역사 데이터의 해석 및 활용에 대한 책임은 사용자에게 있습니다.
- 상업적 활용 시 출처 표기를 권장합니다.

---

## (6) 버그

현재 알려진 이슈:

- 일부 도메인 기능 고도화 필요
- 대규모 실시간 토론 시 성능 최적화 필요
- 지도 시각화 데이터 정합성 검증 강화 필요

버그 제보 및 개선 요청은 GitHub Issues를 통해 관리합니다.

---

## (7) 프로그램 작성자 및 도움을 준 사람

### 작성자

- H.AI 프로젝트 팀

### 참고 및 도움

- 한국사 공개 자료 및 학술 데이터
- Spring Boot, JPA, WebSocket 공식 문서
- PostgreSQL 및 Redis 공식 문서

---

## (8) 버전 (업데이트 소식)

### v0.1

- 기본 역사 도메인(Entity) 설계
- 국가 / 전쟁 / 전투 데이터 제공
- 지도 기반 시각화 연계 구조 구축

### v0.2

- 회원 관리 기능 추가
- 실시간 토론(WebSocket) 기능 추가
- Redis 기반 메시지 및 제재 관리

### v0.3 (예정)

- AI 인물 및 챗봇 기능 고도화
- 타임라인 및 지도 연계 성능 개선
- API 문서화(OpenAPI) 추가

---

## (9) FAQ

### Q. 이 레포지토리만으로 서비스가 동작하나요?

A. 본 레포지토리는 핵심 백엔드 서버이며, 프론트엔드 및 AI 서비스와 함께 사용됩니다.

### Q. 지도 시각화는 어디서 처리하나요?

A. 지도 렌더링은 프론트엔드에서 담당하며, 본 서버는 좌표 및 경로 데이터를 제공합니다.

### Q. 실시간 토론은 어떤 방식인가요?

A. WebSocket(STOMP) 기반으로 구현되어 있으며, Redis를 활용해 메시지를 관리합니다.


## 프로젝트 구조
```pgsql
src/main/java/com/lgcns/haibackend
├── HaibackendApplication.java
├── aiPerson
├── capital
├── chatbot
├── common
│   ├── redis
├── country
├── discussion
├── global
├── mainEvent
├── moderation
├── trade
├── tradeRoute
├── user
├── util
└── war
```

마지막 업데이트: 2026-01
