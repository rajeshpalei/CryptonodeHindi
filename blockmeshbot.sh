#!/bin/bash

# Define color variables
GREEN="\033[0;32m"     # Green
YELLOW="\033[1;33m"    # Bright Yellow
NC="\033[0m"           # No Color

# Display social details and channel information
echo "==================================="
echo -e "${GREEN}           CryptonodeHindi       ${NC}"
echo "==================================="
echo -e "${YELLOW}Telegram: https://t.me/cryptonodehindi${NC}"
echo -e "${YELLOW}Twitter: @CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CyptonodeHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cyptonodehindi${NC}"
echo "==================================="

# Ask for user confirmation
read -p "Do you want to proceed with the BlockMesh Node installation? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Installation aborted."
    exit 0
fi

# Check if screen is installed
if ! command -v screen &> /dev/null; then
    echo "Screen is not installed. Installing..."
    sudo apt install screen -y
else
    echo "Screen is already installed. Skipping installation."
fi

# Download Blockmesh CLI
echo "Downloading Blockmesh CLI..."
wget https://github.com/block-mesh/block-mesh-monorepo/releases/download/v0.0.307/blockmesh-cli-x86_64-unknown-linux-gnu.tar.gz

# Extracting Blockmesh CLI archive
echo "Extracting Blockmesh CLI..."
tar -xvzf blockmesh-cli-x86_64-unknown-linux-gnu.tar.gz

# Remove the tar file after extraction
echo "Cleaning up..."
rm blockmesh-cli-x86_64-unknown-linux-gnu.tar.gz

# Confirmation of installation completion
echo "Blockmesh node installation is done."

# Thank you message
echo "==================================="
echo -e "${GREEN}    Thanks for using this script!${NC}"
echo "==================================="
echo -e "${YELLOW}Twitter: @CryptonodeHindi${NC}"
echo -e "${YELLOW}YouTube: https://www.youtube.com/@CyptonodeHindi${NC}"
echo -e "${YELLOW}Medium: https://medium.com/@cyptonodehindi${NC}"
echo -e "${YELLOW}Join our Telegram for any support: https://t.me/cryptonodehindi${NC}"
echo "======================================================================"
