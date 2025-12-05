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
    winner_general, loser_general, battle_date, war_id, marker_route, route_color
) VALUES
-- 1 공산 전투
('공산 전투',
 '후백제 견훤이 신라를 공격하자 왕건이 구원하러 갔으나 대구 팔공산에서 포위되어 대패함.',
 35.98, 128.69,
 '견훤', '왕건',
 DATE '0927-11-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL,
 NULL
),

-- 2 고창 전투
('고창 전투',
 '왕건이 안동(고창)에서 후백제군을 대파하여 후삼국 통일의 주도권을 잡은 결정적 전투.',
 36.5683, 128.7297,
 '왕건', '견훤',
 DATE '0930-01-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL,
 NULL
),

-- 3 일리천 전투
('일리천 전투',
 '고려가 구미 선산에서 후백제 신검의 군대를 격파하고 후삼국을 통일한 마지막 전투.',
 36.22, 128.36,
 '왕건', '신검',
 DATE '0936-09-01',
 (SELECT war_id FROM war WHERE name = '후삼국 통일 전쟁'),
 NULL,
 NULL
),

-- 4 안융진 전투 (서희 담판) - 거란 1차 침입
('안융진 전투 (서희 담판)',
 '거란 소손녕의 침입을 막고 서희가 외교 담판을 벌여 강동 6주를 확보함.',
 39.61, 125.66,
 '서희', '소손녕',
 DATE '0993-10-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[121.37481611235964,42.37239001865886],[123.00173202107518,41.56490648168317],[124.04524728067838,40.82081878730365],[123.30451260837796,40.131998120610305],[124.14130452355224,40.139874368039365],[124.54086102426874,40.19130103047869],[124.84979646296702,40.1892027457104],[124.99147905102323,40.09907593553345],[125.15850440375374,39.86934587072625],[125.65017194191675,39.61167931564372],[121.37481611235964,42.37239001865886]]}',
 '#22c55e'
),

-- 5 흥화진 전투 - 거란 2차 침입
('흥화진 전투',
 '양규가 거란 성종의 40만 대군을 7일간 막아내며 거란군의 남하를 지연시킴.',
 40.19, 124.53,
 '양규', '야율융서',
 DATE '1010-11-16',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[123.34053716110319,40.30018131918214],[123.81286512071308,40.260366875541834],[124.12866579138245,40.21633416242909],[124.38679851349482,40.01257351417898],[124.72456792647166,39.86936716903908],[125.24414258197129,39.76421948702072],[125.63913571102401,39.763869617141985],[125.97971971078415,39.700512294091375],[126.01267282424531,39.497331729669924],[125.87489166231657,39.25280905793491],[125.7737637301376,39.016680997075106],[125.9353595203723,38.7105316987703],[126.17152350017722,38.43995878922502],[126.25992049149654,38.222722826097794],[126.4823540073593,38.20545753178675],[126.55649851264693,37.97197542164486],[123.34053716110319,40.30018131918214]]}',
 '#3b82f6'
),

-- 6 귀주 대첩 - 거란 3차 침입
('귀주 대첩',
 '강감찬이 퇴각하는 소배압의 10만 거란군을 귀주에서 맞이하여 크게 물리침.',
 39.97, 125.24,
 '강감찬', '소배압',
 DATE '1019-02-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[123.42852465618168,40.365064066214195],[123.73883314127423,40.358785173416706],[124.0079502345403,40.33156988042983],[124.21390719367251,40.27501072924152],[124.51323130761133,40.03988961639689],[124.90317648356829,39.93887430873096],[125.25742245327567,39.97045763878426],[125.56498484557977,39.89674051682011],[126.0813593909535,39.846150729675486],[126.1912031024907,39.65397341426662],[126.23514058710555,39.34452593029174],[126.32593924426759,39.046578729379625],[126.34517070015735,38.796553568627566],[126.52915891698213,38.50266411836324],[123.42852465618168,40.365064066214195]]}',
 '#a855f7'
),

