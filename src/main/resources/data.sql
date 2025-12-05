-- 초기 데이터 추가 시 schema.sql에서 id 기본값 설정 필요

-- 국가 초기 데이터
INSERT INTO country (country_name, foundation_year, ended_year, title, description, summary) VALUES
    -- 한국사 주요 국가 (780년 이전 건국)
    (
        '통일 신라',
        668,
        935,
        '통일 신라 건국',
        '통일 신라는 668년 삼국을 통일한 뒤 한반도 남부를 중심으로 정치적 통일을 이룬 국가로 자리 잡는다.
중앙집권 체제를 정비하고 불교와 예술, 과학 기술을 발전시키며 통일 왕조의 문화를 꽃피운다.
그러나 진골 귀족의 권력 다툼과 각지에서 일어나는 반란과 농민 봉기를 겪으며 점차 정치적 안정성을 잃어 간다.
결국 지방 호족 세력의 성장과 후삼국 성립 속에서 힘을 잃고 935년에 고려에 나라를 넘기게 된다.',
        '삼국 통일 이후 중앙집권과 불교 문화를 발전시키지만 내부 모순과 지방 세력 성장으로 고려에 계승된 국가.'
    ),
    (
        '발해',
        698,
        926,
        '발해 건국',
        '발해는 대조영이 고구려 유민과 말갈 세력을 이끌고 698년에 건국한 국가로 고구려를 계승한다고 본다.
한반도 북부와 만주 일대를 아우르며 해상 교역과 육상 교통로를 활용하여 동아시아의 중요한 세력으로 성장한다.
당과 일본 등과의 외교 관계를 통해 국제적 위상을 높이고 고구려 계승 국가로서의 문화를 발전시키며 해동성국으로 불린다.
그러나 귀족 세력의 갈등과 외부 세력의 압박 속에서 국력이 약화되어 926년에 멸망하게 된다.',
        '고구려를 계승하여 만주와 한반도 북부에서 번영하다가 내부·외부 요인으로 10세기 초에 멸망한 국가.'
    ),

    -- 후삼국 및 고려
    (
        '후백제',
        892,
        936,
        '후백제 건국',
        '후백제는 892년 견훤이 전라 일대를 중심으로 세력을 모아 세운 국가로 통일 신라 말기의 혼란 속에서 등장한다.
완산주를 도읍으로 삼고 군사력과 해상 교역을 바탕으로 후삼국의 한 축을 담당하며 고려와 신라를 압박한다.
그러나 왕권 내부의 갈등과 후계자 분쟁, 견훤과 아들 신검 사이의 대립으로 정치적 불안이 심화된다.
결국 견훤의 고려 귀부와 왕건의 공세가 맞물리며 936년에 멸망하게 된다.',
        '전라도 지역을 기반으로 후삼국의 한 축을 이루었으나 내분과 고려의 공세로 멸망한 국가.'
    ),
    (
        '후고구려(태봉)',
        901,
        918,
        '후고구려(태봉) 건국',
        '후고구려(태봉)는 궁예가 송악을 근거지로 901년에 세운 국가로 스스로를 고구려의 계승자로 내세운다.
처음에는 후백제와 함께 통일 신라를 압박하며 후삼국 시대의 주도권을 다투는 세력으로 성장한다.
그러나 궁예의 폭정과 심한 의심으로 인해 신료와 백성의 지지가 약해지고 내부 불만이 크게 쌓인다.
결국 왕건을 중심으로 한 세력이 궁예를 몰아내고 918년 고려를 세우면서 후고구려(태봉)는 역사 속에서 사라진다.',
        '고구려 계승을 표방하며 후삼국의 한 축을 이루었으나 궁예의 폭정과 왕건의 집권으로 소멸한 국가.'
    ),
    (
        '고려',
        918,
        1392,
        '고려 건국',
        '고려는 918년 왕건이 궁예를 몰아내고 세운 국가로 고구려 계승 의식을 바탕으로 한반도 재통일을 추진한다.
후삼국을 통일한 뒤 문벌 귀족 사회와 불교 문화를 중심으로 한 중세 국가 체제를 발전시키며 동아시아 질서 속에 자리 잡는다.
거란과 여진, 몽골 등과의 전쟁과 외교를 거치며 대외적으로는 자주성을 지키려 노력하고 내부적으로는 개혁과 혼란을 반복한다.
원 간섭기와 권문세족의 부패, 신흥 무인과 신진 사대부 세력의 대두 속에서 점차 쇠퇴하고 1392년 조선의 건국과 함께 막을 내린다.',
        '후삼국을 통일해 중세 한반도를 통치했으나 외침과 내부 모순 속에서 조선으로 교체된 국가.'
    ),

    -- 중국 왕조 및 기타 세력
    ('당', 618, 907, NULL, NULL, NULL),
    ('거란(요나라 이전)', 780, 916, NULL, NULL, NULL),
    ('요(거란)', 916, 1125, NULL, NULL, NULL),
    ('송', 960, 1279, NULL, NULL, NULL),
    ('서하', 1038, 1227, NULL, NULL, NULL),
    ('금', 1115, 1234, NULL, NULL, NULL),
    ('몽골 제국', 1206, 1271, NULL, NULL, NULL),
    ('원', 1271, 1368, NULL, NULL, NULL),
    ('명', 1368, 1392, NULL, NULL, NULL),

    -- 주변국
    ('일본', 780, 1392, NULL, NULL, NULL),
    ('여진', 1100, 1234, NULL, NULL, NULL),
    ('홍건적', 1350, 1370, NULL, NULL, NULL),
    ('왜구', 1350, 1392, NULL, NULL, NULL);

