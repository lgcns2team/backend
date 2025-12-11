-- 무역 초기 데이터
INSERT INTO trade (trade_id, start_country_id, end_country_id, trade_year, product)
VALUES
/* ========================================================================= */
/* 1. 통일 신라의 대외 교류 (8세기~10세기 초) */
/* ========================================================================= */

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    800,
    '고급 직물, 유기그릇, 향료(당에서 수입 후 일본에 판매)'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '당'),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    800,
    '비단, 향료 (중계 무역을 위한 수입)'
),


-- ------------------------------------------------------------------------
-- 2. 발해의 대외 교류 (8세기~10세기 초)
-- ------------------------------------------------------------------------

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '당'),
    800,
    '담비·호랑이 가죽, 인삼, 약재 수출'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '당'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    800,
    '각종 비단, 금은그릇 수입'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    800,
    '담비 가죽, 인삼 수출'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    800,
    '각종 비단'
),

-- 통일 신라 <-> 발해 교류 (8세기~10세기 초)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    800,
    '사신 및 문물 교류 (신라도)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    800,
    '사신 및 문물 교류 (신라도)'
),



(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'), /* 거란/유목 민족 */
    800,
    '모피 교역 (담비 가죽 등)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    800,
    '유목 민족 물품 (소그드 은화 등)'
),

/* ========================================================================= */
/* 3. 고려의 대외 교류 (10세기~11세기) */
/* ========================================================================= */

-- 고려 <-> 송 (청자, 서적, 약재 등 문물 교류 활발)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '송'),
    1020,
    '금, 은, 나전칠기, 화문석, 인삼 먹'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '송'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1020,
    '비단, 약재, 서적, 자기'
),

-- 고려 <-> 거란(요나라이전) (강동 6주 확보 후 교류 시작)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    1020,
    '농기구, 곡식, 문방구'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1020,
    '은, 모피, 말'
),
-- 고려 <-> 여진
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1020,
    '은, 모피, 말'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    1020,
    '농기구, 곡식, 포목'
),
-- 고려 <-> 일본
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1020,
    '유황, 수은'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    1020,
    '곡식, 인삼, 서적'
),

-- 고려 <-> 아바스 왕조 (해상 실크로드를 통한 이슬람 상인 교역)
-- 고려사 기록: 현종 15년(1024) 대식국 열라자 등 100여 명 도착
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '아바스 왕조'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1024,
    '수은, 용치(상아), 점성향, 몰약, 소목'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '아바스 왕조'),
    1024,
    '금, 은, 인삼, 나전칠기, 비단'
);

/* ========================================================================= */
/* 4. 조선 전기의 대외 교류 (15세기) - 국제 무역                             */
/* ========================================================================= */

INSERT INTO trade (trade_id, start_country_id, end_country_id, trade_year, product)
VALUES
-- 조선 -> 명 무역 (조공 무역)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '명'),
    1450,
    '금, 은, 인삼, 비단, 도자기, 서적, 약재'
),

-- 명 -> 조선 무역
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '명'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '비단, 도자기, 서적, 약재'
),

-- 조선 -> 여진 무역
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    1450,
    '식량, 농기구'
),

-- 여진 -> 조선 무역
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '말, 모피, 은'
),

-- 조선 -> 일본 (3포 무역: 부산포, 염포, 제포)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    1450,
    '구리, 황, 원료, 식량, 의복, 서적'
),

-- 일본 -> 조선 (3포 무역)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '구리, 황'
),

-- 류큐 -> 조선 무역
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '류큐'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '향료, 후추, 동남아시아 물산'
),

-- 시암 -> 조선 무역 (류큐 중계)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '시암'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '향료, 후추, 상아, 동남아시아 특산품'
),

-- 자와 -> 조선 무역 (류큐 중계)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '자와'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1450,
    '향료, 후추, 동남아시아 향신료'
);

/* ========================================================================= */
/* 5. 조선 후기의 대외 교류 (17세기) - 연행사, 통신사                        */
/* ========================================================================= */

