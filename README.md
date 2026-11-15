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

**What broke & how I fixed it:**
- Hardcoded paths → arguments + `TOP_N` via env.
- No handling of missing/empty log → exit 2/3/4.
- Empty report if file missing → explicit error.

**Limitations:** nginx combined format only, doesn't handle log rotation.

**License:** MIT
