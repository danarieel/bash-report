# bash-report

[English](#english)

---

## English

Summarize nginx `access.log`: request count, status codes, top URLs and IPs. Bash + awk, cron-ready.

Educational project: basic access.log report with no external dependencies. Practiced awk, sort, uniq, cron.

### Usage

```bash
./report.sh sample/access.log report.txt
```

Environment variables:
- `TOP_N` — number of top entries to show (default: 5)

Cron example (every 5 minutes):

```bash
*/5 * * * * /path/to/report.sh /var/log/nginx/access.log /var/log/report.txt
```

Exit codes:
- `2` — file not found
- `3` — no read permission
- `4` — file is empty

### Output example

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

### What broke and how I fixed

- Hardcoded paths → arguments + `TOP_N` via env
- No handling of missing/empty log → exit 2/3/4
- Empty report if file missing → explicit error, no garbage output

### Limitations

- nginx combined format only
- Doesn't handle log rotation (single file)
- No date filter (planned)

### Stack

Bash, awk, sort, uniq, cron. `shellcheck` clean.

### License

MIT
