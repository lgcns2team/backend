-- 왕 초기 데이터

-- 삼국-고려시대
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


-- 고구려
-- 1대 동명성왕 (주몽) : 건국
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id) 
VALUES ('고주몽', '동명성왕', '0037-01-01 BC', '0019-12-31 BC', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 2대 유리왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id) 
VALUES ('고유리', '유리왕', '0019-01-01 BC', '0018-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 3대 대무신왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고무휼', '대무신왕', '0018-10-01', '0044-11-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 4대 민중왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고해색주', '민중왕', '0044-11-01', '0048-12-31', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 5대 모본왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고해우', '모본왕', '0048-01-01', '0053-11-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 6대 태조왕 (중앙 집권 기틀 마련)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고궁', '태조왕', '0053-11-01', '0146-12-31', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 7대 차대왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고수성', '차대왕', '0146-01-01', '0165-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 8대 신대왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고백고', '신대왕', '0165-10-01', '0179-12-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 9대 고국천왕 (진대법 실시)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고남무', '고국천왕', '0179-12-01', '0197-05-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 10대 산상왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고연우', '산상왕', '0197-05-01', '0227-05-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 11대 동천왕 (서안평 공격)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고우위거', '동천왕', '0227-05-01', '0248-09-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 12대 중천왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고연불', '중천왕', '0248-09-01', '0270-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 13대 서천왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고약로', '서천왕', '0270-10-01', '0292-02-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 14대 봉상왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고상부', '봉상왕', '0292-02-01', '0300-09-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 15대 미천왕 (낙랑군 축출)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고을불', '미천왕', '0300-09-01', '0331-02-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 16대 고국원왕 (백제 근초고왕 침입으로 전사)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고사유', '고국원왕', '0331-02-01', '0371-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 17대 소수림왕 (불교 수용, 태학 설립, 율령 반포)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고구부', '소수림왕', '0371-10-01', '0384-11-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 18대 고국양왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고이련', '고국양왕', '0384-11-01', '0391-05-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 19대 광개토대왕 (영토 대확장, 영락 연호)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고담덕', '광개토대왕', '0391-05-01', '0412-12-31', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 20대 장수왕 (평양 천도, 남진 정책)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고거련', '장수왕', '0413-01-01', '0491-12-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 21대 문자명왕 (최대 영토 확보)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고나운', '문자명왕', '0491-12-01', '0519-12-31', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 22대 안장왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고흥안', '안장왕', '0519-01-01', '0531-05-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 23대 안원왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고보정', '안원왕', '0531-05-01', '0545-03-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 24대 양원왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고평성', '양원왕', '0545-03-01', '0559-02-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 25대 평원왕 (온달 장군 활동 시기)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고양성', '평원왕', '0559-03-01', '0590-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 26대 영양왕 (살수대첩)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고원', '영양왕', '0590-10-01', '0618-09-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 27대 영류왕 (연개소문 정변으로 사망)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고건무', '영류왕', '0618-09-01', '0642-10-01', (SELECT country_id FROM country WHERE country_name = '고구려'));

-- 28대 보장왕 (고구려 멸망)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('고장', '보장왕', '0642-10-01', '0668-09-21', (SELECT country_id FROM country WHERE country_name = '고구려'));