-- 7 여진 정벌 (석성)
('여진 정벌 (석성)',
 '윤관이 별무반을 이끌고 여진을 정벌하여 동북 9성을 쌓음.',
 40.25, 127.5,
 '윤관', '여진족',
 DATE '1107-12-01',
 (SELECT war_id FROM war WHERE name = '여진 정벌'),
 NULL,
 NULL
),

-- 8 귀주성 전투
('귀주성 전투',
 '몽골 1차 침입 당시 박서가 몽골군의 온갖 공격을 막아내고 성을 끝까지 사수함.',
 39.97, 125.24,
 '박서', '살리타',
 DATE '1231-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 NULL,
 NULL
),

-- 9 처인성 전투
('처인성 전투',
 '승려 김윤후가 처인 부곡민과 함께 몽골군 사령관 살리타를 사살하여 물리침.',
 37.15, 127.2,
 '김윤후', '살리타',
 DATE '1232-12-16',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[126.972839,37.556397],[127.192503,37.151373]]}'::jsonb,
 NULL
),

-- 10 죽주성 전투
('죽주성 전투',
 '방호별감 송문주가 몽골군의 포 공격과 화공을 막아내고 반격하여 승리함.',
 37.08, 127.42,
 '송문주', '몽골 장수',
 DATE '1236-09-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.18158,37.151381],[127.425956,37.079099]]}'::jsonb,
 NULL
),

-- 11 충주성 전투
('충주성 전투',
 '김윤후가 노비 문서를 불태우며 관노비들을 격려하여 몽골군을 격퇴함.',
 36.97, 127.93,
 '김윤후', '몽골 장수',
 DATE '1253-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[116.4434081890688,39.94218722163645],[116.98158531384907,40.17764571648192],[117.5856616783983,40.40392386108535],[118.34350293574191,40.70444861769766],[119.41985718530238,41.01191454804087],[120.16671523601778,41.25190306998128],[121.18815345243742,41.40866072110334],[121.88009547001201,41.301446232520604],[122.55007107433025,41.06992318180993],[123.34086195155832,40.687788193445755],[123.8460894564541,40.42065505924966],[124.3513169613498,40.194433037029],[124.86752767287369,39.97587395685135],[125.24649662974015,39.970656108973344],[125.40809196235618,39.79555694217953],[125.58931487172097,39.60535467072512],[125.65798722624427,39.33608321069638],[125.73212387098441,39.0166860331456],[125.96753394397979,38.65906373277221],[126.14875685334454,38.418432229207674],[126.31717081561534,38.1860100747619],[126.56703876640614,37.96979090534073],[126.77491685487175,37.75425931961121],[126.90808823523828,37.630367254274155],[126.96995812536858,37.55530745539255],[127.3750863885329,37.47235501756306],[127.58102151281106,37.42656147724717],[127.91077874682867,37.33723935461309],[127.91764325097128,37.18311583317315],[127.9258806559424,37.07032993343902],[127.92999935842796,36.969447095990915]]}'::jsonb,
 NULL
),

-- 12 삼별초의 항쟁
('삼별초의 항쟁',
 '개경 환도에 반대하여 진도와 제주도로 이동하며 벌인 최후의 항전.',
 34.48, 126.26,
 '여몽연합군', '배중손',
 DATE '1270-06-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[126.49043803509805,37.75301985688926],[126.3229558396316,37.422181191537085],[126.1829199551225,37.203719676396275],[126.08956269878304,37.043842242882484],[125.97698483084432,36.89680844603381],[125.957764219245,36.77589692331659],[126.00718864907178,36.64818330043741],[126.06160134084848,36.19468167138441],[126.10600161151172,35.676998294908444],[126.12796802476807,35.446847706786436],[126.16091764465256,35.26090623896035],[126.21525385975687,34.93016418990741],[126.22301150218051,34.732399425914565],[126.25733402289356,34.48371632695861],[126.31411520539773,34.042692105404804],[126.46248370053135,33.46734790403028]]}'::jsonb,
 '#3b82f6'
),

