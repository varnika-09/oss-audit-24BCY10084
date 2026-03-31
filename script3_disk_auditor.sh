#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: VARNIKA BANERJEE | Course: Open Source Software

# --- Variables ---
STUDENT_NAME="VARNIKA BANERJEE"              # Fill in your name
SOFTWARE_CHOICE="git"           # Fill in your chosen software

# --- Directory list ---
# Define the important system directories to audit in a for loop
DIRS=(
    "/etc"
    "/var"
    "/home"
    "/usr"
    "/tmp"
    "/bin"
    "/sbin"
    "/opt"
    "/root"
    "/boot"
)

# --- Display header ---
echo "================================"
echo "  Disk & Permission Audit — $STUDENT_NAME"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================"
printf "%-18s %-10s %-6s %s\n" "DIRECTORY" "USAGE" "OCTAL" "PERMISSIONS"
echo "--------------------------------"

# --- For loop: audit each directory ---
# Loop through every directory in the DIRS array
for DIR in "${DIRS[@]}"; do

    # Check the directory exists before inspecting it
    if [ -d "$DIR" ]; then

        # Get disk usage with du -sh; use awk to extract the size field (column 1)
        USAGE=$(du -sh "$DIR" 2>/dev/null | awk '{print $1}')

        # Get the symbolic permissions string using ls -ld and awk (column 1)
        PERMISSIONS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')

        # Get the owner using ls -ld and awk (column 3)
        OWNER=$(ls -ld "$DIR" 2>/dev/null | awk '{print $3}')

        # Get the octal permission value using stat
        OCTAL=$(stat -c "%a" "$DIR" 2>/dev/null)

        # Print one row per directory in aligned columns
        printf "%-18s %-10s %-6s %s (owner: %s)\n" \
               "$DIR" "${USAGE:-N/A}" "$OCTAL" "$PERMISSIONS" "$OWNER"

    else
        # Report directories that do not exist on this system
        printf "%-18s %s\n" "$DIR" "[NOT FOUND]"
    fi

done

echo "--------------------------------"

# --- Filesystem summary ---
# Use df -h to show overall disk usage; filter out virtual filesystems
echo ""
echo "Filesystem Summary (df -h):"
echo "--------------------------------"
df -h | grep -v "tmpfs\|devtmpfs\|udev" | \
    awk 'NR==1 { printf "  %-22s %5s %5s %5s %s\n",$1,$2,$3,$4,$5 }
         NR >1 { printf "  %-22s %5s %5s %5s %s\n",$1,$2,$3,$4,$5 }'

echo "================================"
