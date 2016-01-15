dockerfile-oj
=============

This repository contains **Dockerfile** of [GoOnlineJudge](https://github.com/ZJGSU-Open-Source/GoOnlineJudge).

### Installation

1. Install [Docker](https://docs.docker.com/installation/#installation).

2. Build 
   
   `docker build -t goonlinejudge .`
   
### Usage

    docker run -it -p <host-port>:8080 goonlinejudge

### Note

1. This Dockerfile handles all components of GoOnlineJudge in one container, including databse. Running this container in production is highly **not** recommended.
2. Java might have issues right now.
