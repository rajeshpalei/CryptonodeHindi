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
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CyptonodeHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cyptonodehindi${NC}"
echo "==================================="

# Install required packages
sudo apt install -y ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables curl nvme-cli git wget make jq libleveldb-dev build-essential pkg-config ncdu tar clang bsdmainutils lsb-release libssl-dev libreadline-dev libffi-dev gcc screen unzip lz4

# Add Docker GPG key and repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update

# Check for Docker installation
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
else
    echo -e "${YELLOW}Docker is already installed.${NC}"
fi

# Check for Docker Compose installation
if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}Docker Compose not found. Installing Docker Compose...${NC}"
    VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    curl -L "https://github.com/docker/compose/releases/download/$VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
else
    echo -e "${YELLOW}Docker Compose is already installed.${NC}"
fi

# Add current user to Docker group
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "Adding user to Docker group..."
    sudo groupadd docker
    sudo usermod -aG docker $USER
else
    echo "User is already in the Docker group."
fi

# Create SixGPT dir
mkdir -p sixgpt


# Thank you message
echo "==================================="
echo -e "${YELLOW}           CryptonodeHindi       ${NC}"
echo "==================================="
echo -e "${GREEN}    Thanks for using this script!${NC}"
echo "==================================="
echo -e "${YELLOW}Twitter: @CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CyptonodeHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cyptonodehindi${NC}"
echo -e "${YELLOW}Join our Telegram for any support: https://t.me/cryptonodehindi${NC}"
echo "======================================================================"

# Exit the script successfully
exit 0
