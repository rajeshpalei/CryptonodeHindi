#!/bin/bash

# Define color variables
GREEN="\033[0;32m"     # Green
YELLOW="\033[1;33m"    # Bright Yellow
RED="\033[0;31m"       # Red
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

# Update package lists and upgrade installed packages
echo -e "${YELLOW}Updating and upgrading system packages...${NC}"
sudo apt update -y && sudo apt upgrade -y

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker is already installed, skipping Docker installation.${NC}"
else
    # Install dependencies for Docker installation
    echo -e "${YELLOW}Installing required dependencies for Docker...${NC}"
    sudo apt install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common \
      lsb-release \
      gnupg2

    # Add Docker's official GPG key
    echo -e "${YELLOW}Adding Docker's official GPG key...${NC}"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker repository
    echo -e "${YELLOW}Adding Docker repository...${NC}"
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update package lists to include Docker's repository
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo apt update -y

    # Install Docker
    echo -e "${YELLOW}Installing Docker...${NC}"
    sudo apt install -y docker-ce docker-ce-cli containerd.io

    # Check if Docker is installed successfully
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}Docker installation failed!${NC}"
        exit 1
    else
        echo -e "${YELLOW}Docker is successfully installed!${NC}"
    fi
fi

# Check if Docker Compose is already installed
if command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}Docker Compose is already installed, skipping Docker Compose installation.${NC}"
else
    echo -e "${YELLOW}Docker Compose not found. Installing Docker Compose...${NC}"
    VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    curl -L "https://github.com/docker/compose/releases/download/$VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    echo -e "${YELLOW}Docker Compose has been installed!${NC}"
fi

# Add current user to Docker group
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "Adding user to Docker group..."
    sudo groupadd docker
    sudo usermod -aG docker $USER
else
    echo "User is already in the Docker group."
fi

# Pull the Titan Docker image
docker pull nezha123/titan-edge

# Create the Titan directory
mkdir ~/.titanedge

# Change to that directory
cd ~/.titanedge

# Run the Titan Docker edge
docker run --network=host -d -v ~/.titanedge:/root/.titanedge nezha123/titan-edge 

# Prompt for Titan identity code
echo -e "${YELLOW}Enter your Titan identity code: ${NC}"
read identity_code  # Read input from the user

# Bind the identity code to the device
docker run --rm -it -v ~/.titanedge:/root/.titanedge nezha123/titan-edge bind --hash="$identity_code" https://api-test1.container1.titannet.io/api/v2/device/binding

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