INSERT INTO trade (trade_id, start_country_id, end_country_id, trade_year, product)
VALUES
-- 조선 -> 청 무역 (연행사 조공 무역)
-- 1637년 병자호란 이후 청에 연행사 파견 시작, 1894년까지 507회 파견
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '청'),
    1650,
    '인삼, 비단, 모피, 서적, 도자기, 종이, 붓'
),

-- 청 -> 조선 무역 (연행사 귀환)
-- 연행사들이 청에서 구매해 온 물품
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '청'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1650,
    '비단, 도자기, 서적, 약재, 차, 칠기'
),

-- 조선 -> 일본 무역 (통신사 교린 무역)
-- 1607년부터 1811년까지 12차례 통신사 파견
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    1650,
    '인삼, 서화, 서적, 유학 경전, 도자기 기술'
),

-- 일본 -> 조선 무역 (통신사 사행)
-- 일본에서 조선에 선물한 물품
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    1650,
    '구리, 황, 후추, 은, 뿔'
);

-- =========================================================================
-- 무역 경로 초기 데이터 (trade_route) - 실제 역사적 무역로 반영
-- =========================================================================

-- 통일 신라 -> 일본 (800년) - 신라 당은포 완도 하카타 금성
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.82517931482953,37.159721185125576],[126.034363870032,36.71183524767756],[125.93551193943227,36.20814971540542],[126.83616286267394,35.97731377548968],[125.81469291314377,35.428606255116534],[125.71584098254407,34.74533168293482],[125.83591211335397,34.114678141701894],[126.68585500206511,34.33417681379868],[127.77514360200713,33.9516640630482],[129.35726382098602,33.74637198890698],[130.64865087547815,33.80385857505324],[129.62639827696205,35.23596920828449],[129.38476022438502,35.56286183472921],[129.20353168495222,35.794907256105795]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 800;

-- 당 -> 통일 신라 (800년) - 신라 당은포 등주 당은포
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.82448232706733,37.19078334576662],[125.30836540287096,37.04497840000892],[124.39673093178486,37.621556387168155],[123.93542192231963,38.46089174996547],[123.11203534228937,39.643178598419325],[122.7269063666055,38.75277973432003],[122.11182768731854,38.443652656808574],[120.58293235187396,37.66175768405154],[121.93079098724647,37.78307380799341],[122.82045836264368,37.52210913456914],[124.09868212930918,36.93965693069244],[125.98497891387083,37.10741613805853],[126.80789857435771,37.18312406338511]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 800;

-- 통일 신라 -> 발해 (800년) - 동경 남경 금성
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[130.43816323475264,42.60060663961858],[129.1311210412678,41.655398435754414],[128.68079557964694,40.887432087688325],[128.30735495293698,40.23637697569086],[127.09916469005185,39.93375673235165],[126.90146082885246,39.31598712139509],[127.20900016849595,38.7441489261207],[127.82407884778296,38.434984601319904],[128.29637140509257,37.908089499473476],[128.8895191323384,37.25512794848796],[129.08844353671662,36.6016138744037],[129.19827901516072,35.8615971293733],[129.19874540722964,35.79295776329903]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 800;

-- 발해 -> 통일 신라 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.19874540722964,35.79295776329903],[129.19827901516072,35.8615971293733],[129.08844353671662,36.6016138744037],[128.8895191323384,37.25512794848796],[128.29637140509257,37.908089499473476],[127.82407884778296,38.434984601319904],[127.20900016849595,38.7441489261207],[126.90146082885246,39.31598712139509],[127.09916469005185,39.93375673235165],[128.30735495293698,40.23637697569086],[128.68079557964694,40.887432087688325],[129.1311210412678,41.655398435754414],[130.43816323475264,42.60060663961858]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 800;

