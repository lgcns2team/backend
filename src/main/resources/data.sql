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

-- ##################################################
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

-- ##################################################
-- 전투 초기 데이터
INSERT INTO battle (
    battle_name, details, latitude, longitude,
    winner_general, loser_general, battle_date, war_id
) VALUES
-- 1 공산 전투
('공산 전투',
 '후백제 견훤이 신라를 공격하자 왕건이 구원하러 갔으나 대구 팔공산에서 포위되어 대패함.',
 35.98, 128.69,
 '견훤', '왕건',
 DATE '0927-11-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁')
),

-- 2 고창 전투
('고창 전투',
 '왕건이 안동(고창)에서 후백제군을 대파하여 후삼국 통일의 주도권을 잡은 결정적 전투.',
 36.5683, 128.7297,
 '왕건', '견훤',
 DATE '0930-01-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁')
),

-- 3 일리천 전투
('일리천 전투',
 '고려가 구미 선산에서 후백제 신검의 군대를 격파하고 후삼국을 통일한 마지막 전투.',
 36.22, 128.36,
 '왕건', '신검',
 DATE '0936-09-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁')
),

-- 4 안융진 전투 (서희 담판)
('안융진 전투 (서희 담판)',
 '거란 소손녕의 침입을 막고 서희가 외교 담판을 벌여 강동 6주를 확보함.',
 39.61, 125.66,
 '서희', '소손녕',
 DATE '0993-10-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)')
),

-- 5 흥화진 전투
('흥화진 전투',
 '양규가 거란 성종의 40만 대군을 7일간 막아내며 거란군의 남하를 지연시킴.',
 40.19, 124.53,
 '양규', '야율융서',
 DATE '1010-11-16',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)')
),

-- 6 귀주 대첩
('귀주 대첩',
 '강감찬이 퇴각하는 소배압의 10만 거란군을 귀주에서 맞이하여 크게 물리침.',
 39.97, 125.24,
 '강감찬', '소배압',
 DATE '1019-02-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)')
),

-- 7 여진 정벌 (석성)
('여진 정벌 (석성)',
 '윤관이 별무반을 이끌고 여진을 정벌하여 동북 9성을 쌓음.',
 40.25, 127.5,
 '윤관', '여진족',
 DATE '1107-12-01',
 (SELECT war_id FROM war WHERE name = '여진 정벌')
),

-- 8 귀주성 전투
('귀주성 전투',
 '몽골 1차 침입 당시 박서가 몽골군의 온갖 공격을 막아내고 성을 끝까지 사수함.',
 39.97, 125.24,
 '박서', '살리타',
 DATE '1231-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)')
),

-- 9 처인성 전투
('처인성 전투',
 '승려 김윤후가 처인 부곡민과 함께 몽골군 사령관 살리타를 사살하여 물리침.',
 37.15, 127.2,
 '김윤후', '살리타',
 DATE '1232-12-16',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)')
),

-- 10 죽주성 전투
('죽주성 전투',
 '방호별감 송문주가 몽골군의 포 공격과 화공을 막아내고 반격하여 승리함.',
 37.08, 127.42,
 '송문주', '몽골 장수',
 DATE '1236-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)')
),

-- 11 충주성 전투
('충주성 전투',
 '김윤후가 노비 문서를 불태우며 관노비들을 격려하여 몽골군을 격퇴함.',
 36.97, 127.93,
 '김윤후', '몽골 장수',
 DATE '1253-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)')
),

-- 12 삼별초의 항쟁
('삼별초의 항쟁',
 '개경 환도에 반대하여 진도와 제주도로 이동하며 벌인 최후의 항전.',
 34.48, 126.26,
 '여몽연합군', '배중손',
 DATE '1270-06-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)')
),

-- 13 개경 탈환전
('개경 탈환전',
 '홍건적에게 점령당한 수도 개경을 이성계, 정세운, 최영 등이 탈환함.',
 37.96, 126.55,
 '이성계', '사유',
 DATE '1362-01-17',
 (SELECT war_id FROM war WHERE name = '홍건적의 난')
),

-- 14 황산 대첩
('황산 대첩',
 '이성계가 남원 운봉에서 아지발도가 이끄는 왜구 대군을 섬멸함.',
 35.45, 127.5,
 '이성계', '아지발도',
 DATE '1380-09-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)')
),

-- 15 진포 대첩
('진포 대첩',
 '최무선이 화포를 사용하여 왜선 500척을 소각시킴.',
 36, 126.7,
 '최무선', '왜구 장수',
 DATE '1380-08-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)')
);
