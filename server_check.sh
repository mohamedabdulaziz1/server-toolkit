#!/bin/bash

set -euo pipefail

#Configuration
LOG_FILE="var/log/server_check.log"

# Fall back to home directory if /var/log is not writable
if ! touch "$LOG_FILE" 2>/dev/null; then
    LOG_FILE="$HOME/server_check.log"
    touch "$LOG_FILE"
fi

timestamp() {
	date "+%Y-%m-%d %H:%M:%S"
}

log() {
	echo "[$(timestamp)] $*" | tee -a "$LOG_FILE"	
}

check_disk() {
	log "===== Disk Usage Check ====="

	usage=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')

	if [ "$usage" -gt 80  ]; then
		log "Warning: disk usage is at ${usage}"
	else
		log "OK: disk usage is at ${usage}"
	fi
}

check_memory() {
	log "===== Memory Usage Check ====="
	free -h | tee -a "$LOG_FILE"
}

summery() {
	log "Health check completed at $(timestamp)"
}

main() {

	check_disk
	check_memory
	summery
}

main