-- 추가 여몽전쟁 전투들
('서경 전투',
 '몽골군의 서경 침공과 수안 지역 공략.',
 39.03, 125.73,
 '몽골 장수', '고려 수비군',
 DATE '1235-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[125.73210826350027,39.027027092844044],[126.22446556192669,38.9047656135917],[126.55533466160024,38.82135329131317],[126.74581631818396,38.73445411156535],[126.72934150824172,38.45536806318615],[126.72384990492763,38.25289208075275],[126.85839418612265,38.110389993841416],[127.14395755845503,38.16008145063781],[127.17141557502549,38.36712369324218],[127.14121175679799,38.582164659695714]]}'::jsonb,
 NULL
),
('처인 남하 전투',
 '몽골군이 처인성 이후 직산, 공주, 전주, 나주로 남하한 공세.',
 36.84, 127.13,
 '몽골 장수', '고려 수비군',
 DATE '1233-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.18561397839679,37.14920858653248],[127.16227466431192,37.005669117947626],[127.13309062758388,36.83969776065662],[127.1221074209557,36.654818107394],[127.11834495929607,36.53041468449043],[127.12109544319839,36.4652895174036],[127.12487663383898,36.27047393962188],[127.14958884875236,36.117520623134105],[127.14694995836182,35.9820471522741],[127.15273420200388,35.825417217323974],[127.05641029810654,35.54754697754938],[126.97403624839528,35.301334191303546],[126.72965990091856,35.034130604052784]]}'::jsonb,
 NULL
),
('죽주 남하 전투',
 '몽골군이 죽주에서 청주, 대구, 경주로 남하한 침공.',
 36.64, 127.48,
 '몽골 장수', '고려 수비군',
 DATE '1237-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.41370943892196,37.08131615019693],[127.48372738117655,36.63737682128203],[127.69908318032178,36.423116493792314],[127.95718853608373,36.21064645901592],[128.36647452044406,35.95539023429556],[128.59437605797854,35.88420774157897],[128.93210966179467,35.833005768035726],[129.23414784406933,35.864176125391644]]}'::jsonb,
 NULL
),
('충주 서남 전투',
 '몽골군의 충주에서 청주, 전주, 나주로의 서남 방향 침공.',
 36.71, 127.59,
 '몽골 장수', '고려 수비군',
 DATE '1254-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.93131919381034,36.96728697469413],[127.75009628444558,36.83549574992128],[127.5880939866801,36.714487296895506],[127.47414321791283,36.63076993323067],[127.39702236719513,36.37887455797606],[127.41233341659658,36.18646227977321],[127.41092695967716,35.984495029716015],[127.14870290142963,35.82207616164424],[126.95208778374575,35.42223674014667],[126.81205189923661,35.25642771920121],[126.72418624621126,35.04981289295541]]}'::jsonb,
 NULL
),
('합천 전투',
 '여몽연합군이 삼별초를 추격하며 합천 일대에서 벌인 전투.',
 35.56, 128.16,
 '여몽연합군', '삼별초',
 DATE '1270-08-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.93555027018184,36.967294742855444],[127.9836017991801,36.826709359668996],[128.02753462569277,36.73541019428352],[128.0769590555195,36.61644854068108],[128.1154100333957,36.517175998753146],[128.166207364051,36.41114195457391],[128.20432317120483,36.192916291445385],[128.14666133640696,35.90198459516128],[128.1493985539477,35.59219480266793]]}'::jsonb,
 NULL
),
('삼별초 용장 전투',
 '삼별초가 진도 용장성에서 나주, 전주 일대로 활동.',
 34.82, 126.71,
 '삼별초', '여몽연합군',
 DATE '1271-01-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[126.25949883595274,34.47408718205438],[126.70981030770763,34.81756514488553],[126.74275992759215,35.04276014748851],[127.08873093637945,35.34355061750656],[127.17659658940477,35.629831029790466],[127.16012177946253,35.826056448100985]]}'::jsonb,
 '#3b82f6'
),
('용장 상륙전 1',
 '여몽연합군의 진도 용장성 공략과 동래 방면 상륙작전.',
 34.57, 126.77,
 '여몽연합군', '삼별초',
 DATE '1271-05-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[126.30367669996674,34.48309921217883],[127.24823246998918,34.56909275083053],[127.28868376955711,34.83841237766662]]}'::jsonb,
 '#3b82f6'
),
('용장 상륙전 2',
 '삼별초 진압을 위한 여몽연합군의 추가 상륙 작전.',
 34.83, 127.55,
 '여몽연합군', '삼별초',
 DATE '1271-06-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.24886964552998,34.57082486120023],[127.82980084158173,34.83107132502204],[127.70349396535781,35.07421521252879]]}'::jsonb,
 '#3b82f6'
),
('용장 동래 전투',
 '여몽연합군의 동래 상륙 및 삼별초 잔당 소탕전.',
 35.04, 128.63,
 '여몽연합군', '삼별초',
 DATE '1271-07-01',
 (SELECT war_id FROM war WHERE name = '여몽전쟁(대몽항쟁)'),
 '{"type":"LineString","coordinates":[[127.82271058669636,34.83820962998523],[128.39383733136108,34.90131069426013],[128.6299762738667,35.04086202246355],[128.74255414180544,35.236282733528654],[129.07800977830223,35.181483185930354]]}'::jsonb,
 '#3b82f6'
),

