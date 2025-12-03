-- 초기 데이터 추가 시 schema.sql에서 id 기본값 설정 필요

-- 국가 초기 데이터
INSERT INTO country (country_name, foundation_year, ended_year) VALUES
    -- 한국사 주요 국가 (780년 이전 건국)
    ('통일 신라', 668, 935),
    ('발해', 698, 926),

    -- 후삼국 및 고려
    ('후백제', 892, 936),
    ('후고구려(태봉)', 901, 918),
    ('고려', 918, 1392),

    -- 중국 왕조 및 기타 세력
    ('당', 618, 907),
    ('거란(요나라 이전)', 780, 916),
    ('요(거란)', 916, 1125),
    ('송', 960, 1279),
    ('서하', 1038, 1227),
    ('금', 1115, 1234),
    ('몽골 제국', 1206, 1271),
    ('원', 1271, 1368),
    ('명', 1368, 1392),

    -- 주변국 (프로젝트 기간 내 유효)
    ('일본', 780, 1392),

    ('여진', 1100, 1234),
    ('홍건적', 1350, 1370),
    ('왜구', 1350, 1392);

-- 전쟁 초기 데이터
-- 후삼국 통일 전쟁 (WAR_TK)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '후삼국 통일 전쟁',
    '왕건이 궁예를 몰아내고 고려를 건국한 뒤 후백제·신라와 대립과 통합을 거쳐 후삼국을 통일한 전쟁.',
    DATE '0918-06-15',
    DATE '0936-09-01',
    '고려 승리, 후삼국 통일',
    '고창 전투와 일리천 전투에서 승리하여 신라 항복과 후백제 멸망을 통해 민족 재통합을 완성함.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '후백제')
);

-- 여요전쟁 (거란 침입, WAR_KH)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여요전쟁(거란 침입)',
    '거란(요)이 송과의 관계 단절과 강동 6주 반환 등을 요구하며 고려를 세 차례 침략한 전쟁.',
    DATE '0993-10-01',
    DATE '1019-02-01',
    '고려 승리, 강동 6주 확보',
    '1차 침입 때 서희의 외교 담판으로 강동 6주를 확보하고, 3차 침입 때 강감찬이 귀주에서 거란군을 대파하여 평화를 이룸.',
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 여진 정벌 (WAR_JR)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여진 정벌',
    '여진이 국경을 침범하며 세력을 키우자 윤관이 별무반을 이끌고 여진을 토벌하고 동북 9성을 쌓은 전쟁.',
    DATE '1104-02-01',
    DATE '1109-06-01',
    '부분적 승리 후 9성 반환',
    '기병 중심 별무반으로 여진을 압박해 동북 9성을 축조했으나 방어의 어려움으로 결국 여진에게 돌려줌.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '여진')
);

-- 여몽전쟁(대몽항쟁, WAR_MG)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여몽전쟁(대몽항쟁)',
    '몽골 사신 피살 사건을 계기로 시작된 몽골의 침략에 맞서 고려가 강화도 천도, 처인성·충주성 항전과 삼별초의 항쟁 등으로 40여 년간 저항한 전쟁.',
    DATE '1231-08-01',
    DATE '1270-05-01',
    '강화 체결, 원 간섭기 시작',
    '귀주성·처인성·충주성 등에서 항전했으나 국토가 황폐화되고 결국 몽골과 강화하여 개경으로 환도, 이후 원 간섭기가 전개됨.',
    (SELECT country_id FROM country WHERE country_name = '몽골 제국'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 홍건적의 난 (WAR_RB)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '홍건적의 난',
    '원 말기 혼란 속에 등장한 한족 반란군 홍건적이 고려 영토를 침범하고 개경까지 점령한 사건.',
    DATE '1359-12-01',
    DATE '1362-01-31',
    '고려 승리, 개경 탈환',
    '홍건적이 개경을 함락했으나 이성계·정세운·최영 등의 활약으로 수도를 탈환하고 홍건적을 격퇴함.',
    (SELECT country_id FROM country WHERE country_name = '홍건적'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 여일전쟁(왜구 토벌, WAR_JP)
INSERT INTO war (
    name, details, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여일전쟁(왜구 토벌)',
    '고려 말 해안가를 약탈하던 왜구를 토벌하기 위해 최영·이성계·최무선 등이 활약한 일련의 전쟁.',
    DATE '1350-01-01',
    DATE '1389-02-28',
    '고려 승리, 왜구 세력 약화',
    '진포 대첩에서 화포를 사용해 왜선을 격침하고, 황산 대첩 등에서 왜구 주력을 크게 격파하여 해상 방어력을 강화함.',
    (SELECT country_id FROM country WHERE country_name = '왜구'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);
