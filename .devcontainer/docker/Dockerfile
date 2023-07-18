FROM node:slim

# Install necessary packages
RUN apt-get update && \
    apt-get -y install git

# Install VNC dependencies
RUN apt-get -y install xvfb

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2

# Create command to run Electron
RUN mkdir /electron \
    && echo '#!/bin/bash\n' > /electron/electron-run \
    && echo 'CSPATH=$PWD/node_modules/electron/dist/chrome-sandbox\n' >> /electron/electron-run \
    && echo 'if [[ ! -f "$CSPATH" ]]; then' >> /electron/electron-run \
    && echo '\techo "Error: chrome-sandbox not found at $CSPATH.\nProcess aborted."' >> /electron/electron-run \
    && echo '\texit 1' >> /electron/electron-run \
    && echo 'fi\n' >> /electron/electron-run \
    && echo 'if [[ $(stat -c %a "$CSPATH") != "4755" ]]; then' >> /electron/electron-run \
    && echo '\tchmod 4755 "$CSPATH"' >> /electron/electron-run \
    && echo 'fi\n' >> /electron/electron-run \
    && echo 'su -c "xvfb-run npm start" node' >> /electron/electron-run \
    && chmod +x /electron/electron-run

ENV PATH="${PATH}:/electron"