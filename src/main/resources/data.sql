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

    -- 주변국
    ('일본', 780, 1392),

    ('여진', 1100, 1234),
    ('홍건적', 1350, 1370),
    ('왜구', 1350, 1392);

-- 주요사건 데이터
INSERT INTO main_event (event_id, country_id, event_name, year, era, description) VALUES
    -- 통일 신라 말
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '통일 신라'), 
      '혜공왕 피살 및 왕위 다툼 심화', 780, '신라 말', 
      '{"summary": "진골 귀족들의 반란으로 혜공왕이 살해당하고 무열왕계 왕위 세습이 단절됨.", "significance": "이후 150여 년 동안 20명의 왕이 교체되며 중앙 정치가 극도로 불안정해짐."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '통일 신라'), 
      '장보고, 청해진 설치', 828, '신라 말', 
      '{"summary": "장보고가 완도에 청해진을 설치하고 해적들을 소탕함.", "significance": "당, 신라, 일본을 잇는 중계 무역을 통해 동아시아의 해상왕으로 성장함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '통일 신라'), 
      '김헌창의 난', 822, '신라 말', 
      '{"summary": "웅주 도독 김헌창이 아버지가 왕이 되지 못한 것에 불만을 품고 반란을 일으켜 국호를 장안이라 칭함.", "significance": "지방 세력이 중앙 정부에 반기를 든 사건으로 신라의 지방 통제력 약화를 보여줌."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '통일 신라'), 
      '원종·애노의 난', 889, '신라 말', 
      '{"summary": "진성 여왕 때 중앙 정부의 세금 독촉에 반발하여 사벌주(상주)에서 일어난 농민 봉기.", "significance": "농민 봉기가 전국으로 확대되는 시발점이 되었으며, 중앙 정부가 이를 진압하지 못하고 지방 통제력을 상실하는 계기가 됨."}'
    ),

    -- 후삼국 시대 성립
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '후백제'), 
      '견훤, 후백제 건국', 900, '후삼국 시대', 
      '{"summary": "서남 해안 군인 출신 견훤이 완산주(전주)를 도읍으로 후백제를 건국함.", "significance": "후삼국 시대를 본격적으로 열었으며, 일부 6두품 세력을 등용하여 통치 체제를 정비함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)'), 
      '궁예, 후고구려 건국', 901, '후삼국 시대', 
      '{"summary": "궁예가 송악을 근거지로 후고구려를 세웠으며, 이후 국호를 마진, 태봉으로 바꾸고 철원으로 천도함.", "significance": "호족의 도움을 받아 성립하였으며, 이후 최고 관청으로 광평성을 설치하는 등 통치 제도를 정비함."}'
    ),
    
    -- 고려 초기
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '왕건, 고려 건국 및 송악 천도', 918, '후삼국 시대', 
      '{"summary": "궁예를 몰아내고 왕건이 즉위하여 국호를 고려라 정하고, 이듬해(919년) 철원에서 송악(개성)으로 천도함.", "significance": "고구려 계승 의식을 드러냈으며, 송악은 방어와 교역(벽란도)에 유리한 곳이었음."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '신라 경순왕, 고려에 항복', 935, '후삼국 통일', 
      '{"summary": "신라의 마지막 왕인 경순왕이 나라를 유지하기 어렵다고 여겨 고려에 스스로 나라를 넘겨주었음.", "significance": "고려가 평화적인 방법으로 신라 유민을 포용하여 민족 재통합의 기반을 마련함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '고려, 후삼국 통일 완성', 936, '후삼국 통일', 
      '{"summary": "견훤의 귀순과 후백제 격파를 통해 고려가 후삼국을 통일함.", "significance": "신라와 후백제 유민뿐 아니라 발해 유민까지 포용하여 민족의 재통합을 이루었음."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '광종, 노비안검법 실시', 956, '고려 초기', 
      '{"summary": "광종이 권세가에게 불법적으로 노비가 된 사람들을 조사하여 양인 신분으로 되돌려준 법.", "significance": "호족과 공신의 경제적·군사적 기반을 약화시키고 국가 재정을 확충함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '광종, 과거제 실시', 958, '고려 초기', 
      '{"summary": "광종이 쌍기의 건의로 유교적 소양을 갖춘 인재를 등용하기 위해 시행한 제도.", "significance": "국왕 중심의 관료제 통치 질서를 확립하는 데 기여함."}'
    ),
    
    -- 고려 전기
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '서희, 외교 담판 및 강동 6주 확보', 993, '고려 전기', 
      '{"summary": "거란의 1차 침입 시 서희가 소손녕과 담판을 벌여 송과의 외교 단절을 약속하고 거란을 물러나게 함.", "significance": "고려가 고구려 계승국임을 인정받고 압록강 하류 지역의 강동 6주를 확보함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '강감찬, 귀주대첩 승리', 1019, '고려 전기', 
      '{"summary": "거란의 3차 침입 시 강감찬이 지휘한 고려군이 귀주에서 거란군을 크게 물리침.", "significance": "세 차례 거란의 침입을 막아내고 송-요-고려의 다원적 국제 질서를 유지하는 데 기여함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '윤관, 동북 9성 축조', 1108, '고려 전기', 
      '{"summary": "윤관이 별무반을 이끌고 여진을 정벌한 후 동북 지역에 9성을 쌓았으나 여진의 요구로 1년여 만에 반환됨.", "significance": "여진에 대한 군사적 우위를 확보하려 했던 시도였으나 한계를 보임."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '이자겸의 난', 1126, '고려 전기', 
      '{"summary": "경원 이씨 이자겸이 척준경과 함께 난을 일으켜 왕권을 위협함.", "significance": "문벌 귀족의 모순과 외척 세력의 권력 독점을 보여주었으며, 문벌 사회의 동요를 가속화함."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '묘청의 서경 천도 운동', 1135, '고려 전기', 
      '{"summary": "묘청 등이 풍수지리설을 내세워 서경 천도와 금 정벌을 주장했으나 김부식의 관군에 의해 진압됨.", "significance": "자주적/개혁적 서경파가 보수적 개경파에게 패배하여 북진 정책이 사실상 종결됨."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '무신정변 발생', 1170, '무신 정권', 
      '{"summary": "문신 중심 사회의 무신 차별에 불만을 품은 정중부, 이의방 등의 무신들이 정변을 일으켜 권력을 장악함.", "significance": "100년간 무신이 정치를 주도하는 무신 정권 시대를 열었으며, 최고 회의 기구로 중방을 중심으로 국정을 처리함."}'
    ),

    -- 무신 정권기 하층민 봉기
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '망이·망소이의 난', 1176, '무신 정권', 
      '{"summary": "공주 명학소 주민들이 무신 정권의 수탈에 반발하여 일으킨 봉기.", "significance": "지방 차별과 지배층의 수탈에 대한 하층민의 저항 의식을 보여줌."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '만적의 봉기 계획', 1198, '무신 정권', 
      '{"summary": "최충헌의 사노비 만적이 ''장군·재상에 씨가 따로 있겠느냐''며 노비 해방 및 정권 탈취를 계획함.", "significance": "신분적 차별을 극복하려는 천민 의식 성장을 보여주었으나 사전에 발각되어 실패함."}'
    ),

    -- 대몽 항쟁 및 원 간섭기
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '고려, 강화도 천도', 1232, '대몽 항쟁', 
      '{"summary": "몽골의 재침입에 대비하여 당시 권력자 최우가 방어에 유리한 강화도로 수도를 옮김.", "significance": "장기적인 대몽 항전을 위한 발판을 마련하였으며, 강화도는 바다가 있어 방어에 유리하였음."}'
    ),
    (gen_random_uuid(), (SELECT country_id FROM country WHERE country_name = '고려'), 
      '몽골과 강화 체결 및 개경 환도', 1270, '원 간섭기', 
      '{"summary": "최씨 무신 정권 붕괴 후 고려 정부가 몽골과 강화를 맺고 개경으로 돌아옴.", "significance": "수십 년간의 대몽 항쟁이 끝나고 원의 간섭을 받는 원 간섭기가 시작됨. 삼별초는 이에 반발하여 항쟁을 시작함."}'
    );
    

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
    winner_general, loser_general, battle_date, war_id, marker_route
) VALUES
-- 1 공산 전투
('공산 전투',
 '후백제 견훤이 신라를 공격하자 왕건이 구원하러 갔으나 대구 팔공산에서 포위되어 대패함.',
 35.98, 128.69,
 '견훤', '왕건',
 DATE '0927-11-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL
),

