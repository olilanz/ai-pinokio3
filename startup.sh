#!/bin/bash

echo "🔧 Starting Pinokio container startup script..."

# Ensure /run/dbus exists
mkdir -p /run/dbus

# Start the system D-Bus daemon 
# (needed by Electron)
echo "🔄 Starting system D-Bus..."
dbus-daemon --system --fork
sleep 2  # Give it time to initialize
echo "✅ System D-Bus started."

# Start the session D-Bus 
# (needed by Electron)
echo "🔄 Starting session D-Bus..."
eval $(dbus-launch --sh-syntax)
export DBUS_SESSION_BUS_ADDRESS
echo "✅ Session D-Bus started: $DBUS_SESSION_BUS_ADDRESS"

# Start X virtual framebuffer 
# (needed by Pinokio, as it is a desktop app and won't run unless there is a display)
echo "🔄 Starting Xvfb virtual display..."
Xvfb :99 -screen 0 1280x1024x24 &
sleep 2
export DISPLAY=:99
echo "✅ Xvfb is running (DISPLAY=:99)."

# Start Pinokio 
# (the switches for GPU and SHM are needed to the electron desktop app in the container, as the vitual display is not a real GPU)
echo "🚀 Starting Pinokio (container port 42000)..."
pinokio serve --port 42000 --no-sandbox --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --headless

# If Pinokio exits, print a message
echo "❌ Pinokio has stopped running. Check logs for details."
