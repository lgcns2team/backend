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
    (SELECT country_id FROM country WHERE country_name = '홍건적'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '고려'),
    (SELECT country_id FROM country WHERE country_name = '홍건적')
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
    -- 7. 쓰시마 정벌
    '쓰시마 정벌',
    '세종 원년, 이종무가 병선 227척을 이끌고 왜구의 근거지인 대마도를 선제 타격한 사건이다. 조선 초기 왜구의 침입이 계속되자 근본적인 해결을 위해 대마도를 직접 공격했다. 이종무는 대마도의 왜구 소굴을 소탕하고 대마도주의 항복을 받아내어 조선에 대한 왜구의 침입을 크게 줄였다. 이 정벌을 통해 조선은 대마도와의 무역 관계를 정립하고 변경의 평화를 확보했다.',
    DATE '1419-06-19',
    DATE '1419-07-03',
    '조선의 승리',
    '왜구의 소굴을 소탕하고 대마도주의 항복을 받아내어 평화를 확보함.',
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '대마도'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '대마도')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 8. 4군 6진 개척
    '4군 6진 개척',
    '세종 때 최윤덕, 김종서가 여진족을 몰아내고 압록강·두만강 유역을 개척한 전쟁이다. 북방의 여진족이 조선 국경을 침범하자, 조선은 최윤덕을 보내 압록강 유역에 4군을 설치하고, 김종서를 보내 두만강 유역에 6진을 개척했다. 이 전쟁을 통해 조선은 여진족을 토벌하고 오늘날 한반도의 국경선을 확립하는 중요한 기반을 마련했다.',
    DATE '1433-01-01',
    DATE '1449-12-31',
    '국경선 확정',
    '여진족을 토벌하고 4군과 6진을 설치하여 오늘날 한반도의 국경선을 확립함.',
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '여진'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '여진')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 9. 이시애의 난
    '이시애의 난',
    '세조의 집권 강화 정책과 지역 차별에 반발하여 함경도 호족 이시애가 일으킨 반란이다. 세조의 중앙집권 정책으로 함경도 지역의 특권이 축소되자, 이시애는 북방 방어 주력군을 이끌고 반란을 일으켰다. 이시애는 함경도 일대를 장악했으나, 남이와 강순 등 조선군의 진압으로 실패했다. 이 반란은 조선 초기 중앙집권 체제 확립 과정에서 발생한 지방 세력의 마지막 저항으로 평가된다.',
    DATE '1467-05-01',
    DATE '1467-08-12',
    '관군의 승리',
    '북방 방어 주력군이 반란을 일으켰으나 남이, 강순 등이 진압함.',
    (SELECT country_id FROM country WHERE country_code = 26), -- 반란군 (country_code 26으로 가정)
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_code = 26) -- 반란군
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 10. 을묘왜변
    '을묘왜변',
    '명종 때 왜선 70여 척이 전남 영암, 강진 등 해안가를 대규모로 침략한 사건이다. 왜구는 전라도 연안을 습격하며 달량진성을 포위하는 등 큰 피해를 입혔다. 전주부윤 이윤경과 조선군이 달량진성을 지키며 왜구를 격퇴했다. 이 사건 이후 조선은 수군 강화와 해안 방어 체계를 정비하는 계기를 마련했다.',
    DATE '1555-05-11',
    DATE '1555-05-27',
    '조선의 승리',
    '달량진성이 포위되었으나 전주부윤 이윤경 등이 격퇴함.',
    (SELECT country_id FROM country WHERE country_name = '왜구'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
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
    -- 12. 사르후 전투
    '사르후 전투',
    '명의 요청으로 강홍립이 이끄는 조선군이 파병되어 후금(청)과 싸운 국제전이다. 명나라가 후금을 공격하면서 조선에 원군을 요청했고, 광해군은 명과의 관계를 고려하여 강홍립을 파병했다. 그러나 사르후 전투에서 조·명 연합군이 후금에게 대패했고, 강홍립은 후금에 투항했다. 이 패배는 광해군의 중립외교 정책 배경이 되었다.',
    DATE '1619-03-01',
    DATE '1619-03-05',
    '후금의 승리',
    '조·명 연합군이 후금에게 대패하고 강홍립은 투항함 (광해군 중립외교 배경).',
    (SELECT country_id FROM country WHERE country_name = '후금'),
    (SELECT country_id FROM country WHERE country_code = 27), -- 명(조선지원) (country_code 27로 가정)
    (SELECT country_id FROM country WHERE country_name = '후금'),
    (SELECT country_id FROM country WHERE country_code = 27) -- 명(조선지원)
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 13. 이괄의 난
    '이괄의 난',
    '인조반정 논공행상에 불만을 품은 이괄이 일으킨 반란으로, 수도가 점령된 유일한 반란이다. 인조반정의 1등 공신 이괄이 논공행상에 불만을 품고 반란을 일으켜 한양을 점령했다. 인조는 공주로 피란했으나, 안현 전투에서 관군이 반란군을 격파하며 난을 진압했다. 이 반란은 인조 정권의 정통성에 큰 타격을 주었다.',
    DATE '1624-01-22',
    DATE '1624-02-15',
    '관군의 승리',
    '반란군이 한양을 점령하여 인조가 공주로 피란했으나 안현 전투 후 진압됨.',
    (SELECT country_id FROM country WHERE country_code = 28), -- 반란군 (country_code 28로 가정)
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_code = 28) -- 반란군
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

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 16. 홍경래의 난
    '홍경래의 난',
    '평안도 지역 차별과 세도 정치의 수탈에 반발하여 홍경래가 일으킨 농민 봉기이다. 평안도 지역은 조선 시대 내내 차별을 받아왔고, 세도 정치 시기 탐관오리의 수탈이 극심해지자 홍경래가 농민과 광산 노동자를 이끌고 봉기했다. 반란군은 청천강 이북을 장악하고 정주성을 거점으로 삼았으나, 관군의 대대적인 공세로 정주성이 함락되며 진압되었다.',
    DATE '1811-12-18',
    DATE '1812-04-19',
    '관군의 승리',
    '청천강 이북을 장악했으나 정주성 전투 패배로 진압됨.',
    (SELECT country_id FROM country WHERE country_code = 29), -- 농민군 (country_code 29로 가정)
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_code = 29) -- 농민군
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 17. 병인양요
    '병인양요',
    '천주교 탄압을 구실로 프랑스 함대가 강화도를 침범한 사건이다. 흥선대원군의 천주교 탄압으로 프랑스 선교사들이 처형되자, 프랑스는 이를 구실로 군함을 이끌고 강화도를 공격했다. 조선군은 정족산성에서 프랑스군을 격퇴하는 데 성공했으나, 외규장각 도서를 약탈당하는 피해를 입었다.',
    DATE '1866-09-18',
    DATE '1866-11-11',
    '조선의 승리',
    '정족산성에서 프랑스군을 격퇴했으나 외규장각 도서가 약탈됨.',
    (SELECT country_id FROM country WHERE country_name = '프랑스'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '프랑스')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 18. 신미양요
    '신미양요',
    '제너럴 셔먼호 사건을 구실로 미국 함대가 강화도를 침범한 사건이다. 제너럴 셔먼호가 평양 대동강에서 통상을 요구하다 불태워지자, 미국은 이를 구실로 군함을 이끌고 강화도를 공격했다. 광성보에서 어재연 장군이 이끄는 조선군이 결사항전했으나 전멸했고, 미군은 전략적 목표를 달성하지 못하고 결국 철수했다.',
    DATE '1871-06-01',
    DATE '1871-06-11',
    '조선의 수비',
    '광성보에서 어재연 장군이 결사항전하였고 미군은 결국 철수함.',
    (SELECT country_id FROM country WHERE country_name = '미국'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '미국')
);

---

INSERT INTO war (
    name, description, war_start_date, war_end_date, result, summary,
    attack_country_id, defence_country_id, winner_country_id, loser_country_id
) VALUES (
    -- 19. 동학농민혁명
    '동학농민혁명',
    '반봉건·반외세를 기치로 일어난 대규모 농민 항쟁이다. 전봉준을 중심으로 한 동학농민군은 탐관오리의 수탈과 외세의 침략에 저항하여 봉기했다. 농민군은 전주성을 점령하고 전주화약을 체결하여 폐정 개혁을 추진했으나, 일본군이 개입하고 관군의 공세가 이어지면서 우금치 전투에서 패배하며 진압되었다. 이 혁명은 조선 사회의 모순을 드러냈고, 근대화 운동의 선구적 역할을 했다.',
    DATE '1894-01-10',
    DATE '1894-12-05',
    '관군/일본군 승리',
    '전주화약 이후 2차 봉기에서 일본군 개입으로 우금치에서 패배함.',
    (SELECT country_id FROM country WHERE country_name = '동학농민군'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '조선'),
    (SELECT country_id FROM country WHERE country_name = '동학농민군')
);