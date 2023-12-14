# electron-dev - Dockerized Electron Development Environment

This repository provides a development environment for Electron using VSCode and Dev Container. It allows you to easily set up a local Electron environment for development purposes. It comes pre-installed with a bash script called `electron-dev`, which helps you manage various tasks such as creating a VNC virtual display, starting the Electron app and quitting the VNC virtual display.

## Prerequisites

Before using this repository, make sure you have the following installed on your system:

- Docker Desktop
- VSCode with Dev Container extension installed
- Alternative: Remote Repositories extension for VSCode
- VNC viewer installed (e.g., TigerVNC)

## Usage

To use the `electron-dev` script, run the following command:

```
electron-dev [COMMAND]
```

Available commands:

- `-h, --help`: Show the help message.
- `-c, --create-display`: Create a VNC virtual display.
- `-s, --start-app`: Start the Electron app.
- `-q, --quit-display`: Quit the VNC virtual display.

### How to use:

>1. Create a VNC virtual display by using command ***`electron-dev -c`*** in the VSCode terminal.
>2. Start TigerVNC and connect to ***`localhost:5900`***. Make sure that authentication is ***disabled***.
>3. Once connected, you can start your Electron app using command ***`electron-dev -s`***. Make sure that you are in the app directory before starting.