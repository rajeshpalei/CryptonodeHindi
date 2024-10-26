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

# Install jq
echo "Installing jq..."
sudo apt update
sudo apt install -y jq
echo "jq installed successfully."

#follow in telegram:https://t.me/cryptonodehindi
#suscribe in youtube :https://www.youtube.com/@CyptonodeHindi

# Install Docker
echo "Installing Docker..."
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
echo "Docker installed successfully."

# Check if the directory exists
if [ -d "rivalz-docker" ]; then
  echo "Directory rivalz-docker already exists."
else
  # Create the directory
  mkdir rivalz-docker
  echo "Directory rivalz-docker created."
fi

# Navigate into the directory
cd rivalz-docker

# Fetch the latest version of rivalz-node-cli
version=$(curl -s https://be.rivalz.ai/api-v1/system/rnode-cli-version | jq -r '.data')

# Set latest version if version retrieval fails
if [ -z "$version" ]; then
    version="latest"
    echo "Could not fetch the version. Defaulting to latest."
fi

# Create or replace the Dockerfile with the specified content
cat <<EOL > Dockerfile
FROM ubuntu:latest
# Disable interactive configuration
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system
RUN apt-get update && apt-get install -y curl jq nano

# Install Node.js from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \\
    apt-get install -y nodejs

RUN npm install -g npm

# Install the rivalz-node-cli package globally using npm
RUN npm install -g rivalz-node-cli@$version

EOL

# Add the common CMD instruction for all cases
cat <<EOL >> Dockerfile
# Run the rivalz command and then open a shell
CMD ["bash", "-c", "cd /usr/lib/node_modules/rivalz-node-cli && npm install && rivalz run; exec /bin/bash"]
EOL

# Detect existing rivalz-docker instances and find the highest instance number
existing_instances=$(docker ps -a --filter "name=rivalz-docker-" --format "{{.Names}}" | grep -Eo 'rivalz-docker-[0-9]+' | grep -Eo '[0-9]+' | sort -n | tail -1)

# Set the instance number
if [ -z "$existing_instances" ]; then
  instance_number=1
else
  instance_number=$((existing_instances + 1))
fi

# Set the container name
container_name="rivalz-docker-$instance_number"

# Build the Docker image with the specified name
docker build -t $container_name .

# Display the completion message
echo -e "\e[32mSetup is complete. To run the Docker container, use the following command:\e[0m"
echo "docker run -it --name $container_name $container_name"

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