dockerfile-oj
=============

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/clarkzjw/docker-oj/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/clarkzjw/docker-oj/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull clarkzjw/docker-oj`

   (alternatively, you can build an image from Dockerfile: `docker build -t="clarkzjw/docker-oj" github.com/JinweiClarkChao/dockerfile-oj`)
   
### Usage

    docker run -it --rm clarkzjw/docker-oj