-- 통일 신라 -> 발해 (900년)경서경 등주 당
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.40556794306795,43.944395219239006],[130.19638338786547,42.82656008511685],[128.09833112994184,41.98285414008279],[127.06587763256724,41.729166643849695],[124.55996333596852,41.25887466035369],[123.2858717860169,40.02506068973238],[122.67079310672993,38.939646399122175],[120.97932673869074,37.97606296486694],[119.81507066718325,36.94699475080521],[117.41889453920797,36.486079502365314],[113.09169086021689,35.80756686110163],[110.56443225078141,34.99116148165628],[108.06018334225584,34.23158769407176]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.trade_year = 800;

-- 당 -> 발해 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[108.06018334225584,34.23158769407176],[110.56443225078141,34.99116148165628],[113.09169086021689,35.80756686110163],[117.41889453920797,36.486079502365314],[119.81507066718325,36.94699475080521],[120.97932673869074,37.97606296486694],[122.67079310672993,38.939646399122175],[123.2858717860169,40.02506068973238],[124.55996333596852,41.25887466035369],[127.06587763256724,41.729166643849695],[128.09833112994184,41.98285414008279],[130.19638338786547,42.82656008511685],[129.40556794306795,43.944395219239006]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 800;

-- 발해 -> 일본 (800년) - 동경 마쓰바라
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[130.50858561793663,42.623547619724974],[130.37963669132526,40.42724465492898],[130.9292589284401,39.07599085877193],[131.85187694737058,37.90648170000432],[132.94237043906935,37.04483742243001],[135.10300221913744,36.29667504766729],[136.08602975121215,35.656499658332905]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 800;

-- 일본 -> 발해 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[136.08602975121215,35.656499658332905],[135.10300221913744,36.29667504766729],[132.94237043906935,37.04483742243001],[131.85187694737058,37.90648170000432],[130.9292589284401,39.07599085877193],[130.37963669132526,40.42724465492898],[130.50858561793663,42.623547619724974]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 800;

-- 발해 -> 거란(요나라 이전) (800년) - 상경 부여부 거란
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.3958494228918,43.972485069376006],[128.05677407846832,43.81870642384496],[126.36510753022668,43.70766027227544],[125.11246594377423,43.707677842847936],[123.94798188925836,43.69179226421722],[121.79497296818441,43.53269443833736],[118.47667371122361,43.19723225403337],[114.60709516991652,41.8319910630157],[107.7073697159905,41.76674066594712],[106.25861458883591,42.95424498367054]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.trade_year = 800;

-- 거란(요나라 이전) -> 발해 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[106.25861458883591,42.95424498367054],[107.7073697159905,41.76674066594712],[114.60709516991652,41.8319910630157],[118.47667371122361,43.19723225403337],[121.79497296818441,43.53269443833736],[123.94798188925836,43.69179226421722],[125.11246594377423,43.707677842847936],[126.36510753022668,43.70766027227544],[128.05677407846832,43.81870642384496],[129.3958494228918,43.972485069376006]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 800;

-- =========================================================================
-- 고려시대 무역 경로 (10세기~11세기)
-- =========================================================================

-- 고려 -> 송 (1020년) - 벽란도 명주
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.44070784985018,37.916970081239164],[126.11357741002547,37.02375394325351],[125.79925222636332,35.61842963492064],[125.55458929038089,34.19650307007881],[125.09292236678388,32.76705429811708],[121.35683181967211,29.76278568027309]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '송')
  AND t.trade_year = 1020;

-- 송 -> 고려 (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[121.35683181967211,29.76278568027309],[125.09292236678388,32.76705429811708],[125.55458929038089,34.19650307007881],[125.79925222636332,35.61842963492064],[126.11357741002547,37.02375394325351],[126.44070784985018,37.916970081239164]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '송')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.trade_year = 1020;

-- 고려 -> 거란(요나라 이전) (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[125.42473694315457,40.00815829230544],[118.28109555665378,44.41595010926699]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.trade_year = 1020;

-- 거란(요나라 이전) -> 고려 (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[118.03931077126454,44.21154951729324],[125.09503041762376,39.7721141332367]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.trade_year = 1020;

-- 여진 -> 고려 (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.07206564130297,44.30597207825321],[126.96194387790582,39.72142254655931]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '여진')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.trade_year = 1020;

-- 고려 -> 여진 (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.41243300202115,39.75522897158315],[128.32247111294487,44.29135076104278]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '여진')
  AND t.trade_year = 1020;

