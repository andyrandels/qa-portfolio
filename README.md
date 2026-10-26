# Портфолио QA-инженера

Примеры тестовой документации по трём проектам: веб-платформе SimpleOne (ITSM) и сервисам Яндекс Метро и Yandex Go (Android-приложения на эмуляторе Android Studio и веб-версии).

- **Чек-листы и тест-кейсы** — в [Google Таблице](https://docs.google.com/spreadsheets/d/19KhxG8fqs5XBGg2DvpUflR526Keji8dQ_UMsC6o-R50/edit?usp=sharing) (открывается в браузере, по листу на чек-лист и тест-кейсы каждого проекта). Та же таблица для скачивания — [qa-portfolio.xlsx](qa-portfolio.xlsx).
- **Баг-репорты** — в трекере [Issues](https://github.com/andyrandels/qa-portfolio/issues) этого репозитория. Проверки со статусом Failed в таблице ссылаются на соответствующий issue.

| Проект | Платформы | Чек-лист | Тест-кейсы | Баги |
| --- | --- | --- | --- | --- |
| SimpleOne (ITSM) | Web (Chrome, Firefox, Yandex Browser), REST API (Postman) | 38 проверок | 6 | [#1–#4](https://github.com/andyrandels/qa-portfolio/issues?q=SimpleOne) |
| Яндекс Метро | Android (эмулятор), Web (Chrome) | 14 проверок | 3 | [#5–#6](https://github.com/andyrandels/qa-portfolio/issues?q=%D0%9C%D0%B5%D1%82%D1%80%D0%BE) |
| Yandex Go | Android (эмулятор), Web (Chrome) | 13 проверок | 3 | [#7–#8](https://github.com/andyrandels/qa-portfolio/issues?q=%22Yandex+Go%22) |

## SimpleOne

Low-code платформа для управления IT-услугами по ITIL. Роль — QA-инженер (ручное тестирование). Проверялись модули: инциденты, портал самообслуживания, SLA, роли и права доступа, REST API. Задачи: анализ требований, написание чек-листов и тест-кейсов в TestIT, smoke- и регрессионное тестирование, проверка данных в БД через SQL, заведение и перепроверка багов в Jira.

## Яндекс Метро и Yandex Go

Тестирование пользовательских сценариев в Android-приложении на эмуляторе Android Studio (Pixel 6, Android 14) и в веб-версии в Chrome. Использовались возможности эмулятора: фиктивная геолокация, поворот экрана, авиарежим, эмуляция медленной сети и входящего звонка, а также логи `adb logcat` и Chrome DevTools (Device Mode, Network, HAR).

## Навыки

- **Виды тестирования:** функциональное, регрессионное, smoke, тестирование ролевой модели, UI, API, кросс-браузерное, мобильное (Android).
- **Техники тест-дизайна:** классы эквивалентности, граничные значения, таблицы решений, переходы состояний.
- **Инструменты:** Jira, Confluence, TestIT, Postman, Chrome DevTools, Android Studio (эмулятор, ADB), SQL (DBeaver), GitHub Issues.

Данные заказчиков по проекту SimpleOne обезличены (NDA), примеры построены на стандартной функциональности платформы.
