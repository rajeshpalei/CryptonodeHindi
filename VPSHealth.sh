#!/bin/bash

# Define color variables
GREEN="\033[0;32m"     # Green
YELLOW="\033[1;33m"    # Bright Yellow
NC="\033[0m"           # No Color

# Display social details and channel information
echo "==================================="
echo -e "${YELLOW}           CryptonodeHindi       ${NC}"
echo "==================================="
echo -e "${YELLOW}Telegram: https://t.me/cryptonodehindi${NC}"
echo -e "${YELLOW}Twitter: @CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CryptonodesHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cryptonodehindi${NC}"
echo "==================================="

# Download the script
wget -q https://raw.githubusercontent.com/rajeshpalei/CryptonodeHindi/refs/heads/main/VPStest.sh && chmod +x VPStest.sh

# Install Glances
if ! command -v glances &> /dev/null; then
    echo -e "${YELLOW}Installing Glances...${NC}"
    sudo apt update && sudo apt install -y glances
else
    echo -e "${GREEN}Glances is already installed.${NC}"
fi

# Install HTOP
if ! command -v htop &> /dev/null; then
    echo -e "${YELLOW}Installing HTOP...${NC}"
    sudo apt install -y htop
else
    echo -e "${GREEN}Htop is already installed.${NC}"
fi

# Thank you message
echo "==================================="
echo -e "${YELLOW}           CryptonodeHindi       ${NC}"
echo "==================================="
echo -e "${GREEN}    Thanks for using this script!${NC}"
echo "==================================="
echo -e "${YELLOW}Twitter: @CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CryptonodesHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cryptonodehindi${NC}"
echo -e "${YELLOW}Join our Telegram for any support: https://t.me/cryptonodehindi${NC}"
echo "======================================================================"