-- 일본 -> 고려 (1020년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[133.86503730589385,34.97295943930064],[128.8974589878964,35.868304055033434]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.trade_year = 1020;

-- 고려 -> 일본 (1020년) - 금주 다자이후 일본중앙
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.89494516630972,35.21607515520921],[128.83249915132828,33.77382939881083],[129.78864807536766,33.60927902173931],[130.31617851621692,33.55893693629397],[132.0468441261053,34.25121879913076],[133.81626914645395,33.850675875847415],[135.5966843843203,34.40546637919569]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 1020;

-- 아바스 왕조 -> 고려 (1024년) - 이슬람 해상실크로드
-- 바그다드 → 페르시아만 → 인도양 → 동남아시아 → 남중국해 → 고려 벽란도
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.89481420086483,35.217556304996926],[128.88382398334713,34.839684176409435],[124.89437502442438,31.248884711185006],[123.92723588286736,31.829457562666786],[122.96348829173911,28.572174379975678],[120.30385565245727,27.66127881132744],[120.14999260720955,24.903304180539365],[118.39155780437862,25.3012799579735],[124.54607961428695,25.658344950815344],[120.50233298574825,17.45181194709568],[114.25988943569831,22.732500278348837],[110.39440548969812,19.096824895689917],[106.04227935269147,20.379150785704944],[107.22922284460235,16.629089908367455],[111.0647088403015,14.81090672565733],[107.24011314414415,7.18089809711998],[116.11988218945422,5.433766160049518],[112.55905171372154,2.4965863281086382],[105.30550815204386,5.783670817119336],[100.38189070411714,13.31896605830456],[104.86589945133609,1.266714035343348],[99.89832113333863,3.6375929668027456],[98.97514286185239,6.919300433129789],[92.90523680829611,12.315280902370446],[80.82241503677754,10.524350828927377],[76.42632802970014,6.919425906502949],[75.98671932899238,11.042418815472383],[56.565940487864104,26.740076450335206],[54.016210023759186,25.83380497155732],[52.21381435085745,27.60024256031458],[48.566508989065206,29.606474142719115],[52.742791645788735,24.96037245902467],[56.78719169229993,26.031404003085534],[61.35912217966042,21.528672680135934],[56.91907430251226,14.55536945984613],[52.03941772465634,15.954529798639236],[50.80851336267466,13.190074288970905],[43.642891541138496,12.633191142394184],[39.33436067128949,21.327134558031258],[34.10640090451073,27.8723531812156],[44.305322760930274,11.343338858047128],[52.21827937366961,12.547227328617756],[57.84527074272866,8.964207665350841],[73.31358513074697,7.5292555526459255],[77.97343735824902,4.382444313703746],[83.33666350688343,4.7329204084745715],[92.7978621352529,12.296254074478115]]}'::jsonb,
    '#ef4444'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '아바스 왕조')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '고려')
  AND t.trade_year = 1024;

-- =========================================================================
-- 조선 전기 무역 경로 (15세기) - GeoJSON 기반
-- =========================================================================

-- 조선 -> 명 무역 경로 (한성 -> 베이징)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.8598675983635,37.573079320497946],[124.09098743124318,37.468516009798826],[121.4539587006524,38.162831433752636],[120.62986321729801,37.46217339652632],[118.8498688241492,36.53210862606866],[116.60839440314702,38.29463845181482],[116.01506293876406,39.9311823346929]]}'::jsonb,
    '#ef4444'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '명')
  AND t.trade_year = 1450;

