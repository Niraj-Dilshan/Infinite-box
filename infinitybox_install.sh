#!/bin/bash

# Function to check the Linux distribution
check_distribution() {
    if [ -f "/etc/os-release" ]; then
        source /etc/os-release
        DISTRIBUTION=$ID
    elif [ -f "/etc/lsb-release" ]; then
        source /etc/lsb-release
        DISTRIBUTION=$DISTRIB_ID
    else
        echo "Unable to determine the Linux distribution. Exiting."
        exit 1
    fi
}

# Function to perform system updates based on the distribution
perform_system_updates() {
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt update && apt upgrade -y
            ;;
        "fedora")
            dnf update -y
            ;;
        *)
            echo "Unsupported distribution: $DISTRIBUTION. Exiting."
            exit 1
            ;;
    esac
}

# Function to install Docker based on the distribution
install_docker() {
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install docker.io -y
            ;;
        "fedora")
            dnf install docker -y
            ;;
        *)
            echo "Unsupported distribution: $DISTRIBUTION. Exiting."
            exit 1
            ;;
    esac
}

# Function to install Docker Compose based on the distribution
install_docker_compose() {
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install docker-compose -y
            ;;
        "fedora")
            dnf install docker-compose -y
            ;;
        *)
            echo "Unsupported distribution: $DISTRIBUTION. Exiting."
            exit 1
            ;;
    esac
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    check_distribution
    case $DISTRIBUTION in
        "ubuntu" | "debian")
            apt install git -y
            ;;
        "fedora")
            dnf install git -y
            ;;
        *)
            echo "Unsupported distribution: $DISTRIBUTION. Exiting."
            exit 1
            ;;
    esac
fi

# Clone the GitHub repository
echo "Cloning the Infinite-box repository..."
git clone https://github.com/Niraj-Dilshan/Infinite-box.git

# Change into the repository directory
cd Infinite-box || exit

# Check the Linux distribution
check_distribution

# Perform system updates
echo "Updating system..."
perform_system_updates

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    install_docker
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Installing Docker Compose..."
    install_docker_compose
fi

# Check if the .env file exists
if [ ! -f .env ]; then
    echo "Error: The .env file is missing. Please create the .env file with the required environment variables."
    exit 1
fi

# Display a warning about overwriting existing containers
read -p "Warning: This script will attempt to recreate containers. Do you want to continue? (y/n): " -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

# Pull Docker images
docker-compose pull

# Create and start the Docker containers
docker-compose up -d

echo "Installation completed successfully."