-- 2 고창 전투
('고창 전투',
 '왕건이 안동(고창)에서 후백제군을 대파하여 후삼국 통일의 주도권을 잡은 결정적 전투.',
 36.5683, 128.7297,
 '왕건', '견훤',
 DATE '0930-01-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL
),

-- 3 일리천 전투
('일리천 전투',
 '고려가 구미 선산에서 후백제 신검의 군대를 격파하고 후삼국을 통일한 마지막 전투.',
 36.22, 128.36,
 '왕건', '신검',
 DATE '0936-09-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL
),

-- 4 안융진 전투 (서희 담판)
('안융진 전투 (서희 담판)',
 '거란 소손녕의 침입을 막고 서희가 외교 담판을 벌여 강동 6주를 확보함.',
 39.61, 125.66,
 '서희', '소손녕',
 DATE '0993-10-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 NULL
),

-- 5 흥화진 전투
('흥화진 전투',
 '양규가 거란 성종의 40만 대군을 7일간 막아내며 거란군의 남하를 지연시킴.',
 40.19, 124.53,
 '양규', '야율융서',
 DATE '1010-11-16',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 NULL
),

-- 6 귀주 대첩
('귀주 대첩',
 '강감찬이 퇴각하는 소배압의 10만 거란군을 귀주에서 맞이하여 크게 물리침.',
 39.97, 125.24,
 '강감찬', '소배압',
 DATE '1019-02-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 NULL
),

