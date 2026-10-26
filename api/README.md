# API-тесты: Restful Booker

[← К оглавлению](../README.md)

Коллекция Postman для публичного учебного API [Restful Booker](https://restful-booker.herokuapp.com/apidoc/index.html) — сервиса бронирования отелей. 18 запросов, 42 проверки: healthcheck, авторизация, полный CRUD бронирования, негативные проверки валидации.

**Файл:** [restful-booker.postman_collection.json](restful-booker.postman_collection.json)

## Что проверяется

| Папка | Запросы | Что проверяют тесты |
| --- | --- | --- |
| 01. Healthcheck | GET /ping | Доступность сервиса |
| 02. Авторизация | POST /auth (валидные и неверные данные) | Выдача токена, отказ при неверном пароле |
| 03. Бронирование: CRUD | POST, GET, GET с фильтром, PUT без токена и с токеном, PATCH, DELETE, GET после удаления | Коды ответов, JSON-схема, сохранение данных, частичное обновление, доступ без токена → 403, удаление → 404 |
| 04. Валидация | Без обязательных полей, невалидный JSON, checkout < checkin, отрицательная цена, несуществующий ID | Сервер отклоняет некорректные данные с 4xx, без 5xx |

Приёмы: передача `token` и `bookingid` между запросами через переменные коллекции, генерация уникального имени в pre-request скрипте, проверка JSON-схемы, общий тест времени ответа на уровне коллекции, автоматическое удаление записей, созданных негативными тестами (`pm.sendRequest`).

## Результат прогона (26.10.2026, newman 6)

| Запросов | Проверок | Пройдено | Упало |
| --- | --- | --- | --- |
| 18 | 42 | 36 | 6 |

Все 6 упавших проверок намеренные — они фиксируют найденные дефекты API:

| Issue | Дефект | Severity |
| --- | --- | --- |
| [#9](https://github.com/andyrandels/qa-portfolio/issues/9) | POST /auth возвращает 200 OK при неверном пароле | Major |
| [#10](https://github.com/andyrandels/qa-portfolio/issues/10) | POST /booking без обязательных полей → 500 Internal Server Error | Major |
| [#11](https://github.com/andyrandels/qa-portfolio/issues/11) | Принимается дата выезда раньше даты заезда | Major |
| [#12](https://github.com/andyrandels/qa-portfolio/issues/12) | Принимается отрицательная стоимость | Major |
| [#13](https://github.com/andyrandels/qa-portfolio/issues/13) | DELETE возвращает 201 Created вместо 200/204 | Minor |

## Как запустить

- **Postman:** Import → выбрать файл коллекции → Run collection. Запросы выполняются по порядку.
- **Консоль:**

```bash
npx newman run restful-booker.postman_collection.json
```

Учётные данные `admin` / `password123` — публичные тестовые данные из документации Restful Booker.
