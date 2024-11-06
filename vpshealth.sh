#!/bin/bash

# Define color variables
GREEN="\033[0;32m"     # Green
YELLOW="\033[1;33m"    # Bright Yellow
NC="\033[0m"           # No Color

# Created by
CREATED_BY="CryptonodeHindi"
SOCIAL_INFO="Telegram: https://t.me/cryptonodehindi"

while true; do
    clear
    echo ""
    echo -e "${GREEN}=== VPS Monitoring Dashboard ===${NC}"
    echo "-------------------------------------------------"

    echo -e "${YELLOW}Created by: $CREATED_BY${NC}"
    echo -e "${YELLOW}$SOCIAL_INFO${NC}"
    echo "-------------------------------------------------"

    echo -e "${GREEN}Top 5 CPU Processes:${NC}"
    ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -6
    echo ""

    echo -e "${GREEN}CPU Usage:${NC}"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
    echo ""

  echo -e "${GREEN}Memory Usage:${NC}"
    free -m | grep Mem | awk '{print $3 " MB used / " $2 " MB total"}'
    echo ""

    echo -e "${GREEN}Disk Usage:${NC}"
    df -h | grep '/dev/' | awk '{print $5 " used on " $1}'
    echo ""

    echo -e "${GREEN}Docker Container Usage:${NC}"
    docker stats --no-stream

    sleep 7  # Update interval in seconds
done