-- ##################################################
-- 주요사건 데이터
INSERT INTO main_event (
    event_id, country_id, event_name, year, era, description, summary
) VALUES
    -- 통일 신라 말
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '통일 신라'),
        '혜공왕 피살 및 왕위 다툼 심화',
        780,
        '신라 말',
        '진골 귀족들이 반란을 일으켜 혜공왕을 살해한다.
이 사건으로 무열왕계의 왕위 세습이 단절되면서 왕위 계승 질서가 크게 흔들린다.
이후 중앙 귀족들 사이에서 왕위를 둘러싼 치열한 쟁탈전이 이어진다.
약 150여 년 동안 20여 명의 왕이 교체될 정도로 왕권이 약화되며 신라 하대의 혼란이 심화된다.',
        '혜공왕 피살과 무열왕계 왕위 세습 단절'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '통일 신라'),
        '장보고, 청해진 설치',
        828,
        '신라 말',
        '당나라에서 활동하던 장보고가 흥덕왕에게 건의하여 완도에 해상 거점인 청해진을 설치한다.
그는 청해진을 근거지로 신라·당·일본을 잇는 해상 무역로를 장악한다.
장보고는 해적 세력을 소탕하여 동아시아 해상 무역의 안전을 확보하고 막대한 무역 이익을 축적한다.
청해진은 동아시아 삼국을 잇는 중계 무역의 중심지로 성장하고 장보고는 해상왕으로 불린다.',
        '청해진 설치와 동아시아 해상 무역 거점 형성'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '통일 신라'),
        '김헌창의 난',
        822,
        '신라 말',
        '웅주 도독 김헌창이 부친이 왕이 되지 못한 것에 불만을 품고 반란을 일으킨다.
그는 국호를 장안이라 칭하고 스스로 왕을 자처하며 지방 군사력을 동원한다.
이 반란은 지방 세력이 중앙 정부의 통제를 벗어나 독자적인 정치 세력을 형성했음을 보여준다.
비록 진압되지만 신라 중앙 정부의 지방 통제력이 크게 약화되었음을 드러낸 사건이 된다.',
        '김헌창의 국호 장안 선포와 지방 세력 반란'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '통일 신라'),
        '원종·애노의 난',
        889,
        '신라 말',
        '진성 여왕 시기 중앙 정부가 재정 확보를 위해 지방에 가혹한 세금을 부과한다.
