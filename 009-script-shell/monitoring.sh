#!/bin/bash

# monitoring.sh : Affiche periodiquement la charge CPU, la memoire disponible, et l'heure.

echo "Demarrage du monitoring système (Ctrl+C pour arrêter)..."
echo "----------------------------------------------"

while true
do
    # Heure actuelle
    heure=$(date '+%H:%M:%S')

    # Charge CPU (moyenne sur 1 minute)
    charge=$(uptime | awk -F'load average: ' '{ print $2 }' | cut -d',' -f1)

    # Memoire vive disponible (en MB)
    mem_dispo=$(free -m | awk '/Mem:/ { print $7 }')

    echo "[${heure}] Charge CPU: ${charge} | Memoire disponible: ${mem_dispo} MB"
    
    # Pause de 0.5 seconde
    sleep 0.5
done
