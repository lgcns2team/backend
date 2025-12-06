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