이에 사벌주(상주)에서 원종과 애노가 주도하여 대규모 농민 봉기가 일어난다.
봉기는 전국 각지로 빠르게 확산되며 신라 사회의 혼란을 더욱 심화시킨다.
중앙 정부는 이를 효과적으로 진압하지 못해 지방 통제력을 사실상 상실하게 된다.',
        '사벌주에서 시작된 전국적 농민 봉기'
    ),

    -- 후삼국 및 고려 성립 과정 (건국/천도 직접 이벤트는 제외)
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '신라 경순왕, 고려에 항복',
        935,
        '후삼국 통일',
        '신라의 마지막 왕 경순왕이 더 이상 나라를 유지하기 어렵다고 판단한다.
그는 전쟁을 통한 소모를 피하기 위해 고려 태조 왕건에게 나라를 스스로 넘기기로 결심한다.
왕건은 경순왕을 예우하고 신라 유민과 귀족들을 포용하는 정책을 펼친다.
이를 통해 신라 세력이 고려에 평화적으로 흡수되며 민족 재통합의 기반이 마련된다.',
        '신라 경순왕의 평화적 항복과 신라 세력의 고려 편입'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '고려, 후삼국 통일 완성',
        936,
        '후삼국 통일',
        '신라 항복 이후 왕건은 견훤의 귀부를 받아들이고 후백제와 최후의 결전을 준비한다.
일리천 전투에서 고려 군대가 후백제 군대를 크게 격파한다.
이 승리로 후백제가 멸망하고 후삼국의 분열 상태가 종식된다.
고려는 신라·후백제·발해 유민을 포용하며 민족 재통합과 중세 국가 체제의 기틀을 마련한다.',
        '일리천 승리를 통한 후삼국 통일 완성'
    ),

    -- 광종 개혁
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '광종, 노비안검법 실시',
        956,
        '고려 초기',
        '광종이 왕권 강화를 위해 불법적으로 노비가 된 사람들을 조사하는 노비안검법을 실시한다.
이 법을 통해 권세가와 호족들이 사적으로 확보한 노비와 토지를 국가 통제 아래 두려 한다.
노비 신분에서 양인으로 해방된 이들이 늘어나면서 국가의 조세와 군역 기반이 넓어진다.
그 결과 호족 세력의 경제·군사적 기반이 약화되고 국왕 중심의 통치력이 강화된다.',
        '광종의 노비안검법 실시와 호족 세력 약화'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '광종, 과거제 실시',
        958,
        '고려 초기',
        '광종이 쌍기의 건의를 받아들여 유교적 소양을 갖춘 인재를 뽑기 위한 과거제를 시행한다.
과거제는 혈통보다는 능력과 학문을 기준으로 관리를 선발하는 제도로 설계된다.
이를 통해 신진 관료층이 대거 등용되고 기존 호족 세력의 정치적 영향력이 견제된다.
국왕을 중심으로 한 관료제 통치 질서가 확립되며 왕권 강화가 한층 진전된다.',
        '광종의 과거제 실시와 능력 중심 관료 선발 제도 확립'
    ),

    -- 여요·여진 관련 (전쟁 자체는 war 테이블, 여기서는 핵심 사건)
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '서희, 외교 담판 및 강동 6주 확보',
        993,
        '고려 전기',
        '거란이 1차 침입을 감행했을 때 서희가 거란 장수 소손녕과 단독으로 외교 담판을 벌인다.
서희는 고려가 고구려 계승 국가임을 내세우며 거란의 공격 명분을 약화시킨다.
그는 송과의 외교 단절을 약속하는 대신 여진이 차지하던 압록강 하류의 영토를 요구한다.
이 협상으로 고려는 전쟁 없이 강동 6주를 확보하는 외교적 승리를 거둔다.',
        '서희의 외교 담판을 통한 강동 6주 확보'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '강감찬, 귀주대첩 승리',
        1019,
        '고려 전기',
        '거란의 3차 침입 때 강감찬이 고려군의 총지휘관이 되어 방어 작전을 지휘한다.
그는 흥화진에서 거란군을 기습하여 큰 타격을 입힌 뒤 후퇴하는 적을 계속 추격한다.
귀주에서 벌어진 결전에서 고려군은 거란 주력군을 포위 섬멸하는 대승을 거둔다.
이 승리로 거란의 침략 의지가 꺾이고 동아시아의 다원적 국제 질서가 유지된다.',
        '거란 3차 침입 격퇴와 귀주대첩 승리'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '윤관, 동북 9성 축조',
        1108,
        '고려 전기',
        '여진족이 북방에서 세력을 키우며 국경을 침범하자 윤관은 별무반을 조직해 정벌을 추진한다.
