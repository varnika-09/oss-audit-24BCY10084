#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: VARNIKA BANERJEE | Course: Open Source Software

# --- Variables ---
STUDENT_NAME="VARNIKA BANERJEE"              # Fill in your name
SOFTWARE_CHOICE="git"           # Fill in your chosen software (e.g. git, curl, vim)

# --- Detect package manager ---
# Check which package manager is available on this system
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
else
    echo "ERROR: No supported package manager found (dpkg/rpm)."
    exit 1
fi

# --- Accept package name ---
# Use command-line argument $1 if given, otherwise use SOFTWARE_CHOICE
if [ -n "$1" ]; then
    PACKAGE="$1"
elif [ -n "$SOFTWARE_CHOICE" ]; then
    PACKAGE="$SOFTWARE_CHOICE"
else
    echo -n "Enter the package name to inspect: "
    read -r PACKAGE
fi

# --- Check if installed ---
# Use dpkg or rpm to look up the package, pipe output through grep
if [ "$PKG_MANAGER" = "dpkg" ]; then
    PKG_INFO=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii")
else
    PKG_INFO=$(rpm -qi "$PACKAGE" 2>/dev/null | grep -i "^Version")
fi

# --- Display installation status ---
echo "================================"
echo "  FOSS Package Inspector — $STUDENT_NAME"
echo "================================"
echo "Package : $PACKAGE"

if [ -n "$PKG_INFO" ]; then
    echo "Status  : INSTALLED"
    # Extract version using awk to pull the third field from dpkg output
    if [ "$PKG_MANAGER" = "dpkg" ]; then
        VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
    else
        VERSION=$(rpm -qi "$PACKAGE" 2>/dev/null | grep "^Version" | awk '{print $3}')
    fi
    echo "Version : $VERSION"
else
    echo "Status  : NOT INSTALLED"
    echo "Tip     : sudo apt install $PACKAGE"
fi

# --- Case statement: describe the package ---
# Match the package name and print a short description of its purpose
echo "--------------------------------"
echo "Description:"
case "$PACKAGE" in
    git)
        echo "  git — Distributed version control system."
        echo "  Used to track source code changes in open-source projects."
        ;;
    vim|vi)
        echo "  vim — Highly configurable FOSS text editor."
        echo "  Available on virtually every Linux system."
        ;;
    curl)
        echo "  curl — Command-line tool for transferring data via URLs."
        echo "  Supports HTTP, HTTPS, FTP and many more protocols."
        ;;
    wget)
        echo "  wget — Non-interactive network file downloader."
        echo "  Useful for retrieving files from the web inside scripts."
        ;;
    python3|python)
        echo "  python3 — High-level general-purpose programming language."
        echo "  Widely used in scripting, AI, web development, and science."
        ;;
    bash)
        echo "  bash — The GNU Bourne Again SHell."
        echo "  Default command interpreter on most Linux systems."
        ;;
    htop)
        echo "  htop — Interactive colour-coded process viewer."
        echo "  A FOSS alternative to the standard top utility."
        ;;
    nginx|apache2|httpd)
        echo "  $PACKAGE — Open-source web server."
        echo "  Used to serve websites and reverse-proxy requests."
        ;;
    *)
        echo "  '$PACKAGE' — No built-in description available."
        echo "  Try: man $PACKAGE  or  $PACKAGE --help"
        ;;
esac

echo "================================"
