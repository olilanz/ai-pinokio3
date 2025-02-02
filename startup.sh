#!/bin/bash

echo "🔧 Starting Pinokio container startup script..."

# Ensure /run/dbus exists
mkdir -p /run/dbus

# Start the system D-Bus daemon
echo "🔄 Starting system D-Bus..."
dbus-daemon --system --fork
sleep 2  # Give it time to initialize
echo "✅ System D-Bus started."

# Start the session D-Bus
echo "🔄 Starting session D-Bus..."
eval $(dbus-launch --sh-syntax)
export DBUS_SESSION_BUS_ADDRESS
echo "✅ Session D-Bus started: $DBUS_SESSION_BUS_ADDRESS"

# Start X virtual framebuffer (Xvfb)
echo "🔄 Starting Xvfb virtual display..."
Xvfb :99 -screen 0 1280x1024x24 &
sleep 2
export DISPLAY=:99
echo "✅ Xvfb is running (DISPLAY=:99)."

# Start VNC server
echo "🔄 Starting VNC server for remote access..."
x11vnc -display :99 -forever -passwd $VNC_PWD &
sleep 2
echo "✅ VNC server is running (container port 5900)."

# Start Pinokio
echo "🚀 Starting Pinokio (container port 42000)..."
pinokio serve --port 42000 --no-sandbox

# If Pinokio exits, print a message
echo "❌ Pinokio has stopped running. Check logs for details."
