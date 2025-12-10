-- 전쟁 초기 데이터
-- 후삼국 통일 전쟁 (WAR_TK)
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 1. 후삼국 통일 전쟁
    '후삼국 통일 전쟁',
    '신라 말기 왕건이 고려를 건국하면서 후백제, 신라와 대립하며 벌인 약 18년간의 민족 통합 전쟁이다. 이 전쟁은 고창 전투와 운주성 전투 등 주요 전투를 거치며 고려 쪽으로 세력의 추가 기울게 한다. 왕건은 신라에 대해 유화적인 정책을 펴서 평화적으로 신라를 흡수한다. 마지막에는 후백제의 내분과 일리천 전투의 승리를 통해 최종적으로 후삼국을 통일하며 고려 왕조의 기틀을 마련한다.',
    DATE '0918-06-15',
    DATE '0936-09-01',
    '고려 승리, 후삼국 통일',
    '고창 전투와 일리천 전투에서 승리하여 신라 항복과 후백제 멸망을 통해 민족 재통합을 완성함.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '후백제'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '후백제')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 2. 여요전쟁 (거란 침입)
    '여요전쟁(거란 침입)',
    '거란(요나라)이 송나라와의 관계 단절 등을 요구하며 고려를 세 차례에 걸쳐 대규모로 침략한 전쟁이다. 1차 침입 시 서희가 외교 담판을 통해 오히려 강동 6주를 확보하여 고려의 영토를 확장하는 성과를 얻는다. 2차 침입 때는 현종이 피난하는 등 위기를 겪지만 양규 등의 활약으로 거란군을 격퇴한다. 마지막 3차 침입에서는 강감찬 장군이 귀주에서 거란의 주력군을 궤멸시키는 대승을 거두어 전쟁을 최종적으로 종결시킨다.',
    DATE '0993-10-01',
    DATE '1019-02-01',
    '고려 승리, 강동 6주 확보',
    '1차 침입 때 서희의 외교 담판으로 강동 6주를 확보하고, 3차 침입 때 강감찬이 귀주에서 거란군을 대파하여 평화를 이룸.',
    (SELECT country_id FROM country WHERE country_name = '요(거란)'), -- 780년 이전 건국 거란이 아닌, 요나라 건국 후의 전쟁이므로 '요(거란)'으로 수정
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '요(거란)')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 3. 여진 정벌
    '여진 정벌',
    '고려 북방에서 세력을 키우던 여진족을 제압하기 위해 숙종과 예종 시기에 추진된 군사 작전이다. 고려는 기병에 대응하기 위해 윤관의 건의에 따라 별무반을 창설한다. 별무반을 이끈 윤관은 대규모 정벌을 감행하여 여진족을 몰아내고 동북 9성을 축조하는 데 성공한다. 그러나 여진족의 끈질긴 공세와 9성 방어의 어려움 때문에 고려는 결국 여진에게 9성을 돌려주고 전쟁을 마무리한다.',
    DATE '1104-02-01',
    DATE '1109-06-01',
    '고려 부분적 승리 후 9성 반환',
    '기병 중심 별무반으로 여진을 압박해 동북 9성을 축조했으나 방어의 어려움으로 결국 여진에게 돌려줌.',
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    (SELECT country_id FROM country WHERE country_name = '고려'), -- 9성 축조 성공했으나 결국 반환하여 '부분적 승리'로 해석
    (SELECT country_id FROM country WHERE country_name = '여진')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 4. 여몽전쟁(대몽항쟁)
    '여몽전쟁(대몽항쟁)',
    '몽골 사신 피살 사건을 계기로 시작된 몽골의 침략에 맞서 고려가 약 40여 년간 치른 항쟁이다. 몽골의 강력한 군사력에 맞서 고려 조정은 강화도로 천도하여 장기 항전을 벌인다. 김윤후의 처인성 전투와 충주성 항전처럼 민관군이 함께 저항하는 모습을 보인다. 최씨 무신 정권이 붕괴된 후 몽골과의 강화가 체결되면서 전쟁이 종결된다. 그러나 삼별초는 이에 불복하고 진도와 제주도에서 항쟁을 이어가며 마지막까지 자주 의지를 드러낸다.',
    DATE '1231-08-01',
    DATE '1270-05-01',
    '고려가 몽골과 강화 체결 후 원 간섭기 시작',
    '귀주성·처인성·충주성 등에서 항전했으나 국토가 황폐화되고 결국 몽골과 강화하여 개경으로 환도, 이후 원 간섭기가 전개됨.',
    (SELECT country_id FROM country WHERE country_name = '몽골 제국'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '몽골 제국'), -- 강화 체결 및 원 간섭기 시작은 사실상 몽골의 승리로 해석
    (SELECT country_id FROM country WHERE country_name = '고려')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 5. 홍건적의 난
    '홍건적의 난',
    '원나라 말기 혼란 속에서 등장한 한족 반란군인 홍건적이 고려의 영토를 침범한 사건이다. 1차 침입 때 서경(평양)까지 함락시키며 큰 피해를 입힌다. 2차 침입 때는 홍건적이 수도인 개경을 점령하고 공민왕이 복주(안동)까지 피난하는 위기를 초래한다. 그러나 고려는 이성계, 최영 등의 장수들을 중심으로 대규모 반격 작전을 펼친다. 결국 개경을 탈환하고 홍건적을 완전히 격퇴하여 국가의 안정을 되찾는다.',
    DATE '1359-12-01',
    DATE '1362-01-31',
    '고려 승리, 개경 탈환',
    '홍건적이 개경을 함락했으나 이성계·정세운·최영 등의 활약으로 수도를 탈환하고 홍건적을 격퇴함.',
    (SELECT country_id FROM country WHERE country_name = '원'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '원')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 6. 여일전쟁(왜구 토벌)
    '여일전쟁(왜구 토벌)',
    '고려 후기 일본에서 넘어온 해적 집단인 왜구가 해안과 내륙 깊숙한 곳까지 침입하여 약탈을 일삼아 국가를 위기에 빠뜨린 사건에 대한 대응 전쟁이다. 고려는 최영, 이성계, 최무선 등 뛰어난 장수들을 중심으로 대대적인 왜구 토벌 작전을 전개한다. 최무선이 발명한 화포를 사용한 진포 대첩에서 왜선 500여 척을 격침시키며 해상 방어력을 입증한다. 또한 이성계는 황산 대첩에서 왜구 주력을 크게 격파하는 등 큰 승리를 거두어 왜구의 세력을 약화시킨다.',
    DATE '1350-01-01',
    DATE '1389-02-28',
    '고려 승리, 왜구 세력 약화',
    '진포 대첩에서 화포를 사용해 왜선을 격침하고, 황산 대첩 등에서 왜구 주력을 크게 격파하여 해상 방어력을 강화함.',
    (SELECT country_id FROM country WHERE country_name = '왜구'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '왜구')
);

