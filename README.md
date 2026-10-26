# Портфолио QA-инженера

Примеры тестовой документации и API-тестов: веб-платформа SimpleOne (ITSM), сервисы Яндекс Метро и Yandex Go (Android-приложения на эмуляторе Android Studio и веб-версии), REST API Restful Booker.

- **Чек-листы и тест-кейсы** — в [Google Таблице](https://docs.google.com/spreadsheets/d/19KhxG8fqs5XBGg2DvpUflR526Keji8dQ_UMsC6o-R50/edit?usp=sharing) (открывается в браузере, по листу на чек-лист и тест-кейсы каждого проекта). Та же таблица для скачивания — [qa-portfolio.xlsx](qa-portfolio.xlsx).
- **Баг-репорты** — в трекере [Issues](https://github.com/andyrandels/qa-portfolio/issues) этого репозитория. Проверки со статусом Failed в таблице и упавшие автотесты ссылаются на соответствующий issue.
- **API-тесты** — коллекция Postman с автотестами: [api/](api/README.md).
- **SQL** — запросы для проверки данных в БД: [sql/](sql/README.md).

| Проект | Платформы | Документация | Баги |
| --- | --- | --- | --- |
| SimpleOne (ITSM) | Web (Chrome, Firefox, Yandex Browser), REST API (Postman) | Чек-лист (38 проверок), 6 тест-кейсов | [#1–#4](https://github.com/andyrandels/qa-portfolio/issues?q=SimpleOne) |
| Яндекс Метро | Android (эмулятор), Web (Chrome) | Чек-лист (14 проверок), 3 тест-кейса | [#5–#6](https://github.com/andyrandels/qa-portfolio/issues?q=%D0%9C%D0%B5%D1%82%D1%80%D0%BE) |
| Yandex Go | Android (эмулятор), Web (Chrome) | Чек-лист (13 проверок), 3 тест-кейса | [#7–#8](https://github.com/andyrandels/qa-portfolio/issues?q=%22Yandex+Go%22) |
| Restful Booker API | REST API (Postman, newman) | [Коллекция](api/README.md): 18 запросов, 42 проверки | [#9–#13](https://github.com/andyrandels/qa-portfolio/issues?q=%22Restful+Booker%22) |

## SimpleOne

Low-code платформа для управления IT-услугами по ITIL. Роль — QA-инженер (ручное тестирование). Проверялись модули: инциденты, портал самообслуживания, SLA, роли и права доступа, REST API. Задачи: анализ требований, написание чек-листов и тест-кейсов в TestIT, smoke- и регрессионное тестирование, проверка данных в БД через SQL, заведение и перепроверка багов в Jira.

## Яндекс Метро и Yandex Go

Тестирование пользовательских сценариев в Android-приложении на эмуляторе Android Studio (Pixel 6, Android 14) и в веб-версии в Chrome. Использовались возможности эмулятора: фиктивная геолокация, поворот экрана, авиарежим, эмуляция медленной сети и входящего звонка, а также логи `adb logcat` и Chrome DevTools (Device Mode, Network, HAR).

## Restful Booker API

Публичный учебный API бронирования отелей. Коллекция покрывает авторизацию, полный CRUD и негативные проверки валидации; токен и ID передаются между запросами через переменные, ответы проверяются по JSON-схеме. Прогон через newman нашёл 5 дефектов — от 500 на невалидных данных до 200 OK при неверном пароле.

## Навыки

- **Виды тестирования:** функциональное, регрессионное, smoke, тестирование ролевой модели, UI, API, кросс-браузерное, мобильное (Android).
- **Техники тест-дизайна:** классы эквивалентности, граничные значения, таблицы решений, переходы состояний.
- **Инструменты:** Jira, Confluence, TestIT, Postman, newman, Chrome DevTools, Android Studio (эмулятор, ADB), SQL (DBeaver), Git, GitHub Issues.

Данные заказчиков по проекту SimpleOne обезличены (NDA), примеры построены на стандартной функциональности платформы.
