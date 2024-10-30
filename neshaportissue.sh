#!/bin/bash
# Define color variables
GREEN="\033[0;32m"     # Green
YELLOW="\033[1;33m"    # Bright Yellow
NC="\033[0m"           # No Color

# Display social details and channel information
echo "==================================================="
echo -e "${YELLOW}     This script is for the PORT conflicts error issue       ${NC}"
echo "==================================================="
      
# Prompt for confirmation to start the script
read -p "Do you want to proceed with stopping the containers and updating the compose file? (y/n): " CONFIRM

# Define the container names to look for
CONTAINERS=("mongodb/mongodb-community-server:6.0-ubi8" "containrrr/watchtower")

# Loop through the container names
for CONTAINER in "${CONTAINERS[@]}"; do
    # Find the container ID using the image name
    CONTAINER_ID=$(docker ps -q --filter "ancestor=$CONTAINER")

    # Check if the container ID was found
    if [ -n "$CONTAINER_ID" ]; then
        echo "Stopping container: $CONTAINER_ID ($CONTAINER)"
        docker stop "$CONTAINER_ID"
        
        # Update the compose file
        echo -e "${GREEN}Updating compose file...${NC}"
        sed -i 's/8080:8080/8087:8080/' ~/.nesa/docker/compose.ipfs.yml
    else
        echo -e "${GREEN}No running container found for: $CONTAINER${NC}"
    fi
done

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