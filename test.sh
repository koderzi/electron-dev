#!/bin/bash

# # Create a vnc display if it doesn't exist
# if ! pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then
#     nohup x11vnc -create \
#         -env FD_PROG=/usr/bin/fluxbox \
#         -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 \
#         -env X11VNC_CREATE_GEOM=${1:-1024x768x16} \
#         -gone 'killall Xvfb' \
#         -bg -nopw >/dev/null 2>&1 &
# fi

# # # Kill any existing x11vnc processes
# # if pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then
# #     pkill -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw"
# # fi

# FINDDISPLAY=$(x11vnc --finddpy)
# if echo "$FINDDISPLAY" | grep -q "^DISPLAY=:"; then
#     value=${FINDDISPLAY#*=}
#     value=${value%%,*}
#     export DISPLAY=$value
# else
#     echo "Error: Virtual display not found"
#     exit 1
# fi