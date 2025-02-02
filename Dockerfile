# Use an Ubuntu-based CUDA image
#FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Install system dependencies required by Pinokio and VNC
RUN apt update 
RUN apt install -y \
    wget git xdg-utils
RUN apt install -y \
    libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 \
    libatspi2.0-0 libsecret-1-0 libappindicator3-1
RUN apt install -y \
    libgbm1 libasound2
RUN apt install -y \
    xvfb x11vnc tigervnc-standalone-server
RUN apt install -y \
    dbus
RUN rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PINOKIO_HOST=0.0.0.0
ENV PINOKIO_PORT=7860
#ENV PINOKIO_OPTS="--no-sandbox"

# Set environment variables
#ENV ELECTRON_ENABLE_SANDBOX=0
ENV DISPLAY=:99

# Set up the working directory
WORKDIR /app

# Download and install the Pinokio .deb package
RUN wget -O pinokio.deb https://github.com/pinokiocomputer/pinokio/releases/download/3.6.0/Pinokio_3.6.0_amd64.deb
RUN apt install -y ./pinokio.deb && rm pinokio.deb

# Expose VNC port
EXPOSE 5900
EXPOSE 7860
EXPOSE 42000

COPY config.json /root/.config/pinokio/config.json

# Copy the startup script to the container
COPY startup.sh startup.sh

# Make the script executable
RUN chmod +x startup.sh

# Start xvfb, x11vnc, and then Pinokio
#CMD xvfb-run --server-args="-screen 0 1280x1024x24" x11vnc -display :99 -forever -passwd yourpassword & pinokio serve --host 0.0.0.0 --port 7860 --no-sandbox
#CMD ["sh", "-c", "xvfb-run --server-args='-screen 0 1280x1024x24' & x11vnc -display :99 -forever -passwd yourpassword & pinokio serve --host 0.0.0.0 --port 7860 --no-sandbox"]
CMD ["./startup.sh"]
