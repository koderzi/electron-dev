# Dockerized Electron Development Environment

This repository provides a self-contained development environment for Electron using VS Code and Dev Containers.

It creates an isolated Docker container with all the necessary dependencies and provides a virtual desktop accessible through your web browser. The environment defaults to a non-root user for enhanced security, making it a safe and clean way to build and test your application.

## Key Features

* **Isolated Environment**: All dependencies for your Electron app are managed within the container, keeping your host machine clean.
* **Browser-Based GUI**: No need to install a separate VNC client. The container's desktop is streamed directly to a browser tab.
* **No Port Collisions**: The environment uses dynamic port mapping, allowing you to run multiple instances without conflicts.
* **Rootless by Default**: Terminals and commands run as a non-root `node` user for better security.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

* **Docker Desktop**
* **Visual Studio Code** with the **Dev Containers** extension

## How to Use

1.  **Open in Container**: Open this project folder in VS Code. A notification will appear in the bottom-right corner; click **"Reopen in Container"**.

2.  **Wait for Build**: The first time you open it, the Dev Container will build. This may take a few minutes.

3.  **Access the Desktop**: Once the build is complete, VS Code will automatically forward a port and open a new tab in your web browser displaying the container's Linux desktop.

4.  **Configure `package.json`**: Make sure your `start` script in your `package.json` file includes the **`--no-sandbox`** flag. This is required for Electron to start in this environment.

    ```json
    "scripts": {
      "start": "electron . --no-sandbox"
    }
    ```

5.  **Start Your App**:
    * Open a new terminal in VS Code (**Terminal** > **New Terminal**). The prompt will show you are the `node` user.
    * In that terminal, simply run the start command:
        ```bash
        npm start
        ```

Your Electron app's window will appear inside the browser tab that's showing the virtual desktop.

***

## Installing Additional Software

Because the terminal runs as the non-root `node` user, you must use `sudo` to perform administrative tasks, such as installing new packages.

**Example:**

```bash
sudo apt-get update && sudo apt-get install -y <package-name>