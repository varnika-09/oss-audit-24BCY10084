#!/bin/bash
# Script 1: System Identity Report
# Author: VARNIKA BANERJEE | Course: Open Source Software

# --- Variables ---
STUDENT_NAME="VARNIKA BANERJEE"              # Fill in your name
SOFTWARE_CHOICE="git"           # Fill in your chosen software

# --- System info ---
KERNEL=$(uname -r)
USER_NAME=$(whoami)
UPTIME=$(uptime -p)
DISTRO=$(grep -oP '(?<=^PRETTY_NAME=").*(?=")' /etc/os-release 2>/dev/null \
         || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
DATETIME=$(date "+%A, %d %B %Y  %H:%M:%S")
HOME_DIR=$(eval echo "~$USER_NAME")

# --- License detection ---
# Check the distro ID and match it to the correct open-source license
DISTRO_ID=$(grep "^ID=" /etc/os-release | cut -d= -f2)
case "$DISTRO_ID" in
    ubuntu|debian)  LICENSE="GNU General Public License v2 & v3 (GPL)" ;;
    fedora|rhel)    LICENSE="GNU General Public License v2 (GPL-2.0)"  ;;
    arch)           LICENSE="GNU GPL and various open-source licenses"  ;;
    *)              LICENSE="GNU General Public License (GPL)"          ;;
esac

# --- Display ---
echo "================================"
echo "  Open Source Audit — $STUDENT_NAME"
echo "================================"
echo "Kernel  : $KERNEL"
echo "User    : $USER_NAME"
echo "Uptime  : $UPTIME"
echo "Distro  : $DISTRO"
echo "Home    : $HOME_DIR"
echo "Date    : $DATETIME"
echo "License : $LICENSE"
echo "================================"
echo "This system runs free software covered by the $LICENSE."
echo "You are free to use, study, share, and improve it."
echo "================================"
