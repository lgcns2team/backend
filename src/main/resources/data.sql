-- Capital 데이터 삽입

-- 금성(경주) - 신라
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('금성(경주)', NULL, NULL, 129.224, 35.856, '신라의 천년 고도. 혜공왕 피살 이후 왕위 다툼이 치열했던 곳.', (SELECT country_id FROM Country WHERE country_name = '신라'));

-- 상경 용천부 - 발해
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('상경 용천부', NULL, NULL, 129.150, 44.120, '발해 문왕 때 천도한 수도. 당의 장안성을 본떠 건설됨.', (SELECT country_id FROM Country WHERE country_name = '발해'));

-- 완산주(전주) - 후백제
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('완산주(전주)', NULL, NULL, 127.148, 35.824, '견훤이 900년에 건국하여 도읍으로 삼은 곳.', (SELECT country_id FROM Country WHERE country_name = '후백제'));

-- 송악(개성) - 고려
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('송악(개성)', NULL, NULL, 126.560, 37.970, '고려의 수도. 왕건이 철원에서 이곳으로 천도함.', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 철원 - 후고구려
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('철원', NULL, NULL, 127.200, 38.270, '궁예가 송악에서 천도하여 태봉이라는 국호를 사용했던 도읍.', (SELECT country_id FROM Country WHERE country_name = '후고구려'));

-- 강화도 - 고려 임시 수도
INSERT INTO Capital (capital_name, started_date, ended_date, longitude, latitude, description, country_id) 
VALUES ('강화도', NULL, NULL, 126.485, 37.746, '몽골 침입 시기 최우가 천도한 임시 수도(1232~1270).', (SELECT country_id FROM Country WHERE country_name = '고려'));


-- King 데이터 삽입

-- 견훤 (후백제)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_001', '견훤', '견훤왕', '0900-01-01', '0935-03-01', (SELECT country_id FROM Country WHERE country_name = '후백제'));

-- 신검 (후백제)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_002', '신검', '신검왕', '0935-03-01', '0936-09-01', (SELECT country_id FROM Country WHERE country_name = '후백제'));

-- 궁예 (후고구려)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_003', '궁예', '궁예왕', '0901-01-01', '0918-06-15', (SELECT country_id FROM Country WHERE country_name = '후고구려'));

-- 왕건 (고려 태조)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_004', '왕건', '태조', '0918-06-15', '0943-07-04', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 김만 (신라 진성여왕)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_005', '김만', '진성여왕', '0887-07-05', '0897-07-06', (SELECT country_id FROM Country WHERE country_name = '신라'));

-- 김부 (신라 경순왕)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_006', '김부', '경순왕', '0927-11-01', '0935-11-01', (SELECT country_id FROM Country WHERE country_name = '신라'));

-- 대인수 (발해 선왕)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_007', '대인수', '선왕', '0818-01-01', '0830-12-31', (SELECT country_id FROM Country WHERE country_name = '발해'));

-- 왕소 (고려 광종)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_008', '왕소', '광종', '0949-04-13', '0975-07-04', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 왕치 (고려 성종)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_009', '왕치', '성종', '0981-07-01', '0997-11-29', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 왕순 (고려 현종)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_010', '왕순', '현종', '1009-03-02', '1031-06-17', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 왕해 (고려 인종)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_011', '왕해', '인종', '1122-05-15', '1146-04-10', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 왕철 (고려 고종)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_012', '왕철', '고종', '1213-09-01', '1259-07-20', (SELECT country_id FROM Country WHERE country_name = '고려'));

-- 왕전 (고려 공민왕)
INSERT INTO King (king_id, king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('KING_013', '왕전', '공민왕', '1351-12-01', '1374-10-22', (SELECT country_id FROM Country WHERE country_name = '고려'));
