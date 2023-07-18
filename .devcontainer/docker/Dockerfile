FROM node:slim AS electron-dev

# Update apt-get and install git
RUN apt-get update && \
    apt-get -y install git

# Install VNC dependencies
RUN apt-get -y install xvfb fluxbox x11vnc net-tools

# Install Electron dependencies
RUN apt-get -y install libglib2.0-dev libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2

# # Create command to run Electron App
# RUN mkdir /electron \
#     && echo '#!/bin/bash\n' > /electron/electron-dev \
#     && echo 'CSPATH=$PWD/node_modules/electron/dist/chrome-sandbox\n' >> /electron/electron-dev \
#     && echo 'if [[ ! -f "$CSPATH" ]]; then' >> /electron/electron-dev \
#     && echo '\techo "Error: chrome-sandbox not found at $CSPATH.\nProcess aborted."' >> /electron/electron-dev \
#     && echo '\texit 1' >> /electron/electron-dev \
#     && echo 'fi\n' >> /electron/electron-dev \
#     && echo 'if [[ $(stat -c %a "$CSPATH") != "4755" ]]; then' >> /electron/electron-dev \
#     && echo '\tchmod 4755 "$CSPATH"' >> /electron/electron-dev \
#     && echo 'fi\n' >> /electron/electron-dev \
#     && echo 'FINDDISPLAY=$(x11vnc --finddpy)' >> /electron/electron-dev
#     && echo 'if echo "$FINDDISPLAY" | grep -q "^DISPLAY=:"; then' >> /electron/electron-dev
#     && echo '\tvalue=${FINDDISPLAY#*=}' >> /electron/electron-dev
#     && echo '\tvalue=${value%%,*}' >> /electron/electron-dev
#     && echo '\texport DISPLAY=$value' >> /electron/electron-dev
#     && echo 'else' >> /electron/electron-dev
#     && echo '\techo "Error: Virtual display not found.\nProcess aborted."' >> /electron/electron-dev
#     && echo '\texit 1' >> /electron/electron-dev
#     && echo 'fi' >> /electron/electron-dev
#     && echo 'npm start -- --no-sandbox' >> /electron/electron-dev
#     && chmod +x /electron/electron-dev

ENV PATH="${PATH}:/electron"
