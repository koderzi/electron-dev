# Dockerized Electron Development Environment

This repository provides a self-contained development environment for Electron using VS Code and Dev Containers.

It creates an isolated Docker container with all the necessary dependencies and provides a virtual desktop accessible through your web browser. The environment defaults to a non-root user for enhanced security, making it a safe and clean way to build and test your application.

## Key Features

* **Isolated Environment**: All dependencies for your Electron app are managed within the container, keeping your host machine clean.
* **Browser-Based GUI**: No need to install a separate VNC client. The container's desktop is streamed directly to a browser tab.
* **No Port Collisions**: The environment uses dynamic port mapping, allowing you to run multiple instances without conflicts.
* **Rootless by Default**: Terminals and commands run as a non-root `node` user for better security.
* **Pre-configured**: Comes with Node.js, npm, and all necessary system libraries for Electron development.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

* **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop)
  * Make sure Docker Desktop is running before opening the project
* **Visual Studio Code** - [Download here](https://code.visualstudio.com/)
* **Dev Containers Extension** for VS Code - [Install from VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
  * Alternatively, search for "Dev Containers" in the VS Code Extensions panel

## Getting Started Tutorial

### Step 1: Clone This Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/koderzi/electron-dev.git
cd electron-dev
```

### Step 2: Open in VS Code

Open the project folder in Visual Studio Code:

```bash
code .
```

Or use **File > Open Folder** from within VS Code and select the `electron-dev` folder.

### Step 3: Reopen in Container

When you open the project, VS Code will detect the `.devcontainer` configuration:

1. A notification will appear in the bottom-right corner saying: **"Folder contains a Dev Container configuration file"**
2. Click **"Reopen in Container"**
   * If you miss the notification, you can also:
     * Press `F1` or `Ctrl+Shift+P` (Windows/Linux) / `Cmd+Shift+P` (Mac)
     * Type "Dev Containers: Reopen in Container"
     * Press Enter

### Step 4: Wait for Container Build

The first time you open the container, Docker will:
* Download the base Node.js image
* Install system dependencies (Electron libraries, GUI tools, etc.)
* Set up the desktop environment

**This may take 5-10 minutes depending on your internet speed.** You'll see a progress notification in VS Code. Subsequent opens will be much faster as Docker caches the image.

### Step 5: Open the Browser Desktop

Once the container is built and running, VS Code will automatically:

1. **Forward port 6080** - This is the port for the virtual desktop
2. **Open a browser tab** showing the Linux desktop environment

**If the browser doesn't open automatically:**
* Look for the **PORTS** tab in VS Code's bottom panel (next to TERMINAL, PROBLEMS, etc.)
* Find the port labeled **"Desktop GUI (6080)"**
* Click the **globe icon** (🌐) or the **"Open in Browser"** link to open it manually

You should now see a Linux desktop environment running in your browser! This is where your Electron app will appear.

### Step 6: Create Your Electron Project

Now let's create a simple Electron application inside the container:

1. **Open a terminal** in VS Code:
   * Go to **Terminal > New Terminal** or press `` Ctrl+` ``
   * You'll see a prompt like `node@xxxxx:~/workspace$` - this confirms you're inside the container

2. **Initialize a new Node.js project:**

   ```bash
   npm init -y
   ```

3. **Install Electron:**

   ```bash
   npm install electron --save-dev
   ```

4. **Create the main Electron file** (`main.js`):

   You can create this file using your preferred text editor in VS Code, or use the command line:

   ```bash
   cat > main.js << 'EOF'
   const { app, BrowserWindow } = require('electron')
   
   function createWindow () {
     const win = new BrowserWindow({
       width: 800,
       height: 600,
       webPreferences: {
         nodeIntegration: false,
         contextIsolation: true
       }
     })
   
     win.loadFile('index.html')
   }
   
   app.whenReady().then(() => {
     createWindow()
   
     app.on('activate', () => {
       if (BrowserWindow.getAllWindows().length === 0) {
         createWindow()
       }
     })
   })
   
   app.on('window-all-closed', () => {
     if (process.platform !== 'darwin') {
       app.quit()
     }
   })
   EOF
   ```

   **Note:** This example uses secure defaults (`nodeIntegration: false`, `contextIsolation: true`) to protect against security vulnerabilities. If you need Node.js functionality in your renderer, use IPC communication via `preload` scripts.

5. **Create an HTML file** (`index.html`):

   You can create this file using your preferred text editor in VS Code, or use the command line:

   ```bash
   cat > index.html << 'EOF'
   <!DOCTYPE html>
   <html>
   <head>
       <meta charset="UTF-8">
       <title>Hello Electron!</title>
       <style>
         body {
           font-family: Arial, sans-serif;
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           margin: 0;
           background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
           color: white;
         }
         .container {
           text-align: center;
         }
         h1 {
           font-size: 3em;
           margin: 0;
         }
       </style>
   </head>
   <body>
       <div class="container">
         <h1>🚀 Hello Electron!</h1>
         <p>You are running Electron in a Docker container!</p>
         <p id="versions"></p>
       </div>
       <script>
         // Display version information safely without Node integration
         document.getElementById('versions').innerHTML = 
           'Chrome: ' + navigator.userAgent.match(/Chrome\/(\S+)/)[1];
       </script>
   </body>
   </html>
   EOF
   ```

### Step 7: Configure package.json

**IMPORTANT:** Electron requires the `--no-sandbox` flag to run in Docker containers.

Edit your `package.json` and add/modify the `main` and `scripts` sections:

```json
{
  "name": "my-electron-app",
  "version": "1.0.0",
  "description": "My Electron App",
  "main": "main.js",
  "scripts": {
    "start": "electron . --no-sandbox"
  },
  "devDependencies": {
    "electron": "^33.0.0"
  }
}
```

### Step 8: Run Your Electron App

Now you're ready to launch your Electron app!

1. **In the VS Code terminal**, run:

   ```bash
   npm start
   ```

2. **Switch to your browser tab** that's showing the Linux desktop

3. **You should see your Electron app window appear!** 🎉

The app will display "Hello Electron!" with version information.

### Step 9: Develop Your App

You can now:
* Edit your code in VS Code
* Save changes
* Restart the app with `npm start` to see updates
* Use browser DevTools in your Electron app (right-click > Inspect Element)

## How to Access the Browser Desktop

The browser-based desktop is the key feature of this environment. Here's everything you need to know:

### Accessing the Desktop

**Automatic Access:**
* When the container starts, VS Code automatically opens the desktop in your default browser
* The URL will be something like: `http://localhost:<port>` where the port is dynamically assigned

**Manual Access:**
1. Look at the **PORTS** tab in VS Code's bottom panel
2. Find port **6080** with the label **"Desktop GUI"**
3. Click the **globe icon** (🌐) or right-click and select **"Open in Browser"**

**Direct URL:**
* If you know the forwarded port, you can access it directly: `http://localhost:<port>`
* Check the PORTS tab to find the exact port number

### Desktop Features

The browser desktop provides:
* A full Linux desktop environment (XFCE)
* Window management (minimize, maximize, close)
* File manager
* Terminal applications
* Your Electron apps will run here

### Desktop Controls

* **Full Screen:** Most browsers support full-screen mode (F11)
* **Zoom:** Use your browser's zoom controls (Ctrl/Cmd + Plus/Minus)
* **Clipboard:** Copy/paste between your host machine and the desktop may have limitations

## Troubleshooting

### Browser Desktop Doesn't Open

**Problem:** The browser tab doesn't open automatically after container starts.

**Solutions:**
1. Check the **PORTS** tab in VS Code - look for port 6080
2. Wait a few seconds - the desktop service might still be starting
3. Click the globe icon next to port 6080 to open manually
4. Check that Docker Desktop is running
5. Rebuild the container: `F1` > "Dev Containers: Rebuild Container"

### Electron App Doesn't Start

**Problem:** Running `npm start` gives an error or the app doesn't appear.

**Solutions:**
1. **Verify the `--no-sandbox` flag** is in your start script
2. **Check you're in the right directory** with your `package.json`
3. **Ensure Electron is installed:** Run `npm install`
4. **Look at the terminal output** for specific error messages
5. **Make sure the browser desktop is open** - switch to that tab

### "Cannot open display" Error

**Problem:** Error message says `Error: Cannot open display`

**Solution:** 
* This means Electron can't connect to the display server
* Make sure you're running inside the Dev Container (check the bottom-left corner of VS Code - it should show "Dev Container: electron-dev")
* Rebuild the container if needed

### Port 6080 Not Forwarded

**Problem:** Port 6080 doesn't appear in the PORTS tab.

**Solutions:**
1. Wait a moment - port forwarding happens after the container fully starts
2. Manually forward the port: 
   * Click **"Forward a Port"** in the PORTS tab
   * Enter `6080`
3. Check `.devcontainer/devcontainer.json` has the port configuration
4. Restart VS Code

### App Window is Too Small/Large

**Solution:**
* Use your browser's zoom controls (Ctrl/Cmd + Plus/Minus)
* Adjust the window size on the desktop by dragging corners
* Edit the `width` and `height` in your `main.js` BrowserWindow configuration

## Installing Additional Software

The terminal runs as the non-root `node` user, but you have sudo privileges. To install additional packages:

```bash
sudo apt-get update
sudo apt-get install -y <package-name>
```

**Examples:**

```bash
# Install Git tools
sudo apt-get install -y git-gui gitk

# Install text editor
sudo apt-get install -y gedit

# Install additional build tools
sudo apt-get install -y build-essential
```

## Managing Your Container

### Stopping the Container

When you close VS Code, the container automatically stops (configured with `shutdownAction: "stopContainer"`).

**To stop manually:**
* Close VS Code window
* Or: `F1` > "Dev Containers: Close Remote Connection"

### Restarting the Container

Simply reopen the project folder in VS Code and click "Reopen in Container" again.

### Rebuilding the Container

If you modify `.devcontainer/` configuration files:

1. Press `F1` or `Ctrl+Shift+P` / `Cmd+Shift+P`
2. Type "Dev Containers: Rebuild Container"
3. Press Enter

This will rebuild the Docker image with your changes.

### Removing the Container

To completely remove the container and image:

```bash
# List containers
docker ps -a

# Remove container
docker rm <container-id>

# List images
docker images

# Remove image
docker rmi <image-id>
```

## Project Structure

```
electron-dev/
├── .devcontainer/
│   ├── devcontainer.json       # Dev Container configuration
│   ├── docker/
│   │   └── Dockerfile          # Docker image definition
│   └── cmd/
│       └── setup-git           # Git configuration script
├── LICENSE
└── README.md
```

**Your Electron project files go in the root directory** alongside this README.

## Advanced Usage

### Using with Existing Electron Projects

You can use this template with an existing Electron project:

1. Copy the `.devcontainer` folder to your project root
2. Open your project in VS Code
3. Reopen in Container
4. Ensure your start script includes `--no-sandbox`

### Multiple Electron Apps

You can run multiple instances of this environment simultaneously:
* Clone the repository to different folders
* Open each in a separate VS Code window
* Each will get its own container and port assignment

### Customizing the Environment

Edit `.devcontainer/docker/Dockerfile` to:
* Install additional system packages
* Change the base Node.js version
* Add custom configuration

After editing, rebuild the container to apply changes.

## What's Included

This environment comes pre-configured with:

* **Node.js** (slim version) - JavaScript runtime
* **npm** - Package manager
* **Git** - Version control
* **Desktop Environment** (via `desktop-lite` feature) - Browser-accessible GUI
* **Electron System Dependencies**:
  * GTK+ 3 libraries
  * NSS, Atk, Cups, GBM
  * ALSA sound libraries
  * DRM libraries
* **sudo access** - For installing additional packages
* **ESLint extension** - For code linting in VS Code

## Tips for Development

1. **Use VS Code Terminal:** All commands should be run in the VS Code terminal (inside the container), not your host machine terminal

2. **Install Dependencies Inside Container:** Always run `npm install` inside the container, not on your host

3. **Keep Browser Tab Open:** Keep the browser desktop tab open while developing so you can see your app

4. **Auto-reload:** Consider using tools like `electron-reload` for automatic app reloading during development

5. **Debugging:** Use Chrome DevTools in your Electron app (View > Toggle Developer Tools)

6. **Version Control:** Your code is mounted from your host machine, so you can use git normally

## Resources

* [Electron Documentation](https://www.electronjs.org/docs/latest/)
* [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
* [Docker Documentation](https://docs.docker.com/)
* [Node.js Documentation](https://nodejs.org/en/docs/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improving this development environment!

## Support

If you encounter any issues:
1. Check the [Troubleshooting](#troubleshooting) section above
2. Review the [Electron documentation](https://www.electronjs.org/docs/latest/)
3. Open an issue on GitHub with details about your problem

---

**Happy Electron Development! 🚀**