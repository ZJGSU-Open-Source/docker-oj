dockerfile-oj
=============

[![Circle CI](https://circleci.com/gh/ZJGSU-Open-Source/docker-oj.svg?style=svg)](https://circleci.com/gh/ZJGSU-Open-Source/docker-oj)

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge).

[**Demo**](http://clarkzjw-oj.daoapp.io/) runs on [DaoCloud](https://www.daocloud.io/).

### Base Docker Image

* [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

### Installation

1. Install [Docker](https://docs.docker.com/installation/#installation).

2. Download [automated build](https://registry.hub.docker.com/u/clarkzjw/goonlinejudge/) from public Docker Hub Registry:
   
   `docker pull clarkzjw/goonlinejudge`

   **Or**
   
   Alternatively, you can build an image from Dockerfile: 
   
   `docker build -t="docker-oj" github.com/ZJGSU-Open-Source/docker-oj`
   
### Usage

    docker run -it -p <host-port>:8080 docker-oj

### Known issues

+ [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge)'s component [RunServer](https://github.com/ZJGSU-Open-Source/RunServer) does not support **x64** systems yet. Track this [issue](https://github.com/ZJGSU-Open-Source/RunServer/issues/4).Therefore OJ in container actually **can** run but **connot** judge submits yet. 

+ We run MongoDB inside docker container now which is not best practice however. In the future release of GoOnlineJudge, we will config MongoDB separately. Do **not** use this version in your production environment.