-- 7 여진 정벌 (석성)
('여진 정벌 (석성)',
 '윤관이 별무반을 이끌고 여진을 정벌하여 동북 9성을 쌓음.',
 40.25, 127.5,
 '윤관', '여진족',
 DATE '1107-12-01',
 (SELECT war_id FROM war WHERE name = '여진 정벌'),
 NULL
),

-- 8 귀주성 전투
('귀주성 전투',
 '몽골 1차 침입 당시 박서가 몽골군의 온갖 공격을 막아내고 성을 끝까지 사수함.',
 39.97, 125.24,
 '박서', '살리타',
 DATE '1231-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL
),

-- 9 처인성 전투
('처인성 전투',
 '승려 김윤후가 처인 부곡민과 함께 몽골군 사령관 살리타를 사살하여 물리침.',
 37.15, 127.2,
 '김윤후', '살리타',
 DATE '1232-12-16',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL
),

-- 10 죽주성 전투
('죽주성 전투',
 '방호별감 송문주가 몽골군의 포 공격과 화공을 막아내고 반격하여 승리함.',
 37.08, 127.42,
 '송문주', '몽골 장수',
 DATE '1236-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL
),

-- 11 충주성 전투
('충주성 전투',
 '김윤후가 노비 문서를 불태우며 관노비들을 격려하여 몽골군을 격퇴함.',
 36.97, 127.93,
 '김윤후', '몽골 장수',
 DATE '1253-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL
),

-- 12 삼별초의 항쟁
('삼별초의 항쟁',
 '개경 환도에 반대하여 진도와 제주도로 이동하며 벌인 최후의 항전.',
 34.48, 126.26,
 '여몽연합군', '배중손',
 DATE '1270-06-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL
),

-- 13 개경 탈환전
('개경 탈환전',
 '홍건적에게 점령당한 수도 개경을 이성계, 정세운, 최영 등이 탈환함.',
 37.96, 126.55,
 '이성계', '사유',
 DATE '1362-01-17',
 (SELECT war_id FROM war WHERE name = '홍건적의 난'),
 NULL
),

-- 14 황산 대첩
('황산 대첩',
 '이성계가 남원 운봉에서 아지발도가 이끄는 왜구 대군을 섬멸함.',
 35.45, 127.5,
 '이성계', '아지발도',
 DATE '1380-09-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)'),
 NULL
),

-- 15 진포 대첩
('진포 대첩',
 '최무선이 화포를 사용하여 왜선 500척을 소각시킴.',
 36, 126.7,
 '최무선', '왜구 장수',
 DATE '1380-08-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)'),
 NULL
);

-- ##################################################
-- 왕 초기 데이터
-- 견훤 (후백제)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('견훤', '견훤왕', '0900-01-01', '0935-03-01',
        (SELECT country_id FROM country WHERE country_name = '후백제'));
-- 신검 (후백제)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('신검', '신검왕', '0935-03-01', '0936-09-01',
        (SELECT country_id FROM country WHERE country_name = '후백제'));
-- 궁예 (후고구려(태봉))
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('궁예', '궁예왕', '0901-01-01', '0918-06-15',
        (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)'));
-- 왕건 (고려 태조)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕건', '태조', '0918-06-15', '0943-07-04',
        (SELECT country_id FROM country WHERE country_name = '고려'));
