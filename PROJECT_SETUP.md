# 프로젝트 설정 완료 보고서

## 작업 요약
GeoJSON 이동 경로 데이터를 프로젝트에 통합하고 데이터베이스 스키마를 조정했습니다.

---

## 변경 사항

### 1. 데이터베이스 스키마 수정
**파일**: `src/main/resources/data.sql`

- `battle` 테이블의 INSERT 문에 `markerRoute` 컬럼 추가
- 모든 기존 전투 데이터에 NULL 값으로 markerRoute 설정 (나중에 업데이트 예정)

**변경 전**:
```sql
INSERT INTO battle (
    battle_name, details, latitude, longitude,
    winner_general, loser_general, battle_date, war_id
) VALUES ...
```

**변경 후**:
```sql
INSERT INTO battle (
    battle_name, details, latitude, longitude,
    winner_general, loser_general, battle_date, war_id, markerRoute
) VALUES ...
```

### 2. GeoJSON 경로 데이터 업데이트 스크립트 생성
**파일**: `src/main/resources/update_battles.sql` (신규 생성)

다음 전투에 대한 이동 경로 데이터 추가:

#### 처인성 전투 (1232년)
- **경로 타입**: LineString
- **좌표 수**: 7개 지점 (간소화된 버전)
- **색상**: #ef4444 (빨강)

#### 충주성 전투 (1253년)
- **경로 타입**: LineString
- **좌표 수**: 7개 지점 (간소화된 버전)
- **색상**: #ef4444 (빨강)

#### 삼별초의 항쟁 (1270년)
- **경로 타입**: MultiLineString (다중 경로)
- **설명**: 진도와 제주도로의 이동 경로

#### 합천 전투 (1270년) - 신규 추가
- **경로 타입**: LineString
- **좌표 수**: 5개 지점
- **설명**: 여몽연합군의 삼별초 추격 경로

### 3. 문서화
**파일**: `README_GeoJSON.md` (신규 생성)

다음 내용을 포함한 종합 가이드 문서:
- 데이터베이스 스키마 설명
- GeoJSON 형식 설명 (LineString, MultiLineString)
- 포함된 전투 경로 데이터 목록
- 데이터 적용 방법
- API 응답 예시
- 프론트엔드 통합 예시 (Leaflet.js, Google Maps)
- 주의사항 및 참고 자료

---

## 데이터베이스 구조

### Battle Entity 필드
```java
@Entity
@Table(name = "battle")
public class BattleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID battleId;
    
    private String battleName;
    
    @Column(columnDefinition = "TEXT")
    private String details;
    
    private Double latitude;
    private Double longitude;
    
    private String winnerGeneral;
    private String loserGeneral;
    
    private LocalDate battleDate;
    
    // 이동 경로 (지도에서 사용할 좌표)
    @Column(name = "markerRoute", columnDefinition = "jsonb")
    private String markerRoute;  // ← GeoJSON 형식
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "war_id", nullable = false)
    private WarEntity war;
}
```

---

## 실행 방법

### 1. 데이터베이스 초기화
```bash
# PostgreSQL 데이터베이스 생성
createdb your_database_name

# 스키마 생성
psql -d your_database_name -f src/main/resources/schema.sql

# 초기 데이터 삽입
psql -d your_database_name -f src/main/resources/data.sql

# GeoJSON 경로 데이터 업데이트
psql -d your_database_name -f src/main/resources/update_battles.sql
```

### 2. Spring Boot 애플리케이션 실행
```bash
# 환경 변수 설정 (.env 파일 또는 직접 설정)
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/your_database_name
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_password

# 애플리케이션 실행
./gradlew bootRun
```

**또는**

application.yaml이 자동으로 data.sql과 update_battles.sql을 실행하도록 설정되어 있습니다:
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: create  # 테이블 자동 생성
    defer-datasource-initialization: true  # 데이터 초기화 지연
  sql:
    init:
      mode: always  # 항상 SQL 스크립트 실행
