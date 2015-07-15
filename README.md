dockerfile-oj
=============

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge).

[**Demo**](http://onlinejudge.daoapp.io/) runs on [DaoCloud](https://www.daocloud.io/).

### Installation

1. Install [Docker](https://docs.docker.com/installation/#installation).

2. Build 
   
   `docker build -t goonlinejudge .`
   
### Usage

    docker run -it -p <host-port>:8080 goonlinejudge
