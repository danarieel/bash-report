#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 <access.log> [output.txt]

Env:
  TOP_N   number of top entries (default: 5)

Example:
  ./report.sh sample/access.log report.txt
EOF
  exit 1
}

[[ $# -lt 1 || "$1" == "-h" || "$1" == "--help" ]] && usage

LOG="$1"
OUT="${2:-report.txt}"
TOP_N="${TOP_N:-5}"

[[ ! -f "$LOG" ]] && { echo "File not found: $LOG" >&2; exit 2; }
[[ ! -r "$LOG" ]] && { echo "No read permission: $LOG" >&2; exit 3; }
[[ ! -s "$LOG" ]] && { echo "File is empty: $LOG" >&2; exit 4; }

{
  echo "=== Report: $(date -Iseconds) ==="
  echo "File: $LOG"
  echo "Total requests: $(wc -l < "$LOG")"
  echo
  echo "Status codes:"
  awk '{print $9}' "$LOG" | sort | uniq -c | sort -rn
  echo
  echo "Top $TOP_N URLs:"
  awk '{print $7}' "$LOG" | sort | uniq -c | sort -rn | head -n "$TOP_N"
  echo
  echo "Top $TOP_N IPs:"
  awk '{print $1}' "$LOG" | sort | uniq -c | sort -rn | head -n "$TOP_N"
} | tee "$OUT"