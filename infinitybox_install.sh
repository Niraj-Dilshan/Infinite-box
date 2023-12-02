#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker before running this script."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose before running this script."
    exit 1
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