-- 명 -> 조선 무역 경로 (베이징 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[116.04859948340456,39.920035279132954],[117.4769900458079,37.179770785104004],[119.78439018507486,36.793645709313274],[120.81722643788959,37.58134731692664],[121.9050007892583,38.00674366176544],[124.4769420407653,37.33910657219669],[126.98211933482654,37.54844868735224]]}'::jsonb,
    '#ef4444'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '명')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- 조선 -> 여진 무역 경로 (한성 -> 여진 지역)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.85971853091174,37.53780191247782],[127.04746383948357,39.04857818716179],[127.37709243080741,40.04817548387866],[128.84943347205393,40.93380409882548],[129.94816186190278,43.088503432127766],[130.60929184395317,46.896904943962376]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '여진')
  AND t.trade_year = 1450;

-- 여진 -> 조선 무역 경로 (여진 지역 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[130.21100151282056,46.898419006382674],[129.6835957667024,43.6844831084377],[128.8045861898388,41.38579852052644],[128.6720976878421,40.80776107985557],[127.88142121482083,40.22269410345668],[127.1013002153544,39.539822532819464],[126.67277013077545,38.77311978864634],[126.91980687749965,37.549900414566615]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '여진')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- 조선 -> 일본 무역 경로 (울산 염포)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.33684297891668,35.47061213036965],[131.7489806915298,35.39104026310551],[132.77082932463372,35.33728482497048]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 1450;

-- 일본 -> 조선 무역 경로 (염포)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[132.7704100943357,35.34669838932275],[131.74856146123176,35.59722130549544],[130.5728861521767,35.445211182971896],[129.18842669482962,35.47205741414557]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- 류큐 -> 조선 무역 경로 (류큐 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[127.88181880183059,26.554581430825266],[125.94879700292266,31.40138465007989],[125.06978742605907,35.07577920565404],[125.01906517779634,36.72687720702892],[126.80455338080051,37.5588296835065]]}'::jsonb,
    '#f59e0b'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '류큐')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- 시암 -> 조선 무역 경로 (시암 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[100.45881085967328,13.849713277436987],[101.99707761918455,9.20069751879985],[106.69977885540483,5.977670038010295],[113.77580594915679,13.508122992287811],[119.3135662833975,19.571079712465387],[122.47522278047653,22.720915928778787],[123.85966286403666,27.299012832579898],[124.55187462121664,33.607964305520326],[124.79374562087737,36.600293877774625],[126.82645526737447,37.59049228935405]]}'::jsonb,
    '#a855f7'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '시암')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- 자와 -> 조선 무역 경로 (자와 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[107.84267943402331,-7.077113078034796],[107.49107560327789,3.4496111773216005],[117.33598286415022,16.15328009168116],[124.71966330980446,28.170629571056452],[125.09098664383296,32.62591573838639],[124.80474782628215,36.497593481632634],[126.83731152358438,37.55447497205263]]}'::jsonb,
    '#ec4899'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '자와')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1450;

-- =========================================================================
-- 조선 후기 무역 경로 (17세기) - 연행사, 통신사 GeoJSON 기반
-- =========================================================================

-- 조선 -> 청 연행사 경로 (한성 -> 평양 -> 의주 -> 심양 -> 베이징)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.97185793406717,37.56659312059871],[126.31020774099962,38.05770339311346],[125.96409772010955,38.247767431117914],[125.71121617509014,38.793102673822375],[125.72769760465633,39.0153899577585],[125.66749010927886,39.45410367707593],[125.29940484896724,39.72502744789388],[125.00668268836161,39.7560031250224],[124.91878173067526,39.81826429751756],[124.7951710089288,39.8593890513787],[124.66881338225465,39.86044320840288],[124.53836494321405,40.19694116870546],[123.86277615495237,40.418143016497346],[123.10188348997983,40.41605192035799],[122.66245103035256,40.74402008018698],[122.62399436136477,41.138215405813334],[123.43176652370529,41.79679815153046],[121.93781769919583,42.10003389364086],[120.64127857332204,41.62548036745635],[119.62089459850961,41.14924656856151],[119.46706792255847,40.684340811836655],[118.63200882453809,40.38374783728612],[117.37833459964673,39.89803088323511],[116.3892339380886,39.90048917481727]]}'::jsonb,
    '#a855f7'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '청')
  AND t.trade_year = 1650;

