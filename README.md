# Pinokio 3.6 - AI Market Place

## Intro

Pinokio [https://pinokio.computer] is an Elektron desktop app. 

Wrapped here as a container, so it can run headless, and serve the UI to a browser.

Use-case when you have a powerful server for your AI workloads, and want to keep your workstation clean and small. This container can run on your server with very little configuration. 


## Scratch

docker build -t olilanz/ai-pinokio3 .

docker run -it --name ai-pinokio3 --rm --gpus all -v /mnt/cache/appdata/pinokio/data:/root/pinokio -v /mnt/cache/appdata/pinokio/config:/root/.config/Pinokio -p 42000:42000 olilanz/ai-pinokio3

* https://github.com/pinokiocomputer/pinokio/issues/87
* https://github.com/pinokiocomputer/pinokio/issues/238