별무반은 기병 중심의 특수 부대로 편성되어 여진에 대한 대대적인 공격을 수행한다.
윤관은 여진을 몰아내고 동북 지역에 9개의 성을 쌓아 고려의 북방 영토 확장을 시도한다.
그러나 험준한 지형과 방어의 어려움, 여진의 지속적인 압박으로 결국 동북 9성은 여진에게 반환된다.',
        '별무반 편성과 동북 9성 축조 및 반환'
    ),

    -- 문벌 귀족 사회의 동요
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '이자겸의 난',
        1126,
        '고려 전기',
        '경원 이씨 가문의 최고 권력자 이자겸이 외척 세력을 바탕으로 권력을 독점한다.
그는 외손자인 인종을 압박하고 왕궁에 불을 지르는 등 극단적인 전횡을 일삼는다.
인종이 쿠데타를 시도하지만 처음에는 실패하고 오히려 이자겸이 정국을 장악한다.
이 사건은 문벌 귀족 사회의 모순과 외척 권력의 폐단을 드러내며 지배 질서의 동요를 촉진한다.',
        '경원 이씨 이자겸의 외척 권력 장악과 반란 사건'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '묘청의 서경 천도 운동',
        1135,
        '고려 전기',
        '풍수지리설을 내세운 묘청과 서경 세력이 개경의 문벌 귀족 세력을 견제하려 한다.
그들은 서경(평양)으로의 천도와 함께 금나라 정벌을 주장하며 자주적인 개혁 노선을 제시한다.
그러나 김부식을 비롯한 보수적인 개경파가 이를 강하게 반대한다.
묘청이 끝내 반란을 일으키지만 김부식이 이끄는 관군에 의해 진압되면서 서경파는 패배한다.',
        '묘청 서경파의 천도·금 정벌 주장과 개경파와의 대립'
    ),

    -- 무신 정권 수립과 하층민 저항
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '무신정변 발생',
        1170,
        '무신 정권',
        '문신 중심의 정치 구조 속에서 오랫동안 차별받던 무신들의 불만이 극도로 쌓인다.
의종의 문신 편중 인사와 향락적인 생활이 계속되자 정중부·이의방 등이 무신정변을 일으킨다.
이들은 궁궐에 난입해 다수의 문신을 살해하고 정권을 장악한다.
이 사건으로 약 100년간 무신이 정치를 주도하는 무신 정권 시대가 열리고 중방과 교정도감이 최고 권력 기구가 된다.',
        '정중부·이의방 주도의 무신정변과 무신 정권 수립'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '망이·망소이의 난',
        1176,
        '무신 정권',
        '무신 정권의 가혹한 수탈과 지방 차별에 시달리던 공주 명학소 주민들이 봉기를 일으킨다.
망이와 망소이가 중심이 되어 지방 행정 기구에 저항하며 세력을 확대한다.
이들은 일시적으로 공주를 점령하는 등 무신 정권에 큰 위협을 가한다.
이 난은 하층민이 신분 차별과 수탈에 집단적으로 저항한 대표적인 농민 봉기 사례가 된다.',
        '공주 명학소 주민 주도의 반무신 정권 농민 봉기'
    ),
    (
        gen_random_uuid(),
        (SELECT country_id FROM country WHERE country_name = '고려'),
        '만적의 봉기 계획',
        1198,
        '무신 정권',
        '최충헌의 사노비였던 만적이 노비 해방과 정권 전복을 목표로 봉기를 준비한다.
그는 "장군·재상에 어찌 씨가 따로 있겠느냐"라는 말로 신분 차별에 대한 문제 의식을 드러낸다.
만적은 노비와 천민들을 규합해 대규모 봉기를 모의하지만 계획이 사전에 발각된다.
주모자들이 체포·처형되면서 봉기는 실행되지 못하지만 천민 의식의 성장을 상징하는 사건이 된다.',
        '최충헌의 사노비 만적이 주도한 노비 해방·정권 전복 봉기 계획'
    )
    -- 대몽 항쟁 관련 '강화도 천도', '개경 환도' 등은
    -- capital 및 war 테이블(여몽전쟁)과 중복되어 main_event에서는 제외