-- 13 개경 탈환전
('개경 탈환전',
 '홍건적에게 점령당한 수도 개경을 이성계, 정세운, 최영 등이 탈환함.',
 37.96, 126.55,
 '이성계', '사유',
 DATE '1362-01-17',
 (SELECT war_id FROM war WHERE name = '홍건적의 난'),
 NULL,
 NULL
),

-- 14 황산 대첩
('황산 대첩',
 '이성계가 남원 운봉에서 아지발도가 이끄는 왜구 대군을 섬멸함.',
 35.45, 127.5,
 '이성계', '아지발도',
 DATE '1380-09-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)'),
 NULL,
 NULL
),

-- 15 진포 대첩
('진포 대첩',
 '최무선이 화포를 사용하여 왜선 500척을 소각시킴.',
 36, 126.7,
 '최무선', '왜구 장수',
 DATE '1380-08-01',
 (SELECT war_id FROM war WHERE name = '여일전쟁(왜구 토벌)'),
 NULL,
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

-- 추가 데이터
-- 통일 신라 (668년 이후)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김법민', '문무왕', '0661-07-01', '0681-07-01', 
        (SELECT country_id FROM country WHERE country_name = '통일 신라')); -- 신라 통일 완수 (676년)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김정명', '신문왕', '0681-07-01', '0692-08-01', 
        (SELECT country_id FROM country WHERE country_name = '통일 신라')); -- 통치 체제 정비

-- 발해 (698년 이후)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대조영', '고왕', '0698-01-01', '0719-06-01', 
        (SELECT country_id FROM country WHERE country_name = '발해')); -- 발해 건국
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대무예', '무왕', '0719-06-01', '0737-05-01', 
        (SELECT country_id FROM country WHERE country_name = '발해')); -- 장문휴를 보내 등주 공격
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대흠무', '문왕', '0737-05-01', '0793-06-01', 
        (SELECT country_id FROM country WHERE country_name = '발해')); -- 중흥기, 상경 용천부 천도 (785년경)

-- 고려 (왕건 이후)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕무', '혜종', '0943-07-04', '0945-09-29', 
        (SELECT country_id FROM country WHERE country_name = '고려'));
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕요', '정종', '0945-09-30', '0949-04-13', 
        (SELECT country_id FROM country WHERE country_name = '고려'));
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕치', '목종', '0997-11-29', '1009-03-02', 
        (SELECT country_id FROM country WHERE country_name = '고려'));
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕흠', '문종', '1046-09-02', '1083-09-02', 
        (SELECT country_id FROM country WHERE country_name = '고려'));
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕서', '의종', '1146-04-10', '1170-09-01', 
        (SELECT country_id FROM country WHERE country_name = '고려')); -- 무신정변으로 폐위
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕강', '우왕', '1374-10-23', '1388-11-28', 
        (SELECT country_id FROM country WHERE country_name = '고려')); -- 최영, 이성계의 활동 시기
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕창', '창왕', '1388-11-28', '1389-12-12', 
        (SELECT country_id FROM country WHERE country_name = '고려'));
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕요', '공양왕', '1389-12-12', '1392-07-17', 
        (SELECT country_id FROM country WHERE country_name = '고려')); -- 고려의 마지막 왕

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

