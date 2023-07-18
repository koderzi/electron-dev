FROM node:slim

# Update apt-get and install git
RUN apt-get update && \
    apt-get -y install git

# Install VNC dependencies
RUN apt-get -y install xvfb fluxbox x11vnc

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2

# Create command to start Electron Display
RUN mkdir /electron \
    && echo -e '#!/bin/bash\n' > /electron/electron-start \
    && echo -e 'if ! pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then' >> /electron/electron-start \
    && echo -e '\tnohup x11vnc -create \\' >> /electron/electron-start \
    && echo -e '\t\t-env FD_PROG=/usr/bin/fluxbox \\' >> /electron/electron-start \
    && echo -e '\t\t-env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 \\' >> /electron/electron-start \
    && echo -e '\t\t-env X11VNC_CREATE_GEOM=${1:-1024x768x16} \\' >> /electron/electron-start \
    && echo -e '\t\t-gone '"'"'killall Xvfb'"'"' \\' >> /electron/electron-start \
    && echo -e '\t\t-bg -nopw >/dev/null 2>&1 &' >> /electron/electron-start \
    && echo -e 'fi\n' >> /electron/electron-start \
    && echo -e 'DISPLAY_NUMBER=0' >> /electron/electron-start \
    && echo -e 'while true; do' >> /electron/electron-start \
    && echo -e '\tif xdpyinfo -display :$DISPLAY_NUMBER >/dev/null 2>&1; then' >> /electron/electron-start \
    && echo -e '\t\techo "$DISPLAY_NUMBER" > /electron/display' >> /electron/electron-start \
    && echo -e '\t\tbreak' >> /electron/electron-start \
    && echo -e '\tfi' >> /electron/electron-start \
    && echo -e '\techo "${DISPLAY_NUMBER}"' >> /electron/electron-start \
    && echo -e '\tDISPLAY_NUMBER=$((DISPLAY_NUMBER + 1))' >> /electron/electron-start \
    && echo -e '\tif [ $DISPLAY_NUMBER -gt 1023 ]; then' >> /electron/electron-start \
    && echo -e '\t\tbreak' >> /electron/electron-start \
    && echo -e '\tfi' >> /electron/electron-start \
    && echo -e 'done\n' >> /electron/electron-start \
    && chmod +x /electron/electron-start

# Create command to stop Electron Display
RUN mkdir /electron \
    && echo -e '#!/bin/bash\n' > /electron/electron-quit \
    && echo -e 'if pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then' >> /electron/electron-quit \
    && echo -e '\tpkill -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw"' >> /electron/electron-quit \
    && echo -e 'fi' >> /electron/electron-quit \
    && chmod +x /electron/electron-quit

# Create command to run Electron App
RUN mkdir /electron \
    && echo -e '#!/bin/bash\n' > /electron/electron-run \
    && echo -e 'CSPATH=$PWD/node_modules/electron/dist/chrome-sandbox\n' >> /electron/electron-run \
    && echo -e 'if [[ ! -f "$CSPATH" ]]; then' >> /electron/electron-run \
    && echo -e '\techo "Error: chrome-sandbox not found at $CSPATH.\nProcess aborted."' >> /electron/electron-run \
    && echo -e '\texit 1' >> /electron/electron-run \
    && echo -e 'fi\n' >> /electron/electron-run \
    && echo -e 'if [[ $(stat -c %a "$CSPATH") != "4755" ]]; then' >> /electron/electron-run \
    && echo -e '\tchmod 4755 "$CSPATH"' >> /electron/electron-run \
    && echo -e 'fi\n' >> /electron/electron-run \
    && echo -e 'if $DISPLAY_FOUND; then' >> /electron/electron-run \
    && echo -e '\texport DISPLAY=:${DISPLAY_NUMBER}' >> /electron/electron-run \
    && echo -e 'else' >> /electron/electron-run \
    && echo -e '\techo "Virtual display not found"' >> /electron/electron-run \
    && echo -e '\texit 1' >> /electron/electron-run \
    && echo -e 'fi\n' >> /electron/electron-run \
    && echo -e 'npm start -- --no-sandbox' >> /electron/electron-run \
    && chmod +x /electron/electron-run

ENV PATH="${PATH}:/electron"
