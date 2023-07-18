#!/bin/bash

# Check if virtual display number is available
DISPLAY_NUMBER=1
echo "Checking for virtual display availability"
while true; do
  if ! xdpyinfo -display :$DISPLAY_NUMBER >/dev/null 2>&1; then
    echo ":$DISPLAY_NUMBER is selected"
    break
  fi
  DISPLAY_NUMBER=$((DISPLAY_NUMBER + 1))
done

export DISPLAY=:"$DISPLAY_NUMBER"
Xvfb "$DISPLAY" -screen 0 1024x768x24 &
fluxbox &
x11vnc -display "$DISPLAY" -bg -nopw -listen localhost -xkb