# bash-report

Summarize nginx `access.log`: request count, status codes, top URLs and IPs. Bash + awk, cron-ready.

Учебный проект: базовый отчёт по access.log без внешних зависимостей. Закреплял awk, sort, uniq, cron.

## Usage / Запуск

```bash
./report.sh sample/access.log report.txt
```

Переменные окружения:
- `TOP_N` — сколько топ-записей выводить (по умолчанию 5)

Пример cron (каждые 5 минут):

```bash
*/5 * * * * /path/to/report.sh /var/log/nginx/access.log /var/log/report.txt
```

Коды возврата:
- `2` — файл не найден
- `3` — нет прав на чтение
- `4` — файл пустой

## Output example / Пример вывода

```text
=== Report: 2026-10-05T14:44:25+03:00 ===
File: sample/access.log
Total requests: 293

Status codes:
    248 200
     42 404
      3 304

Top 5 URLs:
    120 /api/v1/status
     45 /login
      ...

Top 5 IPs:
     88 192.0.2.10
     42 198.51.100.5
      ...
```

## What broke and how I fixed / Что ломалось

- Хардкод путей → аргументы + `TOP_N` через env
- Нет обработки отсутствующего/пустого лога → exit 2/3/4
- Пустой отчёт при отсутствии файла → явная ошибка, не пишем мусор

## Limitations / Ограничения

- Только nginx combined format
- Не учитывает ротацию логов (берёт один файл)
- Нет фильтра по датам (planned)

## Stack

Bash, awk, sort, uniq, cron. `shellcheck` clean.

## License

MIT
