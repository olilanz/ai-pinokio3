# Some apps require nvcc (NVIDIA Cuda Compiler). The runtime container from NVIDIA does not include it. 
# Hence we use the development container which includes nvcc.
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04
#FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Software configuration
ENV PINOKIO_DOWNLOAD_URL=https://github.com/pinokiocomputer/pinokio/releases/download/3.6.0/Pinokio_3.6.0_amd64.deb

# Set system variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Install system dependencies required by Pinokio and VNC
RUN apt update \
    && apt install -y \
        wget git xdg-utils \
        libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 \
        libatspi2.0-0 libsecret-1-0 libappindicator3-1 \
        libgbm1 libasound2 \
        xvfb \
        dbus dbus-x11 \
        libcudnn8 \
    && rm -rf /var/lib/apt/lists/*

# Folder structures and assets
RUN mkdir /app
WORKDIR /app
COPY config.json config.json
COPY startup.sh startup.sh
RUN chmod +x startup.sh

# Download and install the Pinokio .deb package
RUN wget -O pinokio.deb $PINOKIO_DOWNLOAD_URL
RUN apt install -y ./pinokio.deb && rm pinokio.deb

EXPOSE 42000

CMD ["./startup.sh"]
