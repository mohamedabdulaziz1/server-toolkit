# Server Toolkit

A simple bash-based health check script for monitoring a Linux server's disk usage, memory usage, and a critical service's status. Built as a hands-on learning project covering Linux administration, bash scripting, and Git version control.

## What it does

`server_check.sh` runs a set of health checks and logs the results with timestamps:

- **Disk usage check** — reports the usage percentage of the root filesystem (`/`) and flags a warning if it's over 80%
- **Memory usage check** — reports current memory usage via `free -h`
- **Service check** — checks whether `nginx` is running and reports its status
- Logs every run, with timestamps, to a log file
- Designed to run unattended (no interactive prompts) so it can be scheduled via cron

## Requirements

- A Linux server (tested on Ubuntu Server)
- `nginx` installed (or edit the script to check a different service)
- Bash

## Usage

### Run manually
```bash
git clone https://github.com/mohamedabdulaziz1/server-toolkit.git
cd server-toolkit
chmod +x server_check.sh
./server_check.sh
```

### View the log
```bash
cat ~/server_check.log
```

## Automating with cron

To run the health check automatically every 10 minutes:

```bash
crontab -e
```

Add this line (update the path to match your actual clone location):
```
*/10 * * * * /home/yourusername/server-toolkit/server_check.sh
```

Verify it's running by checking the log after a few cycles:
```bash
cat ~/server_check.log
```

## Example output

```
[2026-08-03 18:27:31] ========================================
[2026-08-03 18:27:31] Starting server health check
[2026-08-03 18:27:31] ===== Disk Usage Check =====
[2026-08-03 18:27:31] OK: disk usage is at 45%
[2026-08-03 18:27:31] ===== Memory Usage Check =====
               total        used        free      shared  buff/cache   available
Mem:           3.3Gi       461Mi       2.2Gi       5.2Mi       776Mi       2.9Gi
Swap:          2.4Gi          0B       2.4Gi
[2026-08-03 18:27:31] ======= Service Check ========
[2026-08-03 18:27:31] OK: NGINX is running.
[2026-08-03 18:27:31] Health check completed at 2026-08-03 18:27:31
```

## What I learned building this

- Filtering and parsing command output with `grep`, `awk`, `tr`, and `df`/`free`
- Writing portable scripts (e.g. using `df -h /` instead of a hardcoded, machine-specific disk name)
- Safe error handling in bash with `set -euo pipefail`, including how to allow a specific command to fail without killing the whole script (`|| true`)
- The difference between numeric (`-eq`, `-gt`) and string (`=`, `!=`) comparisons in bash conditionals
- Scheduling unattended jobs with cron, and the importance of using absolute paths (cron doesn't know your working directory or shell environment)
- A full Git workflow: local commits, branching, merging, resolving conflicts, and pushing/pulling between a local machine and a remote server

## Project structure
```
server-toolkit/
├── server_check.sh    # main health check script
└── README.md            # this file
```
