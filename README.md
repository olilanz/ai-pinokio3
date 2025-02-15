# Pinokio 3.6 - AI Market Place for runing AI models in your own privacy

Pinokio [https://pinokio.computer] is the go-to app for downloading and installing the latest AI applications, locally on your own hardware. This app is a containerized version of Pinokio, which lets you run everything inside a container - no installation required. 

This might seem weird at first, as Pinokio originally was designed as a desktop app. But it you - like me - have a Linux server with an expensive GPU, where ther is no interactive login, this might be an interesting option. Or if you don't have an expensive GPU, but want to try AI apps out on a rented GPU in the cloud, without having to deal with VM configuration, this might might be interesting again. Or if you relly want to try out one of the unverified community scripts with the latest innovation, but you are not sure what this is going to do to your computer... the container provides an additional layer of isolation to the app.

With Pinokio, downloading and installing AI apps is super easy. Pinokio will take care of that. And with keeping everything in the container, your server and your workstation will stay clean. 

NOTE: The container does only contain Pinokio. It does not contain any AI software or model. Once you open Pinokio, you will be able to browse the Pinokio catalog, and let Pinokio download required artifacts into the container.

NOTE: All downloads are stored in the /workspace folder. If you want to avoid downloading the same files over and over again, you can map that folder as a volume to your host file system. I would advise that as you will accumulate literally 100's of gigabytes of data.

NOTE: Pinokio itself is listening on port 42000. But installed apps mey listen on other ports. If you want to keep things simple, you can expose the container on the host network directly. This lets you start new apps directly without the hassle of reconfiguring port maps.

NOTE: Some apps require specific hardware, such a sound card or microphone. This will of course be a bit weird, if Pinokio runs in a server in a data centre, while you are accesing Pinokio via the web browser. Naturally, this will put some limitations on apps that have server-side hardware-requirements, or render them directly unusable. That, of course, is a limitation of running Pinokio in this particular way.

For an overvion on how Pinokio works, and what AI apps can be installed, please refer to the official (Pinokio)[https://pinokio.computer] website.


## Building the container

docker build -t olilanz/ai-pinokio3 .

## Running the container

docker run -it --rm --name ai-pinokio3 \
  --shm-size 24g --gpus all \
    -v /mnt/cache/appdata/ai-pinokio3:/workspace \
    -p 42000:42000   \
    --network host \
    olilanz/ai-pinokio3

* https://github.com/pinokiocomputer/pinokio/issues/87
* https://github.com/pinokiocomputer/pinokio/issues/238
