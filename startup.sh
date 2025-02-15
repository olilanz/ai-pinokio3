#!/bin/bash

echo "🔧 Starting Pinokio container startup script..."

# Ensure /run/dbus exists
mkdir -p /run/dbus

# Start the system D-Bus daemon (needed by Electron)
echo "🔄 Starting system D-Bus..."
dbus-daemon --system --fork
sleep 2  # Give it time to initialize
echo "✅ System D-Bus started."

# Start the session D-Bus (needed by Electron)
echo "🔄 Starting session D-Bus..."
eval $(dbus-launch --sh-syntax)
export DBUS_SESSION_BUS_ADDRESS
echo "✅ Session D-Bus started: $DBUS_SESSION_BUS_ADDRESS"

# Start X virtual framebuffer (needed by Pinokio)
echo "🔄 Starting Xvfb virtual display..."
Xvfb :99 -screen 0 1280x1024x24 &
sleep 2
export DISPLAY=:99
echo "✅ Xvfb is running (DISPLAY=:99)."

# Setting up the cache directories
CACHE_HOME="/workspace"
CONFIG_HOME="${CACHE_HOME}/config"
PINOKIO_HOME="${CACHE_HOME}/data"

echo "📂 Setting up cache directories..."
mkdir -p "${CACHE_HOME}" "${CONFIG_HOME}" "${PINOKIO_HOME}"

# Setting up initial config
if [ ! -f "${CONFIG_HOME}/config.json" ]; then
    cp "./config.json" "${CONFIG_HOME}/config.json"
fi

# Redirecting the config to the cache
mkdir -p "${CONFIG_HOME}" /root/.config 
ln -snf "${CONFIG_HOME}" /root/.config/Pinokio 

# Start Pinokio (Electron desktop app requires these switches)
PINOKIO_ARGS="serve --port 42000 --no-sandbox --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --headless"

echo "🚀 Starting Pinokio (container port 42000)..."
echo "exec pinokio ${PINOKIO_ARGS} 2>&1 | tee \"${CACHE_HOME}/output.log\""
exec pinokio ${PINOKIO_ARGS} 2>&1 | tee "${CACHE_HOME}/output.log"

# If Pinokio exits, print a message
echo "❌ Pinokio has stopped running. Check logs for details."
