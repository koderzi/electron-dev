FROM node:slim

# Install necessary packages
RUN apt-get update && \
    apt-get -y install git xvfb

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2

# Set the display number and start Xvfb
ENV DISPLAY=:1
CMD Xvfb $DISPLAY -screen 0 1024x768x16 & \
    sleep 5 && \
    x11vnc -display $DISPLAY -nopw -forever

# Expose the VNC port
EXPOSE 5900