;

    

-- ##################################################
-- 전쟁 초기 데이터
-- 후삼국 통일 전쟁 (WAR_TK)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '후삼국 통일 전쟁',
    '신라 말기 왕건이 고려를 건국하면서 후백제, 신라와 대립하며 벌인 약 18년간의 민족 통합 전쟁이다. 이 전쟁은 고창 전투와 운주성 전투 등 주요 전투를 거치며 고려 쪽으로 세력의 추가 기울게 한다. 왕건은 신라에 대해 유화적인 정책을 펴서 평화적으로 신라를 흡수한다. 마지막에는 후백제의 내분과 일리천 전투의 승리를 통해 최종적으로 후삼국을 통일하며 고려 왕조의 기틀을 마련한다.',
    DATE '0918-06-15',
    DATE '0936-09-01',
    '고려 승리, 후삼국 통일',
    '고창 전투와 일리천 전투에서 승리하여 신라 항복과 후백제 멸망을 통해 민족 재통합을 완성함.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '후백제')
);
-- 여요전쟁 (거란 침입, WAR_KH)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여요전쟁(거란 침입)',
    '거란(요나라)이 송나라와의 관계 단절 등을 요구하며 고려를 세 차례에 걸쳐 대규모로 침략한 전쟁이다. 1차 침입 시 서희가 외교 담판을 통해 오히려 강동 6주를 확보하여 고려의 영토를 확장하는 성과를 얻는다. 2차 침입 때는 현종이 피난하는 등 위기를 겪지만 양규 등의 활약으로 거란군을 격퇴한다. 마지막 3차 침입에서는 강감찬 장군이 귀주에서 거란의 주력군을 궤멸시키는 대승을 거두어 전쟁을 최종적으로 종결시킨다.',
    DATE '0993-10-01',
    DATE '1019-02-01',
    '고려 승리, 강동 6주 확보',
    '1차 침입 때 서희의 외교 담판으로 강동 6주를 확보하고, 3차 침입 때 강감찬이 귀주에서 거란군을 대파하여 평화를 이룸.',
    (SELECT country_id FROM country WHERE country_name = '거란(요나라 이전)'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);
-- 여진 정벌 (WAR_JR)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여진 정벌',
    '고려 북방에서 세력을 키우던 여진족을 제압하기 위해 숙종과 예종 시기에 추진된 군사 작전이다. 고려는 기병에 대응하기 위해 윤관의 건의에 따라 별무반을 창설한다. 별무반을 이끈 윤관은 대규모 정벌을 감행하여 여진족을 몰아내고 동북 9성을 축조하는 데 성공한다. 그러나 여진족의 끈질긴 공세와 9성 방어의 어려움 때문에 고려는 결국 여진에게 9성을 돌려주고 전쟁을 마무리한다.',
    DATE '1104-02-01',
    DATE '1109-06-01',
    '고려 부분적 승리 후 9성 반환',
    '기병 중심 별무반으로 여진을 압박해 동북 9성을 축조했으나 방어의 어려움으로 결국 여진에게 돌려줌.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '여진')
);
-- 여몽전쟁(대몽항쟁, WAR_MG)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여몽전쟁(대몽항쟁)',
    '몽골 사신 피살 사건을 계기로 시작된 몽골의 침략에 맞서 고려가 약 40여 년간 치른 항쟁이다. 몽골의 강력한 군사력에 맞서 고려 조정은 강화도로 천도하여 장기 항전을 벌인다. 김윤후의 처인성 전투와 충주성 항전처럼 민관군이 함께 저항하는 모습을 보인다. 최씨 무신 정권이 붕괴된 후 몽골과의 강화가 체결되면서 전쟁이 종결된다. 그러나 삼별초는 이에 불복하고 진도와 제주도에서 항쟁을 이어가며 마지막까지 자주 의지를 드러낸다.',
    DATE '1231-08-01',
    DATE '1270-05-01',
    '고려가 몽골과 강화 체결 후 원 간섭기 시작',
    '귀주성·처인성·충주성 등에서 항전했으나 국토가 황폐화되고 결국 몽골과 강화하여 개경으로 환도, 이후 원 간섭기가 전개됨.',
    (SELECT country_id FROM country WHERE country_name = '몽골 제국'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);
