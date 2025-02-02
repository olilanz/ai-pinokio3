#!/bin/bash

echo "🔧 Starting Pinokio container startup script..."

# Start D-Bus
echo "🔄 Starting D-Bus..."
dbus-daemon --system &
sleep 2  # Give D-Bus time to start
echo "✅ D-Bus started successfully."

# Start X virtual framebuffer (Xvfb)
echo "🔄 Starting Xvfb virtual display..."
Xvfb :99 -screen 0 1280x1024x24 &
sleep 2
export DISPLAY=:99
echo "✅ Xvfb is running on DISPLAY=:99."

# Start VNC server
echo "🔄 Starting VNC server for remote access..."
x11vnc -display :99 -forever -passwd yourpassword &
sleep 2
echo "✅ VNC server is running on port 5900."

# Start Pinokio
echo "🚀 Starting Pinokio..."
pinokio serve --no-sandbox

# If Pinokio exits, print a message
echo "❌ Pinokio has stopped running. Check logs for details."