-- 백제
-- 1대 온조왕 (건국)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id) 
VALUES ('부여온조', '온조왕', '0018-01-01 BC', '0028-02-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 2대 다루왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여다루', '다루왕', '0028-02-01', '0077-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 3대 기루왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여기루', '기루왕', '0077-09-01', '0128-11-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 4대 개루왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여개루', '개루왕', '0128-11-01', '0166-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 5대 초고왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여초고', '초고왕', '0166-01-01', '0214-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 6대 구수왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여구수', '구수왕', '0214-01-01', '0234-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 7대 사반왕 (재위 기간이 매우 짧음)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여사반', '사반왕', '0234-01-01', '0234-12-31', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 8대 고이왕 (율령 반포, 관등제 정비)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여고이', '고이왕', '0234-01-01', '0286-11-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 9대 책계왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여책계', '책계왕', '0286-11-01', '0298-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 10대 분서왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여분서', '분서왕', '0298-09-01', '0304-10-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 11대 비류왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여비류', '비류왕', '0304-10-01', '0344-10-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 12대 계왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여계', '계왕', '0344-10-01', '0346-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 13대 근초고왕 (최전성기, 마한 정복, 고구려 공격)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여구', '근초고왕', '0346-09-01', '0375-11-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 14대 근구수왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여수', '근구수왕', '0375-11-01', '0384-04-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 15대 침류왕 (불교 공인)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여침류', '침류왕', '0384-04-01', '0385-11-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 16대 진사왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여진사', '진사왕', '0385-11-01', '0392-11-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 17대 아신왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여아신', '아신왕', '0392-11-01', '0405-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 18대 전지왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여영', '전지왕', '0405-09-01', '0420-03-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 19대 구이신왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여구이신', '구이신왕', '0420-03-01', '0427-12-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 20대 비유왕 (나제동맹 체결)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여비유', '비유왕', '0427-12-01', '0455-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 21대 개로왕 (고구려 장수왕 침입으로 전사)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여경', '개로왕', '0455-09-01', '0475-09-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 22대 문주왕 (웅진 천도)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여모도', '문주왕', '0475-10-01', '0477-04-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 23대 삼근왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여삼근', '삼근왕', '0477-04-01', '0479-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 24대 동성왕 (신라와 결혼 동맹)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여모대', '동성왕', '0479-01-01', '0501-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 25대 무령왕 (22담로 설치, 중흥기)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여사마', '무령왕', '0501-01-01', '0523-05-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 26대 성왕 (사비 천도, 국호 남부여 개칭, 관산성 전투 전사)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여명농', '성왕', '0523-05-01', '0554-07-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 27대 위덕왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여창', '위덕왕', '0554-07-01', '0598-12-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 28대 혜왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여계', '혜왕', '0598-12-01', '0599-01-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 29대 법왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여선', '법왕', '0599-01-01', '0600-05-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 30대 무왕 (익산 미륵사 건립)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여장', '무왕', '0600-05-01', '0641-03-01', (SELECT country_id FROM country WHERE country_name = '백제'));

-- 31대 의자왕 (백제 멸망)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('부여의자', '의자왕', '0641-03-01', '0660-07-18', (SELECT country_id FROM country WHERE country_name = '백제'));


-- 신라
-- 1대 박혁거세 (거서간) : 기원전 57년 건국
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id) 
VALUES ('박혁거세', '혁거세 거서간', '0057-04-01 BC', '0004-03-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 2대 남해 (차차웅)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박남해', '남해 차차웅', '0004-03-01', '0024-10-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 3대 유리 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박유리', '유리 이사금', '0024-10-01', '0057-10-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 4대 탈해 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석탈해', '탈해 이사금', '0057-10-01', '0080-08-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 5대 파사 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박파사', '파사 이사금', '0080-08-01', '0112-10-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 6대 지마 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박지마', '지마 이사금', '0112-10-01', '0134-08-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 7대 일성 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박일성', '일성 이사금', '0134-08-01', '0154-02-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 8대 아달라 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박아달라', '아달라 이사금', '0154-02-01', '0184-03-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 9대 벌휴 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석벌휴', '벌휴 이사금', '0184-03-01', '0196-06-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 10대 내해 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석내해', '내해 이사금', '0196-06-01', '0230-03-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 11대 조분 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석조분', '조분 이사금', '0230-03-01', '0247-05-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 12대 첨해 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석첨해', '첨해 이사금', '0247-05-01', '0261-12-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 13대 미추 (이사금) : 김씨 최초의 왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김미추', '미추 이사금', '0262-01-01', '0284-10-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 14대 유례 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석유례', '유례 이사금', '0284-10-01', '0298-12-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 15대 기림 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석기림', '기림 이사금', '0298-12-01', '0310-06-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 16대 흘해 (이사금)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('석흘해', '흘해 이사금', '0310-06-01', '0356-04-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 17대 내물 (마립간) : 마립간 칭호 사용 시작
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김내물', '내물 마립간', '0356-04-01', '0402-02-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 18대 실성 (마립간)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김실성', '실성 마립간', '0402-02-01', '0417-05-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 19대 눌지 (마립간)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김눌지', '눌지 마립간', '0417-05-01', '0458-08-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 20대 자비 (마립간)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김자비', '자비 마립간', '0458-08-01', '0479-02-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 21대 소지 (마립간)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김소지', '소지 마립간', '0479-02-01', '0500-11-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 22대 지증왕 : 국호를 신라로 확정, 왕 칭호 사용
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김지대로', '지증왕', '0500-11-01', '0514-07-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 23대 법흥왕 : 불교 공인
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김원종', '법흥왕', '0514-07-01', '0540-07-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 24대 진흥왕 : 전성기, 한강 유역 차지
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김삼맥종', '진흥왕', '0540-07-01', '0576-08-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 25대 진지왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김금륜', '진지왕', '0576-08-01', '0579-07-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 26대 진평왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김백정', '진평왕', '0579-07-01', '0632-01-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 27대 선덕여왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김덕만', '선덕여왕', '0632-01-01', '0647-01-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 28대 진덕여왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김승만', '진덕여왕', '0647-01-01', '0654-03-01', (SELECT country_id FROM country WHERE country_name = '신라'));

-- 29대 태종 무열왕 : 삼국 통일의 기틀 마련
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김춘추', '태종 무열왕', '0654-04-01', '0661-06-01', (SELECT country_id FROM country WHERE country_name = '신라'));



-- 통일 신라 (668년 이후)
-- 30대 문무왕 (삼국 통일 완성)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김법민', '문무왕', '0661-07-01', '0681-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 31대 신문왕 (전제 왕권 강화, 9주 5소경)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김정명', '신문왕', '0681-07-02', '0692-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 32대 효소왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김이홍', '효소왕', '0692-07-02', '0702-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 33대 성덕왕 (전성기)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김흥광', '성덕왕', '0702-07-02', '0737-02-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 34대 효성왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김승경', '효성왕', '0737-02-02', '0742-05-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 35대 경덕왕 (불국사, 석굴암 건립)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김헌영', '경덕왕', '0742-05-02', '0765-06-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 36대 혜공왕 (피살됨, 신라 중대 종료)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김건운', '혜공왕', '0765-06-02', '0780-04-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 37대 선덕왕 (내물왕계 김양상 즉위, 신라 하대 시작)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김양상', '선덕왕', '0780-04-02', '0785-01-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 38대 원성왕 (독서삼품과 실시)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김경신', '원성왕', '0785-02-01', '0798-12-29', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 39대 소성왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김준옹', '소성왕', '0799-01-01', '0800-06-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 40대 애장왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김청명', '애장왕', '0800-06-02', '0809-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 41대 헌덕왕 (김헌창의 난 진압)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김언승', '헌덕왕', '0809-07-02', '0826-10-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 42대 흥덕왕 (장보고 청해진 설치)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김수종', '흥덕왕', '0826-10-02', '0836-12-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 43대 희강왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김제륭', '희강왕', '0836-12-02', '0838-01-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 44대 민애왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김명', '민애왕', '0838-01-02', '0839-01-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 45대 신무왕 (장보고의 도움으로 즉위)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김우징', '신무왕', '0839-04-01', '0839-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 46대 문성왕 (장보고 암살)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김경응', '문성왕', '0839-07-02', '0857-09-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 47대 헌안왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김의정', '헌안왕', '0857-09-02', '0861-01-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 48대 경문왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김응렴', '경문왕', '0861-01-02', '0875-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 49대 헌강왕 (처용무 관련 설화)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김정', '헌강왕', '0875-07-02', '0886-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 50대 정강왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김황', '정강왕', '0886-07-02', '0887-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 51대 진성여왕 (원종·애노의 난, 최치원 시무 10조)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김만', '진성여왕', '0887-07-02', '0897-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 52대 효공왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김요', '효공왕', '0897-07-02', '0912-04-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 53대 신덕왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박경휘', '신덕왕', '0912-04-02', '0917-07-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 54대 경명왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박승영', '경명왕', '0917-07-02', '0924-08-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 55대 경애왕 (후백제 견훤의 침입으로 사망)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('박위응', '경애왕', '0924-08-02', '0927-11-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));

