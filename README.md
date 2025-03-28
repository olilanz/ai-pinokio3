# Pinokio 3.6 - AI Market Place for Running AI Models in Your Own Privacy

Pinokio [https://pinokio.computer] is the go-to app for downloading and installing the latest AI applications locally on your own hardware. This app is a containerized version of Pinokio, which lets you run everything inside a container - no installation required.

This might seem unusual at first, as Pinokio was originally designed as a desktop app. However, if you have a Linux server with an expensive GPU, where there is no interactive login, this might be an interesting option. Alternatively, if you don't have an expensive GPU but want to try AI apps on a rented GPU in the cloud without dealing with VM configuration, this could also be appealing. Additionally, if you want to experiment with unverified community scripts with the latest innovations but are unsure of their effects on your computer, the container provides an additional layer of isolation.

With Pinokio, downloading and installing AI apps is straightforward. Pinokio will handle that for you, keeping everything in the container to maintain a clean server and workstation.

**NOTE**: The container only contains Pinokio and does not include any AI software or models. Once you open Pinokio, you can browse the Pinokio catalog and let it download the required artifacts into the container.

**NOTE**: All downloads are stored in the `/workspace` folder. To avoid downloading the same files repeatedly, you can map that folder as a volume to your host file system. This is advisable as you will accumulate hundreds of gigabytes of data.

**NOTE**: Pinokio listens on port 42000, but installed apps may listen on other ports. To simplify things, you can expose the container on the host network directly, allowing you to start new apps without reconfiguring port maps.

**NOTE**: Some apps require specific hardware, such as a sound card or microphone. This may be problematic if Pinokio runs on a server in a data center while you access it via a web browser. This limitation affects apps with server-side hardware requirements, potentially rendering them unusable.

For an overview of how Pinokio works and what AI apps can be installed, please refer to the official [Pinokio](https://pinokio.computer) website.

## Building the Container
To build the container, run:
```bash
docker build -t olilanz/ai-pinokio3 .
```

## Running the Container
To run the container, use:
```bash
docker run -it --rm --name ai-pinokio3 \
  --shm-size 24g --gpus all \
  -v /mnt/cache/appdata/ai-pinokio3:/workspace \
  -p 42000:42000 \
  --network host \
  olilanz/ai-pinokio3
```

## Resources
* [Pinokio GitHub Issues](https://github.com/pinokiocomputer/pinokio/issues/87)
* [Pinokio GitHub Issues](https://github.com/pinokiocomputer/pinokio/issues/238)
