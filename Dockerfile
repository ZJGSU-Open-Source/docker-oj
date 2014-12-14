#
# GoOnlineJudge Dockerfile
#
# Github
# https://github.com/JinweiClarkChao/dockerfile-oj
#
# Docker Hub
# https://registry.hub.docker.com/u/clarkzjw/docker-oj/
#

# Pull base image.
FROM ubuntu:14.04
FROM golang:1.4

MAINTAINER clarkzjw <clarkzjw@gmail.com>

# Install Ubuntu.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential git vim wget flex && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables for Golang.
ENV GOPATH /home/acm/go

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  mkdir -p /home/acm/Data && \
  rm -rf /var/lib/apt/lists/*

# Get OJ Source Code
RUN \
  mkdir -p /home/acm/go/src /home/acm/go/pkg /home/acm/go/bin && \
  mkdir -p $GOPATH/src/ProblemData && \
  mkdir -p $GOPATH/src/run

RUN \
  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge && \
  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb && \
  git clone https://gopkg.in/mgo.v2 $GOPATH/src/gopkg.in/mgo.v2

# Define working directory.
WORKDIR $GOPATH/src

# Expose ports
EXPOSE 8080
EXPOSE 8000
EXPOSE 27017
EXPOSE 28017

# Define default command.
CMD ["bash"]