-- 홍건적의 난 (WAR_RB)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '홍건적의 난',
    '원나라 말기 혼란 속에서 등장한 한족 반란군인 홍건적이 고려의 영토를 침범한 사건이다. 1차 침입 때 서경(평양)까지 함락시키며 큰 피해를 입힌다. 2차 침입 때는 홍건적이 수도인 개경을 점령하고 공민왕이 복주(안동)까지 피난하는 위기를 초래한다. 그러나 고려는 이성계, 최영 등의 장수들을 중심으로 대규모 반격 작전을 펼친다. 결국 개경을 탈환하고 홍건적을 완전히 격퇴하여 국가의 안정을 되찾는다.',
    DATE '1359-12-01',
    DATE '1362-01-31',
    '고려 승리, 개경 탈환',
    '홍건적이 개경을 함락했으나 이성계·정세운·최영 등의 활약으로 수도를 탈환하고 홍건적을 격퇴함.',
    (SELECT country_id FROM country WHERE country_name = '홍건적'),
    (SELECT country_id FROM country WHERE country_name = '고려')
);
-- 여일전쟁(왜구 토벌, WAR_JP)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id
) VALUES (
    '여일전쟁(왜구 토벌)',
    '고려 후기 일본에서 넘어온 해적 집단인 왜구가 해안과 내륙 깊숙한 곳까지 침입하여 약탈을 일삼아 국가를 위기에 빠뜨린 사건에 대한 대응 전쟁이다. 고려는 최영, 이성계, 최무선 등 뛰어난 장수들을 중심으로 대대적인 왜구 토벌 작전을 전개한다. 최무선이 발명한 화포를 사용한 진포 대첩에서 왜선 500여 척을 격침시키며 해상 방어력을 입증한다. 또한 이성계는 황산 대첩에서 왜구 주력을 크게 격파하는 등 큰 승리를 거두어 왜구의 세력을 약화시킨다.',
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

-- 4 안융진 전투 (서희 담판) - 거란 1차 침입
('안융진 전투 (서희 담판)',
 '거란 소손녕의 침입을 막고 서희가 외교 담판을 벌여 강동 6주를 확보함.',
 39.61, 125.66,
 '서희', '소손녕',
 DATE '0993-10-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[121.37481611235964,42.37239001865886],[123.00173202107518,41.56490648168317],[124.04524728067838,40.82081878730365],[123.30451260837796,40.131998120610305],[124.14130452355224,40.139874368039365],[124.54086102426874,40.19130103047869],[124.84979646296702,40.1892027457104],[124.99147905102323,40.09907593553345],[125.15850440375374,39.86934587072625],[125.65017194191675,39.61167931564372],[121.37481611235964,42.37239001865886]]}'
),

-- 5 흥화진 전투 - 거란 2차 침입
('흥화진 전투',
 '양규가 거란 성종의 40만 대군을 7일간 막아내며 거란군의 남하를 지연시킴.',
 40.19, 124.53,
 '양규', '야율융서',
 DATE '1010-11-16',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[123.34053716110319,40.30018131918214],[123.81286512071308,40.260366875541834],[124.12866579138245,40.21633416242909],[124.38679851349482,40.01257351417898],[124.72456792647166,39.86936716903908],[125.24414258197129,39.76421948702072],[125.63913571102401,39.763869617141985],[125.97971971078415,39.700512294091375],[126.01267282424531,39.497331729669924],[125.87489166231657,39.25280905793491],[125.7737637301376,39.016680997075106],[125.9353595203723,38.7105316987703],[126.17152350017722,38.43995878922502],[126.25992049149654,38.222722826097794],[126.4823540073593,38.20545753178675],[126.55649851264693,37.97197542164486],[123.34053716110319,40.30018131918214]]}'
),

