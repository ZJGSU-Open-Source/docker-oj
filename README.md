dockerfile-oj
=============

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/clarkzjw/docker-oj/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

### Installation

1. Install [Docker](https://docs.docker.com/installation/#installation).

2. Download [automated build](https://registry.hub.docker.com/u/clarkzjw/docker-oj/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull clarkzjw/docker-oj`

   (alternatively, you can build an image from Dockerfile: `docker build -t="clarkzjw/docker-oj" github.com/JinweiClarkChao/dockerfile-oj`)
   
### Usage

    docker run -it -p <host-ip>:8080 clarkzjw/docker-oj

### Known issues

+ [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge)'s conponent [RunServer](https://github.com/ZJGSU-Open-Source/RunServer) does not support **x64** systems yet. Track this [issue](https://github.com/ZJGSU-Open-Source/RunServer/issues/4).Therefore OJ in container actually **can** run but **connot** judge submits yet. 
