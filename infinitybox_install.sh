#!/bin/bash

# Colors for text formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    install_docker
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    install_docker_compose
fi

# Check if the .env file exists
if [ ! -f .env ]; then
    echo -e "${RED}Error: The .env file is missing. Please create the .env file with the required environment variables.${NC}"
    exit 1
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

echo -e "${GREEN}Installation completed successfully.${NC}"