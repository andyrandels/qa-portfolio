-- Проверка данных ITSM-системы после UI- и API-тестов
-- Учебная упрощённая схема (инциденты, группы, пользователи, SLA). Диалект: SQLite.
-- Запуск: sqlite3 :memory: < itsm_checks.sql   или открыть в DBeaver (SQLite).

-- ========== Схема ==========
CREATE TABLE groups (
    id   INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE users (
    id       INTEGER PRIMARY KEY,
    name     TEXT NOT NULL,
    role     TEXT NOT NULL CHECK (role IN ('portal_user', 'agent', 'group_lead', 'admin')),
    group_id INTEGER REFERENCES groups(id)
);

CREATE TABLE incidents (
    id              INTEGER PRIMARY KEY,
    number          TEXT UNIQUE,
    subject         TEXT NOT NULL,
    caller_id       INTEGER NOT NULL REFERENCES users(id),
    group_id        INTEGER REFERENCES groups(id),
    assignee_id     INTEGER REFERENCES users(id),
    impact          INTEGER NOT NULL CHECK (impact BETWEEN 1 AND 3),   -- 1 = высокое
    urgency         INTEGER NOT NULL CHECK (urgency BETWEEN 1 AND 3),  -- 1 = высокая
    priority        INTEGER NOT NULL,                                  -- 1 = критичный
    state           TEXT NOT NULL CHECK (state IN ('new', 'in_progress', 'on_hold', 'resolved', 'closed')),
    resolution_code TEXT,
    created_at      TEXT NOT NULL,
    resolved_at     TEXT
);

CREATE TABLE sla (
    id          INTEGER PRIMARY KEY,
    incident_id INTEGER NOT NULL REFERENCES incidents(id),
    stage       TEXT NOT NULL CHECK (stage IN ('in_progress', 'paused', 'achieved', 'breached')),
    due_at      TEXT NOT NULL
);

-- ========== Тестовые данные (в т.ч. заведомо некорректные записи) ==========
INSERT INTO groups VALUES (1, '1-я линия'), (2, '2-я линия');

INSERT INTO users VALUES
    (1, 'Иванов И.И.',  'portal_user', NULL),
    (2, 'Петров П.П.',  'agent',       1),
    (3, 'Сидорова А.А.', 'agent',      2),
    (4, 'Кузнецов К.К.', 'group_lead', 1);

INSERT INTO incidents VALUES
    (1, 'INC0000001', 'Не отправляются письма', 1, 1, 2, 1, 1, 1, 'in_progress', NULL,       '2026-10-20 09:00', NULL),
    (2, 'INC0000002', 'Не печатает принтер',    1, 1, 2, 2, 2, 3, 'resolved',    'fixed',    '2026-10-20 10:00', '2026-10-20 12:00'),
    (3, 'INC0000003', 'Нет доступа к VPN',      1, 1, 2, 2, 1, 2, 'resolved',    NULL,       '2026-10-21 11:00', '2026-10-21 15:00'),  -- нет кода решения
    (4, 'INC0000004', 'Медленно работает 1С',   1, 2, 2, 1, 2, 3, 'on_hold',     NULL,       '2026-10-22 09:30', NULL),                -- исполнитель не из группы, приоритет не по матрице
    (5, NULL,         'Создан через API',       1, 1, NULL, 3, 3, 5, 'new',       NULL,       '2026-10-23 08:00', NULL);                -- нет номера

INSERT INTO sla VALUES
    (1, 1, 'in_progress', '2026-10-20 17:00'),
    (2, 2, 'achieved',    '2026-10-20 17:00'),
    (3, 4, 'in_progress', '2026-10-22 17:30');  -- инцидент на паузе, а SLA идёт

-- ========== Проверки ==========
-- Каждая проверка должна вернуть 0 строк. Любая строка в результате — дефект данных.

-- 1. Инциденты без номера INC
SELECT id, subject FROM incidents
WHERE number IS NULL OR number NOT LIKE 'INC_______';

-- 2. Решённые и закрытые инциденты без кода решения или даты решения
SELECT number, state, resolution_code, resolved_at FROM incidents
WHERE state IN ('resolved', 'closed')
  AND (resolution_code IS NULL OR resolved_at IS NULL);

-- 3. Приоритет не соответствует матрице «Влияние × Срочность» (priority = impact + urgency - 1)
SELECT number, impact, urgency, priority, impact + urgency - 1 AS expected_priority
FROM incidents
WHERE priority <> impact + urgency - 1;

-- 4. Исполнитель не состоит в группе, на которую назначен инцидент
SELECT i.number, g.name AS incident_group, u.name AS assignee, ug.name AS assignee_group
FROM incidents i
JOIN users u        ON u.id = i.assignee_id
JOIN groups g       ON g.id = i.group_id
LEFT JOIN groups ug ON ug.id = u.group_id
WHERE u.group_id IS NOT i.group_id;

-- 5. Исполнитель без роли агента
SELECT i.number, u.name, u.role FROM incidents i
JOIN users u ON u.id = i.assignee_id
WHERE u.role NOT IN ('agent', 'group_lead');

-- 6. Инцидент в статусе «Ожидание», а SLA не приостановлен
SELECT i.number, i.state, s.stage FROM incidents i
JOIN sla s ON s.incident_id = i.id
WHERE i.state = 'on_hold' AND s.stage <> 'paused';

-- 7. Активные инциденты без прикреплённого SLA
SELECT i.number, i.state FROM incidents i
LEFT JOIN sla s ON s.incident_id = i.id
WHERE i.state NOT IN ('resolved', 'closed') AND s.id IS NULL;

-- 8. Сводка для отчёта о тестировании: количество инцидентов по группам и статусам
SELECT COALESCE(g.name, '(без группы)') AS group_name, i.state, COUNT(*) AS cnt
FROM incidents i
LEFT JOIN groups g ON g.id = i.group_id
GROUP BY g.name, i.state
ORDER BY g.name, i.state;
