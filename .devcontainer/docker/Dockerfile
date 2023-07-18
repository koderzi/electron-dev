FROM node:slim

# Update apt-get and install git
RUN apt-get update && \
    apt-get -y install git

# Install VNC dependencies
RUN apt-get -y install xvfb fluxbox x11vnc net-tools

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2

# Create command to run Electron App
RUN mkdir /electron \
    # && echo -e '#!/bin/bash\n' > /electron/electron-dev \
    # && echo -e 'CSPATH=$PWD/node_modules/electron/dist/chrome-sandbox\n' >> /electron/electron-dev \
    # && echo -e 'if [[ ! -f "$CSPATH" ]]; then' >> /electron/electron-dev \
    # && echo -e '\techo "Error: chrome-sandbox not found at $CSPATH.\nProcess aborted."' >> /electron/electron-dev \
    # && echo -e '\texit 1' >> /electron/electron-dev \
    # && echo -e 'fi\n' >> /electron/electron-dev \
    # && echo -e 'if [[ $(stat -c %a "$CSPATH") != "4755" ]]; then' >> /electron/electron-dev \
    # && echo -e '\tchmod 4755 "$CSPATH"' >> /electron/electron-dev \
    # && echo -e 'fi\n' >> /electron/electron-dev \
    # && echo -e 'FINDDISPLAY=$(x11vnc --finddpy)' >> /electron/electron-dev \
    # && echo -e 'if echo "$FINDDISPLAY" | grep -q "^DISPLAY=:"; then' >> /electron/electron-dev \
    # && echo -e '\tvalue=${FINDDISPLAY#*=}' >> /electron/electron-dev \
    # && echo -e '\tvalue=${value%%,*}' >> /electron/electron-dev \
    # && echo -e '\texport DISPLAY=$value' >> /electron/electron-dev \
    # && echo -e 'else' >> /electron/electron-dev \
    # && echo -e '\techo "Error: Virtual display not found.\nProcess aborted."' >> /electron/electron-dev \
    # && echo -e '\texit 1' >> /electron/electron-dev \
    # && echo -e 'fi' >> /electron/electron-dev \
    # && echo -e 'npm start -- --no-sandbox' >> /electron/electron-dev \
    # && chmod +x /electron/electron-dev

ENV PATH="${PATH}:/electron"