-- 56대 경순왕 (고려에 항복, 신라 멸망)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('김부', '경순왕', '0927-11-02', '0935-11-01', (SELECT country_id FROM country WHERE country_name = '통일 신라'));


-- 발해 

-- 1대 고왕 (대조영)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대조영', '고왕', '0698-01-01', '0719-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 2대 무왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대무예', '무왕', '0719-01-01', '0737-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 3대 문왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대흠무', '문왕', '0737-01-01', '0793-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 4대 대원의 (시호 없음/폐왕)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대원의', '대원의', '0793-01-01', '0793-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 5대 성왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대화여', '성왕', '0793-01-01', '0794-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 6대 강왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대숭린', '강왕', '0794-01-01', '0809-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 7대 정왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대원유', '정왕', '0809-01-01', '0812-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 8대 희왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대언의', '희왕', '0812-01-01', '0817-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 9대 간왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대명충', '간왕', '0817-01-01', '0818-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 10대 선왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대인수', '선왕', '0818-01-01', '0830-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 11대 대이진 (시호 불명)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대이진', '대이진', '0830-01-01', '0857-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 12대 대건황 (시호 불명)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대건황', '대건황', '0857-01-01', '0871-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 13대 대현석 (시호 불명/경왕 추정)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대현석', '대현석', '0871-01-01', '0894-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 14대 대위해 (시호 불명)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대위해', '대위해', '0894-01-01', '0906-12-31', (SELECT country_id FROM country WHERE country_name = '발해'));

