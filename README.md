# Infinite Box

A super cool and easy-to-use Dockerized environment with qBittorrent, FileBrowser, and more!

## Features

- **qBittorrent**: A powerful and easy-to-use BitTorrent client with a web-based user interface.
- **FileBrowser**: A simple file management and sharing web tool.

## Quick Start

### Installation

1. To quickly install Infinite Box, run the following commands:

    ```bash
    sudo wget https://raw.githubusercontent.com/Niraj-Dilshan/Infinite-box/main/infinitybox_install.sh
    chmod +x infinitybox_install.sh
    ./infinitybox_install.sh
    ```
2. Follow the prompts to configure ports for qBittorrent and FileBrowser.

3. Once the installation is complete, access your services:
    - qBittorrent: [http://localhost:8181](http://localhost:8181) (Default ports)
    - FileBrowser: [http://localhost:8180](http://localhost:8180) (Default ports)

    **FileBrowser Login Information:**
    - Username: admin
    - Password: admin

## Credits

This project uses the following Docker images:

- [LinuxServer/qBittorrent](https://hub.docker.com/r/linuxserver/qbittorrent): Docker image for qBittorrent.
- [FileBrowser/FileBrowser](https://hub.docker.com/r/filebrowser/filebrowser): Docker image for FileBrowser.

## License

This project is licensed under the [MIT License](LICENSE).