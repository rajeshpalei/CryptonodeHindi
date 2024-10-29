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

# Update package list
sudo apt update

# Install required packages if not already installed
REQUIRED_PACKAGES=(curl jq ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev git wget make build-essential pkg-config lsb-release libssl-dev libreadline-dev libffi-dev gcc screen unzip lz4)

for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg -l | grep -q "^ii  $package "; then
        echo -e "${YELLOW}Installing $package...${NC}"
        sudo apt install -y "$package" || { echo "Failed to install $package"; exit 1; }
    else
        echo -e "${YELLOW}$package is already installed.${NC}"
    fi
done

# Check for Docker installation
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"

    # Set up Docker repository
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo -e "${YELLOW}Docker installation complete.${NC}"
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
    sudo groupadd -f docker  # Avoid error if the group already exists
    sudo usermod -aG docker $USER || { echo "Failed to add user to Docker group"; exit 1; }
else
    echo -e "${YELLOW}User is already in the Docker group.${NC}"
fi

# Set Docker to start automatically when the system boots up
sudo systemctl enable docker

# Open port
sudo ufw allow 31333

# Thank you message
echo "==================================="
echo -e "${YELLOW}           CryptonodeHindi       ${NC}"
echo "==================================="
echo -e "${YELLOW}Telegram: https://t.me/cryptonodehindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CyptonodeHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cyptonodehindi${NC}"
echo -e "${YELLOW}Join our Telegram for any type of support${NC}"
echo "================================================="