-- 김만 (신라 진성여왕 → 통일 신라)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김만', '진성여왕', '0887-07-05', '0897-07-06',
        (SELECT country_id FROM country WHERE country_name = '통일 신라'));
-- 김부 (신라 경순왕 → 통일 신라)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김부', '경순왕', '0927-11-01', '0935-11-01',
        (SELECT country_id FROM country WHERE country_name = '통일 신라'));
-- 대인수 (발해 선왕)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대인수', '선왕', '0818-01-01', '0830-12-31',
        (SELECT country_id FROM country WHERE country_name = '발해'));
-- 왕소 (고려 광종)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕소', '광종', '0949-04-13', '0975-07-04',
        (SELECT country_id FROM country WHERE country_name = '고려'));
-- 왕치 (고려 성종)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕치', '성종', '0981-07-01', '0997-11-29',
        (SELECT country_id FROM country WHERE country_name = '고려'));

-- 왕순 (고려 현종)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕순', '현종', '1009-03-02', '1031-06-17',
        (SELECT country_id FROM country WHERE country_name = '고려'));
-- 왕해 (고려 인종)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕해', '인종', '1122-05-15', '1146-04-10',
        (SELECT country_id FROM country WHERE country_name = '고려'));
-- 왕철 (고려 고종)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕철', '고종', '1213-09-01', '1259-07-20',
        (SELECT country_id FROM country WHERE country_name = '고려'));
-- 왕전 (고려 공민왕)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕전', '공민왕', '1351-12-01', '1374-10-22',
        (SELECT country_id FROM country WHERE country_name = '고려'));

-- ##################################################
-- 수도 초기 데이터
-- 금성(경주) - 통일 신라
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '금성(경주)',
    '0676-01-01', -- 삼국통일 시점
    '0935-11-01', -- 신라 멸망 시점
    129.224,
    35.856,
    '신라의 천년 고도. 혜공왕 피살 이후 왕위 다툼이 치열했던 곳.',
    (SELECT country_id FROM country WHERE country_name = '통일 신라')
);

-- 상경 용천부 - 발해
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '상경 용천부',
    '0785-01-01', -- 문왕 천도 시점(대략)
    '0926-01-14', -- 발해 멸망 시점
    129.150,
    44.120,
    '발해 문왕 때 천도한 수도. 당의 장안성을 본떠 건설됨.',
    (SELECT country_id FROM country WHERE country_name = '발해')
);

-- 완산주(전주) - 후백제
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '완산주(전주)',
    '0900-01-01', -- 후백제 건국 시점
    '0936-09-01', -- 후백제 멸망 시점
    127.148,
    35.824,
    '견훤이 900년에 건국하여 도읍으로 삼은 곳.',
    (SELECT country_id FROM country WHERE country_name = '후백제')
);

-- 송악(개성) - 고려
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '송악(개성)',
    '0919-01-01', -- 왕건이 철원에서 송악으로 천도한 시점
    '1392-07-28', -- 고려 멸망 시점
    126.560,
    37.970,
    '고려의 수도. 왕건이 철원에서 이곳으로 천도함.',
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 철원 - 후고구려(태봉)
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '철원',
    '0905-01-01', -- 궁예의 철원 천도 시점(대략)
    '0918-06-15', -- 궁예 축출 및 고려 건국 시점
    127.200,
    38.270,
    '궁예가 송악에서 천도하여 태봉이라는 국호를 사용했던 도읍.',
    (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)')
);

-- 강화도 - 고려 임시 수도
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '강화도',
    '1232-07-01', -- 최우가 몽골 침입에 대비해 천도한 시점
    '1270-05-01', -- 개경 환도 시점
    126.485,
    37.746,
    '몽골 침입 시기 최우가 천도한 임시 수도(1232~1270).',
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- ##################################################
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
    900,
    '담비·호랑이 가죽, 인삼, 약재 수출'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '당'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    900,
    '각종 비단, 금은그릇 수입'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    900,
    '담비 가죽, 인삼 수출'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    900,
    '각종 비단'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    910,
    '사신 및 문물 교류 (신라도)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    910,
    '사신 및 문물 교류 (신라도)'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'), /* 거란/유목 민족 */
    900,
    '모피 교역 (담비 가죽 등)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    900,
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
    1000,
    '고려청자, 서적, 약재 등 수출'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '송'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1000,
    '비단, 서적, 차 등 수입'
),

-- 고려 <-> 거란(요나라이전) (강동 6주 확보 후 교류 시작)
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    1020,
    '사신 왕래 및 물품 교역 (귀주대첩 이후)'
);