-- 청 -> 조선 연행사 귀환 경로 (베이징 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[116.3892339380886,39.90048917481727],[117.37833459964673,39.89803088323511],[118.63200882453809,40.38374783728612],[119.46706792255847,40.684340811836655],[119.62089459850961,41.14924656856151],[120.64127857332204,41.62548036745635],[121.93781769919583,42.10003389364086],[123.43176652370529,41.79679815153046],[122.62399436136477,41.138215405813334],[122.66245103035256,40.74402008018698],[123.10188348997983,40.41605192035799],[123.86277615495237,40.418143016497346],[124.53836494321405,40.19694116870546],[124.66881338225465,39.86044320840288],[124.7951710089288,39.8593890513787],[124.91878173067526,39.81826429751756],[125.00668268836161,39.7560031250224],[125.29940484896724,39.72502744789388],[125.66749010927886,39.45410367707593],[125.72769760465633,39.0153899577585],[125.71121617509014,38.793102673822375],[125.96409772010955,38.247767431117914],[126.31020774099962,38.05770339311346],[126.97185793406717,37.56659312059871]]}'::jsonb,
    '#a855f7'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '청')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1650;

-- 조선 -> 일본 통신사 경로 (한성 -> 부산 -> 쓰시마 -> 시모노세키 -> 오사카 -> 교토 -> 나고야 -> 에도 -> 닛코)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[126.96767364317876,37.56550458003126],[127.03909317129894,37.43149283544542],[127.05969495825667,37.34966037822278],[127.23687032609323,37.25899503965123],[127.4828536107343,37.26798148919331],[128.07915574728392,37.27939516194081],[128.20001956410263,36.92452354737574],[128.4991209290452,36.7415742208517],[128.61291825643585,36.520918541155716],[128.50853586918328,36.2578089085175],[128.40301219201356,35.938976658267265],[128.1503686216769,35.635968761399354],[128.62283626924105,35.49297754728412],[129.08408897799453,35.17206212478994],[129.49048883285647,34.93598235474905],[129.45752597372413,34.663083522590334],[129.32842144212228,34.41194518027847],[129.33940906183307,34.27134033360567],[129.6938263141747,33.802987870132654],[130.50679296136258,33.76138942179657],[130.5150336761457,33.97120417278445],[130.7375329752893,34.02130081305285],[130.91868549594238,33.93791660015907],[130.98735811913485,34.02560066347358],[131.08487324406815,33.93108027803241],[131.14805205740524,33.806791600713744],[131.64101025410056,33.868641818072305],[131.9706388454244,33.97120417278445],[132.03656456368918,33.708855225405344],[132.23983552833886,33.7134246932114],[132.4815631619764,33.84127101335448],[132.48559020229422,34.0290150946133],[132.4457600808426,34.17229705726697],[132.5570097304144,34.06315184841666],[132.76438571487438,34.10523491320656],[132.96490735287298,34.081352497071535],[132.92919435984842,34.15297952517943],[133.11872644075757,34.117742060744135],[133.3219300814977,34.22227484515775],[133.305559082517,34.39154942922022],[133.48685480774512,34.47083830341028],[133.9014708372601,34.389282927787704],[134.06636811730934,34.6658445883539],[134.38763264740666,34.780473043911385],[134.58266289727328,34.565885605435504],[135.08259959411444,34.59302205327142],[135.28312365383644,34.766936607083764],[135.58803010081098,34.68341286500758],[135.69778004540748,34.90895837997035],[135.73898361932297,35.014751430661164],[135.96697672832195,34.94498836855063],[136.20870436195946,35.02824709256869],[136.28287079500734,35.29320855999032],[136.59862036553187,35.36578464925829],[136.85690417926347,35.18777649633007],[137.03284332562689,35.05348299637777],[137.38149553509612,34.83685095593686],[137.49134299442014,34.77596114503027],[137.75504586747923,34.71276866034245],[138.2025906905512,34.814053868661176],[138.34268284186385,34.94473821581002],[138.47041392100184,35.03811750950203],[138.6119617019245,35.20573205760859],[138.94997114509022,35.2286694963737],[139.23268924098699,35.34475300403371],[139.433213300709,35.461167087920856],[139.71186722319635,35.70997054876395],[139.81774221170232,35.86283837675694],[139.79027316242534,35.94737704591669],[139.845468609449,36.33823651310189],[139.8674438488706,36.545930132162866],[139.94980385382001,36.85862429474953],[140.20251910716829,37.117499575708045]]}'::jsonb,
    '#14b8a6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 1650;

