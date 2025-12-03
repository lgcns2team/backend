-- 데이터 추가 시 id default 설정 필요

ALTER TABLE country
    ALTER COLUMN country_id SET DEFAULT gen_random_uuid();