```

---

## 원본 GeoJSON 데이터

**파일**: `c:\Users\user\Downloads\1235_1239.geojson`

### 포함된 경로:
1. **충주** - LineString (약 1,448개 좌표)
2. **처인성** - LineString (약 287개 좌표)
3. **합천** - LineString (약 806개 좌표)
4. **삼별초** (2개 경로) - MultiLineString

### 데이터 크기 고려사항
원본 GeoJSON 파일의 좌표 수가 매우 많아 데이터베이스에 저장 시 다음과 같이 간소화했습니다:
- 처인성: 287개 → 7개 대표 지점
- 충주: 1,448개 → 7개 대표 지점
- 합천: 806개 → 5개 대표 지점

**전체 경로 데이터가 필요한 경우**, `update_battles.sql` 파일에서 전체 좌표 배열로 교체하면 됩니다.

---

## 프론트엔드 통합 예시

### React + Leaflet
```javascript
import { MapContainer, TileLayer, Polyline, Marker, Popup } from 'react-leaflet';

function BattleMap() {
  const [battles, setBattles] = useState([]);

  useEffect(() => {
    fetch('/api/battles')
      .then(res => res.json())
      .then(data => setBattles(data));
  }, []);

  return (
    <MapContainer center={[36.5, 127.5]} zoom={7}>
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      
      {battles.map(battle => (
        <React.Fragment key={battle.battleId}>
          {/* 전투 위치 마커 */}
          <Marker position={[battle.latitude, battle.longitude]}>
            <Popup>
              <h3>{battle.battleName}</h3>
              <p>{battle.details}</p>
              <p>날짜: {battle.battleDate}</p>
              <p>승자: {battle.winnerGeneral}</p>
            </Popup>
          </Marker>
          
          {/* 이동 경로 */}
          {battle.markerRoute && (
            <Polyline
              positions={battle.markerRoute.coordinates.map(
                coord => [coord[1], coord[0]]  // [경도, 위도] → [위도, 경도]
              )}
              color="#ef4444"
              weight={2}
              opacity={0.8}
            />
          )}
        </React.Fragment>
      ))}
    </MapContainer>
  );
}
```

---

## 테스트 방법

### 1. 데이터 확인
```sql
-- 모든 전투 데이터 조회
SELECT battle_name, latitude, longitude, 
       markerRoute IS NOT NULL as has_route
FROM battle;

-- 특정 전투의 경로 데이터 확인
SELECT battle_name, markerRoute
FROM battle
WHERE battle_name = '처인성 전투';

-- 경로 데이터가 있는 전투만 조회
SELECT battle_name, 
       jsonb_array_length(markerRoute->'coordinates') as route_points
FROM battle
WHERE markerRoute IS NOT NULL;
```

### 2. API 테스트
```bash
# 모든 전투 조회
curl http://localhost:8080/api/battles

# 특정 전투 조회
curl http://localhost:8080/api/battles/{battleId}
```

---

## 향후 개선 사항

1. **전체 경로 데이터 적용**
   - 현재는 간소화된 버전 사용
   - 필요시 전체 좌표 데이터로 교체

2. **경로 데이터 최적화**
   - Douglas-Peucker 알고리즘으로 경로 단순화
   - 줌 레벨에 따른 동적 상세도 조정

3. **추가 전투 데이터**
   - 나머지 전투들의 이동 경로 추가
   - 역사 자료 기반 경로 재구성

4. **API 확장**
   - 전투별 상세 정보 API
   - 시대별/전쟁별 필터링 기능
   - GeoJSON 직접 반환 엔드포인트

---

## 참고 파일

- `src/main/resources/schema.sql` - 테이블 스키마
- `src/main/resources/data.sql` - 초기 데이터 (전쟁, 전투)
- `src/main/resources/update_battles.sql` - GeoJSON 경로 업데이트
- `src/main/resources/application.yaml` - Spring Boot 설정
- `README_GeoJSON.md` - 상세 가이드 문서
- `src/main/java/.../BattleEntity.java` - Battle 엔티티 정의

---

## 문의 및 지원

프로젝트 관련 문의사항이 있으시면 이슈를 생성해주세요.
