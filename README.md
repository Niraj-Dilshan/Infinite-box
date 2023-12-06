# Infinite Box

Welcome to Infinite Box, a super cool and easy-to-use Dockerized environment designed to empower users with seamless access to powerful tools like qBittorrent and FileBrowser. This is supper easy to use easy to setup more secure seedbox environment.

## Features

- **qBittorrent**: A powerful and easy-to-use BitTorrent client with a web-based user interface.
- **FileBrowser**: A simple file management and sharing web tool.
- **One Command Install**: Full script will run from single command

## Quick Start

### Installation

1. To quickly install Infinite Box, run the following commands:

    ```bash
    sudo rm -f infinitybox_install.sh && sudo rm -rf Infinite-box && sudo apt-get update && sudo apt-get install wget -y && sudo wget https://raw.githubusercontent.com/Niraj-Dilshan/Infinite-box/main/infinitybox_install.sh && chmod +x infinitybox_install.sh && ./infinitybox_install.sh
    ```
2. Follow the prompts to configure ports for qBittorrent and FileBrowser.

3. Once the installation is complete, access your services:
    - qBittorrent: [http://localhost:8181](http://localhost:8181) (Default ports)
    - FileBrowser: [http://localhost:8180](http://localhost:8180) (Default ports)

    **FileBrowser Login Information:**
    - Username: admin
    - Password: admin

## Infinite Box Project Overview

### Technologies Used

#### 1. qBittorrent

- **Description:** qBittorrent is an open-source BitTorrent client known for its powerful yet user-friendly interface. It supports advanced features such as sequential downloading, torrent prioritization, and provides a web-based UI for remote management.

- **Role in Project:** qBittorrent serves as the primary BitTorrent client, enabling users to download, upload, and manage torrents. Its web-based interface makes it accessible from anywhere.

#### 2. FileBrowser

- **Description:** FileBrowser is a straightforward web-based file management tool. It allows users to navigate, upload, download, and share files through an intuitive interface.

- **Role in Project:** FileBrowser complements qBittorrent by providing a web-based file management system. Users can organize, access, and share their downloaded files using FileBrowser.

## Project Architecture Overview

### Infinite Box Setup

The Infinite Box project combines qBittorrent and FileBrowser within a Dockerized environment for ease of deployment and management.

### Docker Containers

#### qBittorrent Container

- Hosts the qBittorrent application.
- Exposes a web-based user interface accessible at [http://localhost:8181](http://localhost:8181).
- Downloads and manages torrents on the host system.

#### FileBrowser Container

- Hosts the FileBrowser application.
- Provides a web-based file management interface at [http://localhost:8180](http://localhost:8180).
- Allows users to navigate, upload, and download files.

#### Interaction

- Users interact with the qBittorrent and FileBrowser interfaces through web browsers. qBittorrent manages BitTorrent activities, while FileBrowser handles file management.

#### Configuration

- The project utilizes a configuration file (`.env`) for customization, allowing users to set ports and other parameters during installation.

#### Ease of Use

- The installation script (`infinitybox_install.sh`) streamlines the setup process, prompting users for necessary configurations.

#### Portability

- Docker containers ensure portability and easy deployment across different environments.

This architecture provides users with a seamless and accessible solution for torrenting and file management through a unified and user-friendly web interface.

## Credits

This project uses the following Docker images:

- [LinuxServer/qBittorrent](https://hub.docker.com/r/linuxserver/qbittorrent): Docker image for qBittorrent.
- [FileBrowser/FileBrowser](https://hub.docker.com/r/filebrowser/filebrowser): Docker image for FileBrowser.

## License

This project is licensed under the [MIT License](LICENSE).
