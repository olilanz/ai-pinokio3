# Some apps require nvcc (NVIDIA Cuda Compiler). The runtime container from NVIDIA does not include it. 
# Hence we use the development container which includes nvcc.
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04
#FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Set configuration variables
ENV VNC_PWD=pinokio


# Set system variables
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
    xvfb
RUN apt install -y \
    dbus dbus-x11
RUN rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PINOKIO_HOST=0.0.0.0
ENV PINOKIO_PORT=7860
#ENV PINOKIO_OPTS="--no-sandbox"

# Set environment variables
#ENV ELECTRON_ENABLE_SANDBOX=0
ENV DISPLAY=:99

# Download and install the Pinokio .deb package
RUN wget -O /tmp/pinokio.deb https://github.com/pinokiocomputer/pinokio/releases/download/3.6.0/Pinokio_3.6.0_amd64.deb
RUN apt install -y /tmp/pinokio.deb && rm /tmp/pinokio.deb

# Expose VNC port
EXPOSE 5900
EXPOSE 42000

RUN mkdir /app
WORKDIR /app
COPY config.json config.json
COPY startup.sh startup.sh
RUN chmod +x startup.sh

CMD ["./startup.sh"]
