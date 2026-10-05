#!/bin/bash
LOG=/var/log/nginx/access.log
OUT=/home/qbd/projects/bash-report/report.txt

{
  echo "=== Отчёт на $(date) ==="
  echo "Всего запросов:"
  wc -l <"$LOG"
  echo "Коды ответов:"
  awk '{print $9}' "$LOG" | sort | uniq -c | sort -rn
  echo "Топ URL:"
  awk '{print $7}' "$LOG" | sort | uniq -c | sort -rn | head -5
  echo "Топ IP:"
  awk '{print $1}' "$LOG" | sort | uniq -c | sort -rn | head -5
} > "$OUT"