-- 추가 데이터
-- 발해의 수도 (중경 현덕부)
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '중경 현덕부',
    '0742-01-01', -- 무왕 천도 시점(대략)
    '0785-01-01', -- 문왕의 상경 천도 전
    128.800,
    43.800,
    '발해 무왕 때 천도한 수도.',
    (SELECT country_id FROM country WHERE country_name = '발해')
);

-- 후고구려(태봉)의 초기 수도
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '송악(개성)',
    '0901-01-01', -- 궁예 건국 시점
    '0905-01-01', -- 궁예의 철원 천도 시점
    126.560,
    37.970,
    '궁예가 후고구려를 건국하고 초기에 도읍으로 삼았던 곳.',
    (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)')
);

-- 왜구 (수도 개념이 아닌 근거지/활동 지역으로 설정)
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '쓰시마(대마도)',
    '1350-01-01', -- 왜구 활동 시기 시작
    '1392-12-31', -- 왜구 활동 시기 끝
    129.400,
    34.400,
    '주요 왜구 근거지 중 하나로, 고려와 조선을 빈번히 침탈한 중심지.',
    (SELECT country_id FROM country WHERE country_name = '왜구')
);
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '이키(일기도)',
    '1350-01-01', -- 왜구 활동 시기 시작
    '1392-12-31', -- 왜구 활동 시기 끝
    129.900,
    33.800,
    '규슈 북부와 한반도 사이의 왜구 주요 근거지.',
    (SELECT country_id FROM country WHERE country_name = '왜구')
);

-- 당(唐)의 수도
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '장안(長安)',
    '0618-01-01', -- 당 건국 시점
    '0907-05-12', -- 당 멸망 시점
    108.940, -- 시안(西安) 대략적 경도
    34.260,  -- 시안(西安) 대략적 위도
    '당나라의 수도. 세계적인 국제 도시였음.',
    (SELECT country_id FROM country WHERE country_name = '당')
);

-- 후백제(後百濟) 초기 수도 (건국 시점)
-- 892년 건국 당시 거점이었던 무진주(광주)를 초기 수도로 설정하고, 900년 완산주(전주) 천도 직전까지의 기간을 설정합니다.
INSERT INTO capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES (
    '무진주(광주)',
    '0892-01-01', -- 후백제 건국 시점
    '0899-12-31', -- 완산주 천도 직전
    126.850, 
    35.150, 
    '견훤이 후백제 건국 초기 거점으로 삼았던 곳.',
    (SELECT country_id FROM country WHERE country_name = '후백제')
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
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    850,
    '사신 및 문물 교류 (신라도)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    850,
    '사신 및 문물 교류 (신라도)'
),

(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    900,
    '사신 및 문물 교류 (신라도)'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '통일 신라'),
    (SELECT country_id FROM country WHERE country_name = '발해'),
    900,
    '사신 및 문물 교류 (신라도)'
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
    '금, 은, 나전칠기, 화문석, 인삼 먹'
),
(
    gen_random_uuid(),
    (SELECT country_id FROM country WHERE country_name = '송'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    1000,
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
-- 무역 경로 초기 데이터 (trade_route)
-- =========================================================================

-- 통일 신라 교역로 (초록색 #22c55e)
-- 신라 -> 일본
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.1286872236279,36.189910984225456],[130.6001761729678,35.08255242902931],[130.55625112970392,33.70437995522579],[129.1286872236279,36.189910984225456]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 800;

-- 당 -> 신라
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[120.49554362433871,37.647031342443796],[122.03292013857435,38.08077837506512],[124.40487247482366,37.28071441167715],[126.73289976780912,37.21073643300401],[120.49554362433871,37.647031342443796]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 800;

-- 신라 -> 발해 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.08476218036407,35.95899581025994],[128.90906200730856,37.43904061708303],[127.26187288491319,38.97585898089492],[128.0085986203991,40.14488015694201],[129.39223748321118,41.836737100500656],[129.08476218036407,35.95899581025994]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 800;

-- 신라 -> 발해 (850년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.08476218036407,35.95899581025994],[128.90906200730856,37.43904061708303],[127.26187288491319,38.97585898089492],[128.0085986203991,40.14488015694201],[129.39223748321118,41.836737100500656],[129.08476218036407,35.95899581025994]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 850;

-- 신라 -> 발해 (900년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.08476218036407,35.95899581025994],[128.90906200730856,37.43904061708303],[127.26187288491319,38.97585898089492],[128.0085986203991,40.14488015694201],[129.39223748321118,41.836737100500656],[129.08476218036407,35.95899581025994]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 900;

-- 신라 -> 발해 (910년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[129.08476218036407,35.95899581025994],[128.90906200730856,37.43904061708303],[127.26187288491319,38.97585898089492],[128.0085986203991,40.14488015694201],[129.39223748321118,41.836737100500656],[129.08476218036407,35.95899581025994]]}'::jsonb,
    '#22c55e'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 910;

