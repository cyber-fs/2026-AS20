#!/bin/bash
#
# Detta skript samlar in grundläggande systeminformation (RECON)
#
# Kan användas för följande attacker:
# [Skriv möjliga attacker ex. Privilegieeskalering via sårbar kernel]
#
# Author:       Frans Schartau
# Last Update:  2026-12-XX


# Färgkoder för snyggare utdata i terminalen 
GREEN='\033[0;32m'
YELLOW='\033[0;33m'  
XX='\033[0m' # Återställer färg


# Rensa skärmen och skriv ut en tydlig banner
clear
echo -e "${YELLOW}***************************************************"
echo "  Välkommen till mitt RECON-skript för Linux-miljö"
echo "  Körs av: $USER | Datum: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "***************************************************${XX}" 


# 1. SYSTEM & KERNEL
echo -e "\n${GREEN}[+] SYSTEMINFORMATION (OS & Kernel)${XX}"
uname -a


# 2. HÅRDVARA
echo -e "\n${GREEN}[+] HÅRDVARA (CPU & RAM)${XX}"
lscpu | grep "Model name" | sed 's/Model name:\s*/CPU: /'
free -h | awk '/^Mem:/ {print "RAM: " $3 " använt av totalt " $2}'


# 3. ANVÄNDARE & GRUPPER
echo -e "\n${GREEN}[+] ANVÄNDARE & GRUPPER${XX}"
id
groups
echo "--- sudo-rättigheter (kan kräva lösenord) ---"
sudo -n -l 2>/dev/null || echo "Kunde inte lista sudo-rättigheter utan lösenord."


# 4. SUID-BINÄRER (vanlig väg till privilege escalation)
echo -e "\n${GREEN}[+] SUID-BINÄRER${XX}"
find / -xdev -perm -4000 -type f 2>/dev/null


# 5. SGID-BINÄRER
echo -e "\n${GREEN}[+] SGID-BINÄRER${XX}"
find / -xdev -perm -2000 -type f 2>/dev/null


# 6. FILKAPABILITETER (kan ge förhöjda rättigheter utan SUID)
echo -e "\n${GREEN}[+] FILKAPABILITETER${XX}"
getcap -r / 2>/dev/null


# 7. VÄRLDSSKRIVBARA FILER & KATALOGER
echo -e "\n${GREEN}[+] VÄRLDSSKRIVBARA FILER & KATALOGER${XX}"
find / -xdev \( -perm -0002 -type f -o -perm -0002 -type d \) 2>/dev/null


# 8. SCHEMALAGDA JOBB (CRON)
echo -e "\n${GREEN}[+] SCHEMALAGDA JOBB (CRON)${XX}"
crontab -l 2>/dev/null
ls -la /etc/cron* 2>/dev/null


# 9. INTRESSANTA FILER & RÄTTIGHETER
echo -e "\n${GREEN}[+] INTRESSANTA FILER${XX}"
ls -la /etc/passwd /etc/shadow /etc/sudoers 2>/dev/null
find / -xdev -name "*.sh" -writable -type f 2>/dev/null | head -n 20


# Tips: slå upp hittade SUID/SGID-binärer på https://gtfobins.github.io/
# för att se om de kan användas för privilege escalation.