-- 6 귀주 대첩 - 거란 3차 침입
('귀주 대첩',
 '강감찬이 퇴각하는 소배압의 10만 거란군을 귀주에서 맞이하여 크게 물리침.',
 39.97, 125.24,
 '강감찬', '소배압',
 DATE '1019-02-01',
 (SELECT war_id FROM war WHERE name = '여요전쟁(거란 침입)'),
 '{"type":"LineString","coordinates":[[123.42852465618168,40.365064066214195],[123.73883314127423,40.358785173416706],[124.0079502345403,40.33156988042983],[124.21390719367251,40.27501072924152],[124.51323130761133,40.03988961639689],[124.90317648356829,39.93887430873096],[125.25742245327567,39.97045763878426],[125.56498484557977,39.89674051682011],[126.0813593909535,39.846150729675486],[126.1912031024907,39.65397341426662],[126.23514058710555,39.34452593029174],[126.32593924426759,39.046578729379625],[126.34517070015735,38.796553568627566],[126.52915891698213,38.50266411836324],[123.42852465618168,40.365064066214195]]}'
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
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '금성(경주)',
    '0676-01-01', -- 삼국통일 시점
    '0935-11-01', -- 신라 멸망 시점
    129.224,
    35.856,
    NULL,
    NULL,
    '신라의 천년 고도로 혜공왕 피살 이후 왕위 다툼이 치열하게 이어졌던 곳.',
    (SELECT country_id FROM country WHERE country_name = '통일 신라')
);

-- 상경 용천부 - 발해 (천도)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '상경 용천부',
    '0785-01-01', -- 문왕 천도 시점(대략)
    '0926-01-14', -- 발해 멸망 시점
    129.150,
    44.120,
    '발해 상경 용천부 천도',
    '발해 문왕이 중경에서 상경 용천부로 천도하여 새로운 정치 중심지를 마련한다.
당의 장안성을 본떠 도성을 계획적으로 건설하며 왕권과 중앙집권 체제를 강화한다.
해상과 육상 교통로를 연결하는 거점으로 활용하여 교역과 외교를 적극적으로 전개한다.
상경의 발전을 통해 발해는 해동성국으로 불릴 만큼 국력을 과시하는 기반을 갖추게 된다.',
    '발해 문왕이 천도하여 당의 장안성을 본떠 건설한 핵심 수도.',
    (SELECT country_id FROM country WHERE country_name = '발해')
);

-- 완산주(전주) - 후백제
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '완산주(전주)',
    '0900-01-01', -- 후백제 건국 시점
    '0936-09-01', -- 후백제 멸망 시점
    127.148,
    35.824,
    NULL,
    NULL,
    '견훤이 900년에 후백제를 세우고 도읍으로 삼은 곳.',
    (SELECT country_id FROM country WHERE country_name = '후백제')
);

-- 송악(개성) - 고려 (천도)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '송악(개성)',
    '0919-01-01', -- 왕건이 철원에서 송악으로 천도한 시점
    '1392-07-28', -- 고려 멸망 시점
    126.560,
    37.970,
    '고려 송악 천도',
    '왕건이 철원에서 송악으로 천도하여 새로운 왕조의 정치적 중심을 확립한다.
해상 교통과 내륙 교통이 만나는 거점으로 삼아 상업과 교역 기반을 강화한다.
주변 호족 세력과의 연계를 통해 북방과 서해 연안까지 포괄하는 통치 기반을 다진다.
송악을 수도로 삼으면서 고려는 통일 국가로 성장할 발판을 마련하게 된다.',
    '왕건이 철원에서 천도하여 고려의 수도로 삼은 도시.',
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 철원 - 후고구려(태봉) (천도)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '철원',
    '0905-01-01', -- 궁예의 철원 천도 시점(대략)
    '0918-06-15', -- 궁예 축출 및 고려 건국 시점
    127.200,
    38.270,
    '태봉 철원 천도',
    '궁예가 송악에서 철원으로 천도하여 왕권을 강화할 새로운 거점을 마련한다.
철원의 지형적 이점을 활용하여 방어에 유리한 수도 체계를 구축하려 한다.
천도 이후 궁예는 국호를 태봉으로 바꾸며 독자적인 왕조 체제를 강화하려 시도한다.
그러나 폭정과 의심이 심화되면서 지지 기반이 약해지고 결국 왕건 세력에 의해 축출되는 계기를 맞게 된다.',
    '궁예가 송악에서 천도하여 태봉의 도읍으로 삼았던 지역.',
    (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)')
);