-- 발해 교역로 (파란색 #3b82f6)
-- 발해 -> 당
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[127.76513828451019,41.65532509123914],[124.16328473687231,39.85761454320746],[120.53946866760258,37.52512515508885],[127.76513828451019,41.65532509123914]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.trade_year = 900;

-- 당 -> 발해
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[120.51750614597064,37.54255254627726],[124.1852472585043,39.958761016899935],[127.17215020044785,41.44151089428502],[120.51750614597064,37.54255254627726]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '당')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 900;

-- 발해 -> 일본
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[130.53241601013434,42.649149815868775],[132.8604433031198,39.28163410580962],[136.79173467523668,36.77190412676978],[130.53241601013434,42.649149815868775]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.trade_year = 900;

-- 일본 -> 발해
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[136.79046784797896,36.70128399331513],[132.50777612975102,39.14524797772245],[130.5750742261405,43.06784240053568],[136.79046784797896,36.70128399331513]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '일본')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 900;

-- 발해 -> 통일신라 (800년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.90718940937094,40.779190862048594],[126.73289976780912,39.57022244509562],[127.10626263555206,38.5463520708126],[129.1048521040584,36.277413318559375],[128.90718940937094,40.779190862048594]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 800;

-- 발해 -> 통일신라 (850년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.90718940937094,40.779190862048594],[126.73289976780912,39.57022244509562],[127.10626263555206,38.5463520708126],[129.1048521040584,36.277413318559375],[128.90718940937094,40.779190862048594]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 850;

-- 발해 -> 통일신라 (900년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.90718940937094,40.779190862048594],[126.73289976780912,39.57022244509562],[127.10626263555206,38.5463520708126],[129.1048521040584,36.277413318559375],[128.90718940937094,40.779190862048594]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 900;

-- 발해 -> 통일신라 (910년)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[128.90718940937094,40.779190862048594],[126.73289976780912,39.57022244509562],[127.10626263555206,38.5463520708126],[129.1048521040584,36.277413318559375],[128.90718940937094,40.779190862048594]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '통일 신라')
  AND t.trade_year = 910;

-- 발해 -> 거란(요나라 이전)
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[119.68293032395698,41.34258898946489],[124.1852472585043,41.21045902267935],[127.19411272207978,42.22746076439319],[129.30251479874585,43.595522021421075],[119.68293032395698,41.34258898946489]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.trade_year = 900;

-- 거란(요나라 이전) -> 발해
INSERT INTO trade_route (route_id, trade_id, path, route_color)
SELECT 
    gen_random_uuid(),
    t.trade_id,
    '{"type":"LineString","coordinates":[[118.95816711010303,41.22698989464572],[123.13104622017127,41.21045902267935],[125.78851133763578,41.42503436409593],[129.50017749343326,43.6114360154971],[118.95816711010303,41.22698989464572]]}'::jsonb,
    '#3b82f6'
FROM trade t
WHERE t.start_country_id = (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)')
  AND t.end_country_id = (SELECT country_id FROM country WHERE country_name = '발해')
  AND t.trade_year = 900;