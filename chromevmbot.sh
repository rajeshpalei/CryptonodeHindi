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

# Update VPS
echo -e "${YELLOW}Updating VPS...${NC}"
sudo apt-get update && sudo apt-get upgrade -y

# Install prerequisites
echo -e "${YELLOW}Installing Dependencies...${NC}"
sudo apt install -y curl ca-certificates

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Installing Docker...${NC}"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    docker --version
else
    echo -e "${YELLOW}Docker is already installed. Skipping Docker installation.${NC}"
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}Installing Docker Compose...${NC}"
    VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    curl -L "https://github.com/docker/compose/releases/download/$VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
else
    echo -e "${YELLOW}Docker Compose is already installed. Skipping Docker Compose installation.${NC}"
fi

# Prompt for CUSTOM_USER and PASSWORD
read -p "Enter CUSTOM_USER (username): " custom_user
read -s -p "Enter PASSWORD: " password
echo ""  # New line for better readability

# Set up Chromium project directory
echo -e "${YELLOW}Creating the Docker Chromium directory...${NC}"
mkdir -p ~/chromium
cd ~/chromium

# Create docker-compose.yml
echo -e "${YELLOW}Creating docker-compose.yml...${NC}"
cat <<EOF > docker-compose.yml
version: "3.8"
services:
  chromium:
    image: lscr.io/linuxserver/chromium:latest
    container_name: chromium_browser
    environment:
      - PUID=1000  # User ID for file permissions
      - PGID=1000  # Group ID for file permissions
      - TZ=Europe/Berlin  # Adjust timezone
      - CUSTOM_USER=${custom_user}  # Set your own username
      - PASSWORD=${password}  # Set your password
      - CHROME_CLI=https://www.google.com  # Optional: Default starting page
    ports:
      - "3050:3000"  # Adjust ports if necessary
      - "3051:3001"
    security_opt:
      - seccomp:unconfined
    volumes:
      - ~/chromium/config:/config  # Config directory for Chromium
    shm_size: "1gb"  # Prevents crashes by giving the container enough shared memory
    restart: unless-stopped  # Automatically restart on failures or reboots
EOF

# Start Chromium container
echo -e "${YELLOW}Starting Chromium container...${NC}"
docker-compose up -d

echo -e "${YELLOW}Chromium container setup completed! You can access it via the configured ports (3050:3000, 3051:3001), e.g., http://<ipaddress>:3050.${NC}"

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
