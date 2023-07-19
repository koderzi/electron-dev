FROM node:slim

# Update apt-get and install git
RUN apt-get update && \
    apt-get -y install git

# Install VNC dependencies
RUN apt-get -y install xvfb fluxbox x11vnc net-tools

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2