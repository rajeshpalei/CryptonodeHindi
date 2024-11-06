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
wget -q https://raw.githubusercontent.com/rajeshpalei/CryptonodeHindi/refs/heads/main/vpshealth.sh && chmod +x vpshealth.sh

# Install CryptonodeHindi
if ! command -v glances &> /dev/null; then
    echo -e "${YELLOW}Installing CryptonodeHindi tools...${NC}"
    sudo apt update && sudo apt install -y glances
else
    echo -e "${GREEN}CryptonodeHindi tools are already installed.${NC}"
fi

# Install CnHindi 
if ! command -v htop &> /dev/null; then
    echo -e "${YELLOW}Installing CnHindi...${NC}"
    sudo apt install -y htop
else
    echo -e "${GREEN}CnHindi tools is already installed.${NC}"
fi

# Add alias for CryptonodeHindi and CnHindi to ~/.bashrc
echo "alias cryptonodehindi='glances'" >> ~/.bashrc
echo "alias cnhindi='htop'" >> ~/.bashrc

# Display message that user needs to reload their shell or source ~/.bashrc
echo -e "${YELLOW}The tools have been successfully installed in your VPS.${NC}"
echo -e "${GREEN}Please run 'source ~/.bashrc' or restart your terminal to monitor your VPS Health${NC}"

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
