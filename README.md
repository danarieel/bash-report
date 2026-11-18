# bash-report

[English](#english) | [Русский](#русский)

---

## Русский

Сводка по `access.log` nginx: число запросов, коды ответов, топ URL и IP. Bash + awk, готов к запуску по cron.

Учебный проект: базовый отчёт по access.log без внешних зависимостей. Закреплял awk, sort, uniq, cron.

**Запуск:**
```bash
./report.sh sample/access.log report.txt
```
Переменные окружения: `TOP_N` — сколько топ-записей выводить (по умолчанию 5).

Коды возврата: `2` — файл не найден, `3` — нет прав на чтение, `4` — файл пустой.

Пример cron (каждые 5 минут):
```bash
*/5 * * * * /path/to/report.sh /var/log/nginx/access.log /var/log/report.txt
```

**Пример вывода:**
```text
=== Report: 2026-11-18T06:15:44+03:00 ===
File: sample/access.log
Total requests: 15

Status codes:
     10 200
      3 404
      1 500
      1 304

Top 5 URLs:
      5 /api/v1/status
      2 /login
      2 /index.html
      2 /api/v1/login
      2 /admin

Top 5 IPs:
      4 192.168.1.10
      3 8.8.8.8
      3 192.168.1.12
      3 192.168.1.11
      2 192.168.1.13
```

**Что ломалось и как починил:**
- Хардкод путей → аргументы + `TOP_N` через env.
- Нет обработки отсутствующего/пустого лога → exit 2/3/4.
- Пустой отчёт при отсутствии файла → явная ошибка, не пишем мусор.

**Ограничения:** Только nginx combined format, не учитывает ротацию логов.

**Лицензия:** MIT

---

## English

Summarize nginx `access.log`: request count, status codes, top URLs and IPs. Bash + awk, cron-ready.

Educational project: basic access.log report with no external dependencies. Practiced awk, sort, uniq, cron.

**Usage:**
```bash
./report.sh sample/access.log report.txt
```
Env variables: `TOP_N` — number of top entries to show (default: 5).

Exit codes: `2` — file not found, `3` — no read permission, `4` — file is empty.

Cron example (every 5 minutes):
```bash
*/5 * * * * /path/to/report.sh /var/log/nginx/access.log /var/log/report.txt
```

**Example output:**
```text
=== Report: 2026-11-18T06:15:44+03:00 ===
File: sample/access.log
Total requests: 15

Status codes:
     10 200
      3 404
      1 500
      1 304

Top 5 URLs:
      5 /api/v1/status
      2 /login
      2 /index.html
      2 /api/v1/login
      2 /admin

Top 5 IPs:
      4 192.168.1.10
      3 8.8.8.8
      3 192.168.1.12
      3 192.168.1.11
      2 192.168.1.13
```

**What broke & how I fixed it:**
- Hardcoded paths → arguments + `TOP_N` via env.
- No handling of missing/empty log → exit 2/3/4.
- Empty report if file missing → explicit error.

**Limitations:** nginx combined format only, doesn't handle log rotation.

**License:** MIT