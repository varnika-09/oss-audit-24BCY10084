#!/bin/bash
# Script 5: The Open Source Manifesto Generator
# Author: VARNIKA BANERJEE | Course: Open Source Software

# --- Variables ---
STUDENT_NAME="VARNIKA BANERJEE"              # Fill in your name
SOFTWARE_CHOICE="git"           # Fill in your chosen software

# --- Alias concept (demonstration via comment) ---
# In a live shell session you could define:
#   alias manifesto='./script5_manifesto_generator.sh'
# Then launch this script simply by typing: manifesto
# Aliases make long commands shorter and easier to remember.
# Note: aliases defined inside a script do not persist after it exits.

# --- Welcome banner ---
echo "================================"
echo "  Open Source Manifesto Generator"
echo "  — $STUDENT_NAME"
echo "================================"
echo "Answer 3 questions to generate your"
echo "personal open-source philosophy statement."
echo ""

# --- User input via read ---
# Question 1: name
echo -n "1. What is your name? "
read -r USER_NAME

# Use a default if the user pressed Enter without typing
if [ -z "$USER_NAME" ]; then
    USER_NAME="An Open Source Advocate"
fi

# Question 2: favourite FOSS project
echo ""
echo -n "2. What is your favourite open-source project or tool? "
read -r FOSS_PROJECT

if [ -z "$FOSS_PROJECT" ]; then
    FOSS_PROJECT="Linux"
fi

# Question 3: one word or phrase for why they value open source
echo ""
echo "3. In one word, why do you value open source?"
echo "   (e.g. freedom, collaboration, transparency)"
echo -n "   Your answer: "
read -r OS_VALUE

if [ -z "$OS_VALUE" ]; then
    OS_VALUE="freedom"
fi

# --- Date and filename ---
TIMESTAMP=$(date '+%A, %d %B %Y at %H:%M:%S')
FILENAME_DATE=$(date '+%Y%m%d_%H%M%S')
OUTPUT_FILE="${HOME}/manifesto_${FILENAME_DATE}.txt"

# Fallback to /tmp if HOME directory is not writable
if [ ! -w "$HOME" ]; then
    OUTPUT_FILE="/tmp/manifesto_${FILENAME_DATE}.txt"
fi

# --- String concatenation: build manifesto lines ---
# Each variable holds one line; they are concatenated into the file below
LINE1="I, ${USER_NAME}, believe that software is more than a tool —"
LINE2="it is a shared language spoken by communities across the world."
LINE3="My commitment to open source is rooted in the value of ${OS_VALUE}."
LINE4="Open source means knowledge is not locked behind proprietary walls,"
LINE5="but is freely available for anyone to study, improve, and share."
LINE6="My favourite example of this philosophy is ${FOSS_PROJECT}."
LINE7="Projects like ${FOSS_PROJECT} prove that open collaboration produces"
LINE8="software that rivals — and often surpasses — closed alternatives."
LINE9="I pledge to support open-source communities through contribution,"
LINE10="documentation, and by choosing FOSS solutions wherever possible."
LINE11="Because software that respects its users' freedoms makes the world better."

SIGNATURE="— ${USER_NAME}  |  ${TIMESTAMP}"

# --- Write to file using > (output redirect) ---
# The group command { } sends all echo output into the file in one operation
{
    echo "================================"
    echo "  My Open Source Manifesto"
    echo "================================"
    echo ""
    echo "  $LINE1"
    echo "  $LINE2"
    echo ""
    echo "  $LINE3"
    echo "  $LINE4"
    echo "  $LINE5"
    echo ""
    echo "  $LINE6"
    echo "  $LINE7"
    echo "  $LINE8"
    echo ""
    echo "  $LINE9"
    echo "  $LINE10"
    echo "  $LINE11"
    echo ""
    echo "  $SIGNATURE"
    echo "================================"
} > "$OUTPUT_FILE"

# --- Display confirmation and preview ---
echo ""
echo "================================"
echo "Saved to: $OUTPUT_FILE"
echo "================================"
cat "$OUTPUT_FILE"
echo ""
echo "Done! Share your manifesto with the open-source world."
echo "================================"