---
INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 11. 임진왜란
    '임진왜란',
    '일본 도요토미 히데요시가 대륙 침략을 구실로 조선을 침략하여 7년간 이어진 전쟁이다. 일본군은 초반에 한양과 평양을 점령하며 파죽지세로 북상했다. 그러나 이순신의 한산도 대첩과 명량 해전에서 수군이 제해권을 장악하고, 권율의 행주 대첩과 전국 각지의 의병 활약으로 전세가 역전되었다. 명나라의 지원군이 참전하면서 조·명 연합군이 일본군을 물리쳤으나, 전쟁으로 국토가 황폐화되고 많은 인명 피해가 발생했다.',
    DATE '1592-04-13',
    DATE '1598-11-19',
    '조·명 연합군의 승리',
    '수군의 제해권 장악과 의병의 활약으로 일본군을 물리쳤으나 국토가 황폐화됨.',
    (SELECT country_id FROM country WHERE country_name = '일본'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '일본')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 14. 정묘호란
    '정묘호란',
    '인조의 친명배금 정책에 반발하여 후금(청)이 침입한 전쟁이다. 광해군을 몰아낸 인조가 친명 정책을 펼치자, 후금은 이에 반발하여 조선을 침략했다. 조선은 강화도로 피란하고 평안도 일대에서 의병이 활약했다. 후금의 내부 사정으로 전쟁이 장기화되지 않았고, 형제 관계를 맺는 조건으로 화의가 성립되었다.',
    DATE '1627-01-13',
    DATE '1627-03-03',
    '형제 관계 체결',
    '의병의 항전과 후금의 사정으로 형제 관계를 맺고 화의함.',
    (SELECT country_id FROM country WHERE country_name = '후금'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '후금'),
    (SELECT country_id FROM country WHERE country_name = '조선')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 15. 병자호란
    '병자호란',
    '국호를 청으로 바꾼 후금이 군신 관계를 요구하며 재침략한 전쟁이다. 청 태종이 직접 10만 대군을 이끌고 조선을 침략했고, 인조는 남한산성으로 피란했다. 45일간의 항전 끝에 식량과 탄약이 떨어지자, 인조는 삼전도에서 청 태종에게 무릎을 꿇고 굴욕적인 항복을 했다. 이후 조선은 청에 대한 군신 관계를 맺고 소현세자와 봉림대군을 인질로 보냈다.',
    DATE '1636-12-09',
    DATE '1637-01-30',
    '청의 승리',
    '남한산성 항전 끝에 인조가 삼전도에서 굴욕적인 항복을 함.',
    (SELECT country_id FROM country WHERE country_name = '청'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '청'),
    (SELECT country_id FROM country WHERE country_name = '조선')
);

-- 분류용 가상 전쟁: 기타/미분류 전쟁 (날짜 범위를 넓게 설정하여 모든 연도에서 전투 표시)
INSERT INTO war (
    name, description, war_start_date, war_end_date,
    result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    '기타/미분류 전쟁',
    '특정 전쟁에 분류되지 않은 개별 전투들을 포함하는 가상 전쟁 카테고리',
    DATE '0001-01-01',
    DATE '1910-12-31',
    NULL,
    NULL,
    (SELECT country_id FROM country WHERE country_name = '기타/미분류 국가'),
    (SELECT country_id FROM country WHERE country_name = '기타/미분류 국가'),
    (SELECT country_id FROM country WHERE country_name = '기타/미분류 국가'),
    (SELECT country_id FROM country WHERE country_name = '기타/미분류 국가')
);
