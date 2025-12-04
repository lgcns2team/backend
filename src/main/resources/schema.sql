-- 데이터 추가 시 id default 설정 필요

ALTER TABLE country
    ALTER COLUMN country_id SET DEFAULT gen_random_uuid();

ALTER TABLE main_event
    ALTER COLUMN event_id SET DEFAULT gen_random_uuid();
ALTER TABLE war
    ALTER COLUMN war_id SET DEFAULT gen_random_uuid();

ALTER TABLE battle
    ALTER COLUMN battle_id SET DEFAULT gen_random_uuid();

ALTER TABLE king
    ALTER COLUMN king_id SET DEFAULT gen_random_uuid();

ALTER TABLE capital
    ALTER COLUMN capital_id SET DEFAULT gen_random_uuid();

ALTER TABLE trade
    ALTER COLUMN trade_id SET DEFAULT gen_random_uuid();