-- 일본 -> 조선 통신사 귀환 경로 (에도 -> 한성)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[140.20251910716829,37.117499575708045],[139.94980385382001,36.85862429474953],[139.8674438488706,36.545930132162866],[139.845468609449,36.33823651310189],[139.79027316242534,35.94737704591669],[139.81774221170232,35.86283837675694],[139.71186722319635,35.70997054876395],[139.433213300709,35.461167087920856],[139.23268924098699,35.34475300403371],[138.94997114509022,35.2286694963737],[138.6119617019245,35.20573205760859],[138.47041392100184,35.03811750950203],[138.34268284186385,34.94473821581002],[138.2025906905512,34.814053868661176],[137.75504586747923,34.71276866034245],[137.49134299442014,34.77596114503027],[137.38149553509612,34.83685095593686],[137.03284332562689,35.05348299637777],[136.85690417926347,35.18777649633007],[136.59862036553187,35.36578464925829],[136.28287079500734,35.29320855999032],[136.20870436195946,35.02824709256869],[135.96697672832195,34.94498836855063],[135.73898361932297,35.014751430661164],[135.69778004540748,34.90895837997035],[135.58803010081098,34.68341286500758],[135.28312365383644,34.766936607083764],[135.08259959411444,34.59302205327142],[134.58266289727328,34.565885605435504],[134.38763264740666,34.780473043911385],[134.06636811730934,34.6658445883539],[133.9014708372601,34.389282927787704],[133.48685480774512,34.47083830341028],[133.305559082517,34.39154942922022],[133.3219300814977,34.22227484515775],[133.11872644075757,34.117742060744135],[132.92919435984842,34.15297952517943],[132.96490735287298,34.081352497071535],[132.76438571487438,34.10523491320656],[132.5570097304144,34.06315184841666],[132.4457600808426,34.17229705726697],[132.48559020229422,34.0290150946133],[132.4815631619764,33.84127101335448],[132.23983552833886,33.7134246932114],[132.03656456368918,33.708855225405344],[131.9706388454244,33.97120417278445],[131.64101025410056,33.868641818072305],[131.14805205740524,33.806791600713744],[131.08487324406815,33.93108027803241],[130.98735811913485,34.02560066347358],[130.91868549594238,33.93791660015907],[130.7375329752893,34.02130081305285],[130.5150336761457,33.97120417278445],[130.50679296136258,33.76138942179657],[129.6938263141747,33.802987870132654],[129.33940906183307,34.27134033360567],[129.32842144212228,34.41194518027847],[129.45752597372413,34.663083522590334],[129.49048883285647,34.93598235474905],[129.08408897799453,35.17206212478994],[128.62283626924105,35.49297754728412],[128.1503686216769,35.635968761399354],[128.40301219201356,35.938976658267265],[128.50853586918328,36.2578089085175],[128.61291825643585,36.520918541155716],[128.4991209290452,36.7415742208517],[128.20001956410263,36.92452354737574],[128.07915574728392,37.27939516194081],[127.4828536107343,37.26798148919331],[127.23687032609323,37.25899503965123],[127.05969495825667,37.34966037822278],[127.03909317129894,37.43149283544542],[126.96767364317876,37.56550458003126]]}'::jsonb,
    '#14b8a6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '조선')
  AND t.trade_year = 1650;
