# Pinokio 3.6 - AI Market Place

## Intro

Pinokio [https://pinokio.computer] is an Elektron desktop app. 

Wrapped here as a container, so it can run headless, and serve the UI to a browser.

Use-case when you have a powerful server for your AI workloads, and want to keep your workstation clean and small. This container can run on your server with very little configuration. 


## Scratch

docker run -it --rm --gpus all --name pinokio -p 7860:7860 -p 7861:5900 -p 7862:42000 -v /mnt/cache/appdata/pinokio:/data olilanz/pinokio-nvidia

* https://github.com/pinokiocomputer/pinokio/issues/87
* https://github.com/pinokiocomputer/pinokio/issues/238
