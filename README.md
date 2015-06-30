dockerfile-oj
=============

[![Circle CI](https://circleci.com/gh/ZJGSU-Open-Source/docker-oj.svg?style=svg)](https://circleci.com/gh/ZJGSU-Open-Source/docker-oj)

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge).

[**Demo**](http://onlinejudge.daoapp.io/) runs on [DaoCloud](https://www.daocloud.io/).

### Base Docker Image

* [ubuntu:14.04](https://registry.hub.docker.com/_/ubuntu/)

### Installation

1. Install [Docker](https://docs.docker.com/installation/#installation).

2. Download [automated build](https://registry.hub.docker.com/u/clarkzjw/goonlinejudge/) from public Docker Hub Registry:
   
   `docker pull clarkzjw/goonlinejudge`
   
### Usage

    docker run -it -p <host-port>:8080 clarkzjw/goonlinejudge

### Known issues

+ We run MongoDB inside docker container now which is not best practice however. In the future release of GoOnlineJudge, we will config MongoDB separately. Do **not** use this version in your production environment.