-- 15대 대인선 (마지막 왕/애왕 추정)
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('대인선', '대인선', '0906-01-01', '0926-01-15', (SELECT country_id FROM country WHERE country_name = '발해'));


-- 고려 

-- 1대 태조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕건', '태조', '0918-07-25', '0943-07-04', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 2대 혜종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕무', '혜종', '0943-07-05', '0945-10-23', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 3대 정종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕요', '정종', '0945-10-23', '0949-04-13', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 4대 광종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕소', '광종', '0949-04-13', '0975-07-04', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 5대 경종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕주', '경종', '0975-07-04', '0981-08-13', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 6대 성종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕치', '성종', '0981-08-29', '0997-11-29', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 7대 목종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕송', '목종', '0997-11-29', '1009-03-02', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 8대 현종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕순', '현종', '1009-03-02', '1031-06-17', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 9대 덕종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕흠', '덕종', '1031-06-18', '1034-10-31', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 10대 정종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕형', '정종', '1034-11-23', '1046-06-24', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 11대 문종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕휘', '문종', '1046-06-24', '1083-09-02', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 12대 순종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕훈', '순종', '1083-09-02', '1083-12-05', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 13대 선종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕운', '선종', '1083-12-05', '1094-06-17', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 14대 헌종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕욱', '헌종', '1094-06-17', '1095-12-09', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 15대 숙종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕옹', '숙종', '1095-12-09', '1105-11-10', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 16대 예종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕우', '예종', '1105-11-20', '1122-05-15', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 17대 인종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕해', '인종', '1122-05-15', '1146-04-10', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 18대 의종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕현', '의종', '1146-04-10', '1170-10-18', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 19대 명종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕호', '명종', '1170-10-20', '1197-10-27', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 20대 신종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕탁', '신종', '1197-10-28', '1204-02-15', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 21대 희종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕영', '희종', '1204-02-15', '1211-12-25', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 22대 강종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕오', '강종', '1211-12-25', '1213-08-26', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 23대 고종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕철', '고종', '1213-09-01', '1259-07-21', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 24대 원종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕전', '원종', '1260-04-17', '1274-07-23', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 25대 충렬왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕거', '충렬왕', '1274-08-22', '1308-08-27', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 26대 충선왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕장', '충선왕', '1308-08-27', '1313-04-20', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 27대 충숙왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕도', '충숙왕', '1313-04-20', '1339-05-02', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 28대 충혜왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕정', '충혜왕', '1339-05-02', '1344-02-17', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 29대 충목왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕흔', '충목왕', '1344-02-18', '1348-12-25', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 30대 충정왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕저', '충정왕', '1349-01-01', '1351-11-23', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 31대 공민왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕전', '공민왕', '1351-12-05', '1374-10-27', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 32대 우왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕우', '우왕', '1374-10-27', '1388-06-09', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 33대 창왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕창', '창왕', '1388-06-09', '1389-11-15', (SELECT country_id FROM country WHERE country_name = '고려'));

