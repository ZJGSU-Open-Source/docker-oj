dockerfile-oj
=============

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge).

[**Demo**](http://clarkzjw-oj.daoapp.io/) runs on [DaoCloud](https://www.daocloud.io/).

### Base Docker Image

* [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

### Installation

+ Install [Docker](https://docs.docker.com/installation/#installation).

+ Clone this repo
```bash
git clone https://github.com/ZJGSU-Open-Source/docker-oj.git
```

+ Build an image from Dockerfile
```bash
docker build -t="docker-oj" .
```
   
### Usage

    docker run -it -p <host-ip>:8080 docker-oj

### Known issues

+ [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge)'s component [RunServer](https://github.com/ZJGSU-Open-Source/RunServer) does not support **x64** systems yet. Track this [issue](https://github.com/ZJGSU-Open-Source/RunServer/issues/4).Therefore OJ in container actually **can** run but **connot** judge submits yet. 

+ We run MongoDB inside docker container now which is not best practice however. In the future release of GoOnlineJudge, we will config MongoDB separately. Do **not** use this version in your production environment.
