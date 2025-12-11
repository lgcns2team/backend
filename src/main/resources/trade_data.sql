
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
