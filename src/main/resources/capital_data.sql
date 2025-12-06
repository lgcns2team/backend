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

INSERT INTO capital (
    capital_name, started_date, ended_date, longitude, latitude,
    title, description, summary, country_id
) 
VALUES 
-- 1. 송악 (천도 후 ~ 강화도 천도 시점)
(
    '송악(개성)',
    DATE '0919-01-01', 
    DATE '1232-07-01', -- 강화도 천도 시점까지
    126.560,
    37.970,
    '고려 송악 천도 (초기 및 무신정권)',
    '왕건은 궁예를 몰아낸 후 919년에 자신의 기반인 송악(개경)으로 수도를 옮기고 새 왕조의 기틀을 다진다.
개경은 예성강 하구의 벽란도를 통해 상업과 대외 교역의 중심지로 빠르게 성장한다.
문벌 귀족 사회와 무신 정권이 이곳을 중심으로 국정을 운영하며 정치적 중심지 역할을 수행한다.
그러나 13세기 몽골의 침입이 시작되자, 무신 정권은 방어에 유리한 강화도로 천도를 결정하며 잠시 수도의 지위를 잃는다.',
    '고려 건국 후 강화도 천도 직전까지의 수도.',
    (SELECT country_id FROM country WHERE country_name = '고려')
),

-- 2. 개경 (강화도 환도 후 ~ 고려 멸망)
(
    '송악(개성)',
    DATE '1270-05-02', -- 개경 환도 시점 직후
    DATE '1392-07-28', -- 고려 멸망 시점
    126.560,
    37.970,
    '고려 송악 환도 (원 간섭기)',
    '몽골과의 강화 체결 후 고려 조정은 약 40년 만에 임시 수도였던 강화도에서 다시 개경으로 돌아온다.
개경 환도 이후 원나라의 내정 간섭이 본격화되며, 개경은 원 간섭기 동안 권문세족의 중심지가 된다.
국왕인 공민왕은 개경에서 반원 정책을 추진하며 개혁을 시도했으나 권문세족의 저항으로 난항을 겪는다.
개경은 고려가 외세의 압박과 내부 혼란을 겪으며 조선 왕조로 교체될 때까지 수도 역할을 수행한다.',
    '강화도에서 개경 환도 후, 원 간섭기를 거쳐 고려가 멸망할 때까지의 수도.',
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
