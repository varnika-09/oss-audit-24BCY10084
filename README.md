# oss-audit-24BCY10084
OPEN SOURCE SOFTWARE

WHAT THIS PROJECT IS ABOUT
This is a capstone project for the Open Source Software course. 
The goal is to pick one real open-source software project and conduct a structured, honest audit of it — not just describing what it does, but understanding why it was built, who built it, what freedoms its license gives users, what values it represents, and how it has influenced the world of software.
The project chosen for this audit is the Linux Kernel, compared against its closest proprietary alternative, Microsoft Windows Server.

SCRIPT 1 SYSTEM IDENTITY REPORT
This script acts as a welcome screen that displays key information about the Linux system. It uses variables to store system data such as the kernel version, current user, uptime, distribution name, home directory, and current date and time. All of this information is gathered using command substitution — the $() syntax syntax — which runs a command and stores its output directly into a variable. For example, $(uname -r) fetches the kernel version and $(whoami) fetches the logged-in username. A case statement is used to detect the Linux distribution and match it to the correct open-source license. The results are displayed using formatted echo statements that produce a clean, readable welcome screen layout.
  OUTPUT FOR SCRIPT 1
  <img width="1330" height="419" alt="image" src="https://github.com/user-attachments/assets/fa74d083-63d8-4cd0-8f32-2211e3b455b4" />


SCRIPT 2 FOSS PACKAGE INSPECTOR
This script checks whether a chosen software package is installed on the system, finds its version, and prints a description of its purpose. It uses an if-then-else statement to first detect which package manager is available on the system — either dpkg for Debian/Ubuntu systems or rpm for Fedora/RHEL systems. It then uses another if-then-else to check whether the package is installed by running dpkg -l and piping the output through grep to search for the package name. The version is extracted using awk to isolate the third column of the output. A case statement matches the package name and prints a human-readable description of its purpose. The script also accepts a command-line argument $1 so the user can pass a package name directly when running the script.
  OUTPUT FOR SCRIPT 2
  <img width="1264" height="330" alt="image" src="https://github.com/user-attachments/assets/bc05b371-8c58-4df1-a1e4-c043cb75cad5" />


SCRIPT 3 DISC AND PERMISSION AUDITOR
This script loops through a predefined list of important Linux system directories and reports the disk usage, permissions, and owner of each one. It uses a for loop to iterate through an array of directory paths one by one. For each directory, it runs du -sh to get the disk usage in human-readable format, and ls -ld to get the full directory listing including permissions and owner. Awk is used to extract specific fields from the output — for example, awk '{print $1}' extracts the permissions string and awk '{print $3}' extracts the owner name. The stat command is used to retrieve the octal permission value. An if statement checks whether each directory actually exists before trying to inspect it, preventing errors on systems where some directories may be absent. A filesystem summary is also printed using df -h.
  OUTPUT FOR SCRIPT 3
  <img width="1094" height="520" alt="image" src="https://github.com/user-attachments/assets/1c4c349b-e917-4960-a5cb-51d26973b224" />
  <img width="947" height="563" alt="image" src="https://github.com/user-attachments/assets/880f8b3f-0e33-48b0-aa9f-63000bcc9d3a" />


SCRIPT 4 LOG FILE ANALYSER
This script reads a log file line by line, counts how many lines contain specific keywords such as ERROR, WARNING, and INFO, and prints a formatted summary report. It accepts a command-line argument $1 for the log file path — if none is provided, it automatically searches for common system log files like /var/log/syslog. A while read loop with IFS= read -r LINE reads the file one line at a time without losing whitespace or special characters. Inside the loop, if-then statements check each line for keywords using grep -qi (case-insensitive search), and counter variables such as ERROR_COUNT and WARNING_COUNT are incremented accordingly using arithmetic $(( )). After the loop finishes, awk is used to calculate the percentage of each category, and the results are displayed in a neatly aligned table using printf.
  OUTPUT FOR SCRIPT 4
  <img width="1060" height="467" alt="image" src="https://github.com/user-attachments/assets/58072560-0dd7-4146-be29-a010e9387599" />


SCRIPT 5 OPEN SOURCE MANIFESTO GENERATOR
This script interactively asks the user three questions and uses their answers to generate a personalised open-source philosophy statement, which is then saved to a .txt file. The read command is used to capture user input for each question — the user's name, their favourite open-source project, and a word describing why they value open source. These inputs are stored in variables and then combined using string concatenation — each line of the manifesto is built by embedding the variables directly inside strings. The date command is used both to timestamp the output file's filename and to sign the manifesto at the bottom. The manifesto is written to a file using the > output redirect operator inside a grouped command block { }, which sends multiple echo statements into the file in a single operation. The script also demonstrates the alias concept through a comment at the top, explaining how a shell alias could be used to launch the script with a short custom command.
  OUTPUT FOR SCRIPT 5
  <img width="964" height="444" alt="image" src="https://github.com/user-attachments/assets/4d902755-54c0-493c-b143-8a93c3ed1066" />
  <img width="1168" height="769" alt="image" src="https://github.com/user-attachments/assets/35c7c18e-c379-4e4b-b11e-2e8516c591d3" />
