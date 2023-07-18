#!/bin/bash

# Create a vnc display if it doesn't exist
if ! pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then
    nohup x11vnc -create \
        -env FD_PROG=/usr/bin/fluxbox \
        -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 \
        -env X11VNC_CREATE_GEOM=${1:-1024x768x16} \
        -gone 'killall Xvfb' \
        -bg -nopw >/dev/null 2>&1 &
fi

# # Kill any existing x11vnc processes
# if pgrep -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw" > /dev/null; then
#     pkill -f "x11vnc -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=1024x768x16 -gone killall Xvfb -bg -nopw"
# fi

# # Find created virtual display number
# DISPLAY_FOUND=false
# DISPLAY_NUMBER=0
# while true; do
#   if xdpyinfo -display :$DISPLAY_NUMBER >/dev/null 2>&1; then
#     DISPLAY_FOUND=true
#     break
#   fi
#   DISPLAY_NUMBER=$((DISPLAY_NUMBER + 1))
#   if [ $DISPLAY_NUMBER -gt 1023 ]; then
#     break
#   fi
# done

# # Set display number
# if $DISPLAY_FOUND; then
#   export DISPLAY=:${DISPLAY_NUMBER}
# else
#   echo "Virtual display not found"
#   exit 1
# fi






# Find created virtual display number
DISPLAY_NUMBER=0
while true; do
  DISPLAY_NUMBER=$((DISPLAY_NUMBER + 1))
  xdpyinfo -display :$DISPLAY_NUMBER
#   if xdpyinfo -display :$DISPLAY_NUMBER >/dev/null 2>&1; then
#     echo "$DISPLAY_NUMBER" > /electron/display
#     break
#   fi
  if [ $DISPLAY_NUMBER -gt 1023 ]; then
    if [ -f /electron/display ]; then
      rm /electron/display
    fi
    break
  fi
done