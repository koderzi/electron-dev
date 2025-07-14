FROM node:slim

# Install system dependencies, including sudo
RUN apt-get update && apt-get install -y \
    git \
    net-tools \
    sudo \
    libglib2.0-dev \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libgtk-3-0 \
    libgbm1 \
    libasound2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add the node user to the sudo group and allow password-less sudo
RUN usermod -aG sudo node && \
    echo "node ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/node-nopasswd