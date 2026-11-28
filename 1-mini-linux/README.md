# Linux Recon Script (AS20)

Ett Bash-skript som automatiserar grundläggande lokal systemrekognosering (*recon*) i Linux. Skriptet samlar in information om system, hårdvara och användare samt letar efter vanliga vägar till **privilege escalation**, till exempel SUID/SGID-binärer, filkapabiliteter, världsskrivbara filer och schemalagda jobb.

## Användning
```bash
chmod +x script.sh
./script.sh
```

> Körs fördelaktigt som en vanlig användare. Vissa kontroller (t.ex. `sudo -l`) kan kräva lösenord och hoppas då över automatiskt.

## Vad skriptet letar efter
- System- och kernelinformation (för kända kernel-exploits)
- Användare, grupper och sudo-rättigheter
- SUID- och SGID-binärer
- Filkapabiliteter (`getcap`)
- Världsskrivbara filer och kataloger
- Cron-jobb
- Intressanta filer som `/etc/passwd`, `/etc/shadow` och `/etc/sudoers`

Hittade SUID/SGID-binärer kan slås upp på [GTFOBins](https://gtfobins.github.io/) för att se om de kan utnyttjas.

## Exempel på utdata
![Skärmdump](dump.png)
