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
    ('일본', 780, 1392);

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