-- 강화도 - 고려 임시 수도 (천도)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '강화도',
    '1232-07-01', -- 최우가 몽골 침입에 대비해 천도한 시점
    '1270-05-01', -- 개경 환도 시점
    126.485,
    37.746,
    '강화도 천도',
    '최우가 몽골의 침입에 대응하기 위해 개경에서 강화도로 천도하여 장기 항전을 준비한다.
강화도는 바다로 둘러싸인 지형을 바탕으로 방어에 유리한 임시 수도 역할을 수행한다.
조정은 이곳에서 대몽 항쟁을 지속하며 국왕과 중앙 기구를 유지하려 노력한다.
그러나 장기전이 이어지면서 백성의 고통이 심화되고, 결국 원과의 화의를 모색하는 흐름으로 이어진다.',
    '몽골 침입기에 최우가 개경에서 천도하여 임시 수도로 삼은 지역.',
    (SELECT country_id FROM country WHERE country_name = '고려')
);

-- 추가 데이터
-- 발해의 수도 (중경 현덕부) (천도)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '중경 현덕부',
    '0742-01-01', -- 무왕 천도 시점(대략)
    '0785-01-01', -- 문왕의 상경 천도 전
    128.800,
    43.800,
    '발해 중경 현덕부 천도',
    '발해 무왕이 기존 수도에서 중경 현덕부로 천도하여 북방 경영의 거점을 강화한다.
새로운 수도를 통해 군사적·행정적 중심을 재편하며 국력 신장에 박차를 가한다.
중경 일대는 주변 지역 통제와 대외 진출을 위한 전략적 교두보 역할을 수행한다.
이후 문왕 때 상경으로 다시 천도되기 전까지 발해의 정치와 군사가 집중되는 핵심 공간이 된다.',
    '발해 무왕이 천도하여 북방 경영과 국력 강화를 도모한 수도.',
    (SELECT country_id FROM country WHERE country_name = '발해')
);

-- 후고구려(태봉)의 초기 수도 (건국 수도, 천도 아님)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '송악(개성)',
    '0901-01-01', -- 궁예 건국 시점
    '0905-01-01', -- 궁예의 철원 천도 시점
    126.560,
    37.970,
    NULL,
    NULL,
    '궁예가 후고구려를 세우고 초기에 도읍으로 삼았던 곳.',
    (SELECT country_id FROM country WHERE country_name = '후고구려(태봉)')
);

-- 왜구 (수도 개념이 아닌 근거지/활동 지역으로 설정)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '쓰시마(대마도)',
    '1350-01-01', -- 왜구 활동 시기 시작
    '1392-12-31', -- 왜구 활동 시기 끝
    129.400,
    34.400,
    NULL,
    NULL,
    '왜구가 고려와 조선을 침입할 때 주요 근거지로 활용했던 섬 지역.',
    (SELECT country_id FROM country WHERE country_name = '왜구')
);

INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '이키(일기도)',
    '1350-01-01', -- 왜구 활동 시기 시작
    '1392-12-31', -- 왜구 활동 시기 끝
    129.900,
    33.800,
    NULL,
    NULL,
    '규슈 북부와 한반도 사이에서 왜구의 활동 거점으로 기능했던 섬 지역.',
    (SELECT country_id FROM country WHERE country_name = '왜구')
);

-- 당(唐)의 수도
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '장안(長安)',
    '0618-01-01', -- 당 건국 시점
    '0907-05-12', -- 당 멸망 시점
    108.940, -- 시안(西安) 대략적 경도
    34.260,  -- 시안(西安) 대략적 위도
    NULL,
    NULL,
    '당나라의 수도로 국제 교역과 문화 교류가 활발히 이루어졌던 도시.',
    (SELECT country_id FROM country WHERE country_name = '당')
);

-- 후백제(後百濟) 초기 수도 (건국 시점)
INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES (
    '무진주(광주)',
    '0892-01-01', -- 후백제 건국 시점
    '0899-12-31', -- 완산주 천도 직전
    126.850, 
    35.150, 
    NULL,
    NULL,
    '견훤이 후백제 건국 초기 거점으로 삼았던 지역.',
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