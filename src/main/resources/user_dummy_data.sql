INSERT INTO users (
    user_id,
    grade,
    name,
    role,
    nickname,
    password,
    classroom,
    teacher_code
) VALUES (
    '11111111-1111-1111-1111-111111111111',
    1,
    'Teacher Kim',
    0,              -- TEACHER
    'T_Kim',
    'password',
    1,
    1001            -- teacher_code는 Integer
);

INSERT INTO users (
    user_id,
    grade,
    name,
    role,
    nickname,
    password,
    classroom,
    teacher_code
) VALUES
(
    '22222222-2222-2222-2222-222222222222',
    1,
    'Student Lee',
    1,              -- STUDENT
    'S_Lee',
    'password',
    1,
    1001
),
(
    '33333333-3333-3333-3333-333333333333',
    1,
    'Student Park',
    1,              -- STUDENT
    'S_Park',
    'password',
    2,
    1001
),
(
    '66666666-6666-6666-6666-666666666666',
    1,
    'Student Choi',
    1,              -- STUDENT
    'S_Choi',
    'password',
    3,
    1001
),
(
    '77777777-7777-7777-7777-777777777777',
    1,
    'Student Han',
    1,              -- STUDENT
    'S_Han',
    'password',
    4,
    1001
),
(
    '88888888-8888-8888-8888-888888888888',
    1,
    'Student Lim',
    1,              -- STUDENT
    'S_Lim',
    'password',
    5,
    1001
);

INSERT INTO users (
    user_id,
    grade,
    name,
    role,
    nickname,
    password,
    classroom,
    teacher_code
) VALUES (
    '44444444-4444-4444-4444-444444444444',
    2,
    'Teacher Choi',
    0,              -- TEACHER
    'T_Choi',
    'password',
    6,
    2001
);

INSERT INTO users (
    user_id,
    grade,
    name,
    role,
    nickname,
    password,
    classroom,
    teacher_code
) VALUES
(
    '55555555-5555-5555-5555-555555555555',
    2,
    'Student Jung',
    1,              -- STUDENT
    'S_Jung',
    'password',
    6,
    2001
),
(
    '99999999-9999-9999-9999-999999999999',
    2,
    'Student Moon',
    1,              -- STUDENT
    'S_Moon',
    'password',
    7,
    2001
),
(
    'aaaaaaaa-1111-1111-1111-111111111111',
    2,
    'Student Shin',
    1,              -- STUDENT
    'S_Shin',
    'password',
    8,
    2001
),
(
    'bbbbbbbb-1111-1111-1111-111111111111',
    2,
    'Student Yoon',
    1,              -- STUDENT
    'S_Yoon',
    'password',
    9,
    2001
),
(
    'cccccccc-1111-1111-1111-111111111111',
    2,
    'Student Kang',
    1,              -- STUDENT
    'S_Kang',
    'password',
    10,
    2001
);
