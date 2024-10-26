#!/bin/bash

# Display social details and channel information
echo "==================================="
echo "           CryptonodeHindi       "
echo "==================================="
echo "Telegram: https://t.me/cryptonodehindi"
echo "Twitter: @CryptonodeHindi"
echo "YouTube: https://www.youtube.com/@CyptonodeHindi"
echo "Medium: https://medium.com/@cyptonodehindi"
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
echo "    Thanks for using this script!"
echo "==================================="
echo "Please follow my social links:"
echo "Twitter: @CryptonodeHindi"
echo "YouTube: https://www.youtube.com/@CyptonodeHindi"
echo "Medium: https://medium.com/@cyptonodehindi"
echo "Join our Telegram for any support: https://t.me/cryptonodehindi"
echo "======================================================================"