-- 34대 공양왕
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('왕요', '공양왕', '1389-11-15', '1392-07-12', (SELECT country_id FROM country WHERE country_name = '고려'));


-- 조선시대
-- 1대 태조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이성계', '태조', '1392-07-17', '1398-10-14', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 2대 정종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이경', '정종', '1398-10-14', '1400-11-13', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 3대 태종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이방원', '태종', '1400-11-13', '1418-09-09', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 4대 세종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이도', '세종', '1418-09-09', '1450-02-17', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 5대 문종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이향', '문종', '1450-02-17', '1452-06-01', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 6대 단종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이홍위', '단종', '1452-06-01', '1455-07-25', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 7대 세조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이유', '세조', '1455-07-25', '1468-09-23', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 8대 예종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이황', '예종', '1468-09-23', '1469-12-31', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 9대 성종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이혈', '성종', '1469-12-31', '1494-12-24', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 10대 연산군
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이융', '연산군', '1494-12-25', '1506-09-18', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 11대 중종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이역', '중종', '1506-09-18', '1544-11-29', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 12대 인종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이호', '인종', '1544-11-29', '1545-08-07', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 13대 명종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이환', '명종', '1545-08-08', '1567-08-02', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 14대 선조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이연', '선조', '1567-08-03', '1608-03-16', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 15대 광해군
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이혼', '광해군', '1608-03-17', '1623-04-12', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 16대 인조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이종', '인조', '1623-04-13', '1649-05-08', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 17대 효종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이호', '효종', '1649-05-09', '1659-06-23', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 18대 현종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이연', '현종', '1659-06-23', '1674-09-17', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 19대 숙종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이순', '숙종', '1674-09-22', '1720-07-12', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 20대 경종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이윤', '경종', '1720-07-17', '1724-10-11', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 21대 영조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이금', '영조', '1724-10-16', '1776-03-05', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 22대 정조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이산', '정조', '1776-03-10', '1800-08-18', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 23대 순조
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이공', '순조', '1800-08-18', '1834-12-03', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 24대 헌종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이환', '헌종', '1834-12-08', '1849-07-25', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 25대 철종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이변', '철종', '1849-07-28', '1864-01-16', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 26대 고종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이희', '고종', '1863-12-13', '1907-07-19', (SELECT country_id FROM country WHERE country_name = '조선'));

-- 27대 순종
INSERT INTO king (king_name, regnal_name, started_date, ended_date, country_id)
VALUES ('이척', '순종', '1907-07-19', '1910-08-29', (SELECT country_id FROM country WHERE country_name = '조선'));