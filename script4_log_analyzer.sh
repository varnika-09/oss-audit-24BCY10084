#!/bin/bash
# Script 4: Log File Analyzer
# Author: VARNIKA BANERJEE | Course: Open Source Software
# Usage:  ./script4_log_analyzer.sh /path/to/file.log

# --- Variables ---
STUDENT_NAME="VARNIKA BANERJEE"              # Fill in your name
SOFTWARE_CHOICE="git"           # Fill in your chosen software

# --- Set log file from argument $1 ---
# $1 is the first command-line argument — the path to the log file
LOG_FILE="$1"

# If no argument given, try common system log locations
if [ -z "$LOG_FILE" ]; then
    for CANDIDATE in /var/log/syslog /var/log/messages /var/log/kern.log; do
        if [ -f "$CANDIDATE" ]; then
            LOG_FILE="$CANDIDATE"
            break
        fi
    done
fi

# If still no log found, create a sample log for demonstration
if [ -z "$LOG_FILE" ] || [ ! -f "$LOG_FILE" ]; then
    echo "[INFO] No log file found. Creating a sample log for demonstration..."
    LOG_FILE="/tmp/sample_demo.log"
    cat > "$LOG_FILE" <<'SAMPLELOG'
2024-01-15 08:00:01 INFO  System started successfully
2024-01-15 08:01:10 INFO  Service nginx started
2024-01-15 08:02:33 WARNING Disk usage above 80% on /dev/sda1
2024-01-15 08:03:45 ERROR  Failed to connect to database server
2024-01-15 08:04:01 INFO  Retry attempt 1 for database connection
2024-01-15 08:04:05 ERROR  Retry failed — database unreachable
2024-01-15 08:05:22 WARNING Memory usage high: 91%
2024-01-15 08:06:00 INFO  Backup process initiated
2024-01-15 08:06:45 ERROR  Backup failed: permission denied on /mnt/backup
2024-01-15 08:07:10 INFO  Sending alert email to admin
2024-01-15 08:08:00 WARNING NTP sync delayed
2024-01-15 08:09:15 INFO  System health check passed
2024-01-15 08:10:00 ERROR  Unexpected process termination: pid 4821
SAMPLELOG
    echo "[INFO] Sample log created at: $LOG_FILE"
fi

# --- Counter variables ---
# These will be incremented inside the while-read loop
ERROR_COUNT=0
WARNING_COUNT=0
INFO_COUNT=0
OTHER_COUNT=0
TOTAL_LINES=0

# --- Display header ---
echo "================================"
echo "  Log File Analyzer — $STUDENT_NAME"
echo "  File   : $LOG_FILE"
echo "  Scanned: $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================"

# --- While-read loop: read log line by line ---
# IFS= preserves whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do

    # Increment total line counter on every iteration
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # --- if-then: categorise each line by keyword ---
    if echo "$LINE" | grep -qi "ERROR"; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
    elif echo "$LINE" | grep -qi "WARNING"; then
        WARNING_COUNT=$((WARNING_COUNT + 1))
    elif echo "$LINE" | grep -qi "INFO"; then
        INFO_COUNT=$((INFO_COUNT + 1))
    else
        OTHER_COUNT=$((OTHER_COUNT + 1))
    fi

done < "$LOG_FILE"
# The < operator redirects the file into the while loop as standard input

# --- Calculate percentages using awk ---
if [ "$TOTAL_LINES" -gt 0 ]; then
    ERROR_PCT=$(awk "BEGIN {printf \"%.1f\", ($ERROR_COUNT/$TOTAL_LINES)*100}")
    WARN_PCT=$(awk  "BEGIN {printf \"%.1f\", ($WARNING_COUNT/$TOTAL_LINES)*100}")
    INFO_PCT=$(awk  "BEGIN {printf \"%.1f\", ($INFO_COUNT/$TOTAL_LINES)*100}")
else
    ERROR_PCT="0.0"; WARN_PCT="0.0"; INFO_PCT="0.0"
fi

# --- Display summary ---
echo "Results:"
echo "--------------------------------"
printf "  %-18s %4d  (%s%%)\n" "ERROR lines:"   "$ERROR_COUNT"   "$ERROR_PCT"
printf "  %-18s %4d  (%s%%)\n" "WARNING lines:" "$WARNING_COUNT" "$WARN_PCT"
printf "  %-18s %4d  (%s%%)\n" "INFO lines:"    "$INFO_COUNT"    "$INFO_PCT"
printf "  %-18s %4d\n"         "Other lines:"   "$OTHER_COUNT"
echo "--------------------------------"
printf "  %-18s %4d\n"         "TOTAL lines:"   "$TOTAL_LINES"
echo "================================"

# --- Final alert if errors were found ---
if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "WARNING: $ERROR_COUNT ERROR(s) found. Review $LOG_FILE"
else
    echo "OK: No ERROR lines found. Log looks healthy."
fi

echo "================================"
