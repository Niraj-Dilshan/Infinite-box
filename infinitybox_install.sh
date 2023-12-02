#!/bin/bash

# Colors for text formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display custom ASCII art message
display_custom_message() {
    echo -e "${YELLOW}
ooooo oooo   oooo ooooooooooo ooooo oooo   oooo ooooo ooooooooooo ooooo  oooo      oooooooooo    ooooooo   ooooo  oooo 
 888   8888o  88   888    88   888   8888o  88   888  88  888  88   888  88         888    888 o888   888o   888  88   
 888   88 888o88   888ooo8     888   88 888o88   888      888         888           888oooo88  888     888     888     
 888   88   8888   888         888   88   8888   888      888         888           888    888 888o   o888    88 888   
o888o o88o    88  o888o       o888o o88o    88  o888o    o888o       o888o         o888ooo888    88ooo88   o88o  o888o 
${NC}"
}

# Function to check the Linux distribution
check_distribution() {
    if [ -f "/etc/os-release" ]; then
        source /etc/os-release
        DISTRIBUTION=$ID
    elif [ -f "/etc/lsb-release" ]; then
        source /etc/lsb-release
        DISTRIBUTION=$DISTRIB_ID
    else
        echo -e "${RED}Unable to determine the Linux distribution. Exiting.${NC}"
        exit 1
    fi
}

# Function to perform system updates based on the distribution
perform_system_updates() {
    echo -e "${YELLOW}Updating system...${NC}"
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt update && apt upgrade -y
            ;;
        "fedora")
            dnf update -y
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $DISTRIBUTION. Exiting.${NC}"
            exit 1
            ;;
    esac
}

# Function to install Docker based on the distribution
install_docker() {
    echo -e "${YELLOW}Installing Docker...${NC}"
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install docker.io -y
            ;;
        "fedora")
            dnf install docker -y
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $DISTRIBUTION. Exiting.${NC}"
            exit 1
            ;;
    esac
}

# Function to install Docker Compose based on the distribution
install_docker_compose() {
    echo -e "${YELLOW}Installing Docker Compose...${NC}"
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install docker-compose -y
            ;;
        "fedora")
            dnf install docker-compose -y
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $DISTRIBUTION. Exiting.${NC}"
            exit 1
            ;;
    esac
}

# Function to get user input for port numbers and update the .env file
get_user_input() {
    read -p "Enter the qBittorrent web UI port (default: 8181): " QB_PORT
    QB_PORT=${QB_PORT:-8181}

    read -p "Enter the File Server port (default: 8180): " FILE_SERVER_PORT
    FILE_SERVER_PORT=${FILE_SERVER_PORT:-8180}

    # Update .env file
    echo "WEBUI_PORT=$QB_PORT" > .env
    echo "FILE_SERVER_PORT=$FILE_SERVER_PORT" >> .env
}

# Display the custom ASCII art message
display_custom_message

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git is not installed. Installing Git...${NC}"
    check_distribution
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install git -y
            ;;
        "fedora")
            dnf install git -y
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $DISTRIBUTION. Exiting.${NC}"
            exit 1
            ;;
    esac
fi

# Clone the GitHub repository
echo -e "${YELLOW}Cloning the Infinite-box repository...${NC}"
git clone https://github.com/Niraj-Dilshan/Infinite-box.git

# Change into the repository directory
cd Infinite-box || exit

# Check the Linux distribution
check_distribution

# Perform system updates
perform_system_updates

# Get user input for port numbers and update the .env file
get_user_input

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    install_docker
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    install_docker_compose
fi

# Display a warning about overwriting existing containers
read -p "${YELLOW}Warning: This script will attempt to recreate containers. Do you want to continue? (y/n): ${NC}" -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Installation aborted.${NC}"
    exit 1
fi

# Pull Docker images
docker-compose pull

# Create and start the Docker containers
docker-compose up -d

echo -e "${GREEN}Installation completed successfully INFINITY Box is up and ready.${NC}"

# Retrieve port numbers from the .env file
QB_PORT=$(grep WEBUI_PORT .env | cut -d '=' -f2)
FILE_SERVER_PORT=$(grep FILE_SERVER_PORT .env | cut -d '=' -f2)

# Get the machine's IP address
MACHINE_IP=$(hostname -I | cut -d ' ' -f1)

echo -e "${YELLOW}Access qBittorrent at: http://${MACHINE_IP}:${QB_PORT}${NC}"
echo -e "${YELLOW}Access File Server at: http://${MACHINE_IP}:${FILE_SERVER_PORT}${NC}"

# Display FileBrowser login information
echo -e "${YELLOW}FileBrowser Login Information:${NC}"
echo -e "URL: http://${MACHINE_IP}:${FILE_SERVER_PORT}"
echo -e "Username: admin"
echo -e "Password: admin${NC}"