#!/bin/bash

echo "Starting system monitoring (Ctrl+C to stop)..."
echo "----------------------------------------------"

# Detect OS
OS=$(uname)

while true
do
    heure=$(date '+%H:%M:%S')

    if [[ "$OS" == "Linux" ]]; then
        # Linux: Get CPU load and available memory
        charge=$(uptime | awk -F'load average: ' '{ print $2 }' | cut -d',' -f1)
        mem_dispo=$(free -m | awk '/Mem:/ { print $7 }')

    elif [[ "$OS" == "Darwin" ]]; then
        # macOS: Get CPU load and available memory
        charge=$(uptime | awk -F'load averages?: ' '{ print $2 }' | cut -d' ' -f1)
        pages_free=$(vm_stat | grep "Pages free" | awk '{ print $3 }' | sed 's/\.//')
        page_size=4096
        mem_dispo=$((pages_free * page_size / 1024 / 1024)) # Convert to MB

    else
        echo "Unsupported OS: $OS"
        exit 1
    fi

    echo "[${heure}] CPU Load: ${charge} | Available RAM: ${mem_dispo} MB"
    sleep 0.5
done
