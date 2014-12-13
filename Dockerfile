#
# GoOnlineJudge Dockerfile
#
# Github
# https://github.com/JinweiClarkChao/dockerfile-oj
#
# Docker Hub
# https://registry.hub.docker.com/u/clarkzjw/go-onlinejudge/
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER clarkzjw <clarkzjw@gmail.com>

# Install Ubuntu.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y git vim wget flex && \
  mkdir -p /home/acm/go/src && \
  mkdir -p /home/acm/go/pkg && \
  mkdir -p /home/acm/go/bin && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Install Go
RUN mkdir -p /goroot
RUN wget https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz
RUN tar xvzf go1.4.linux-amd64.tar.gz
RUN cp -r go/* /goroot/

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /home/acm/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

# Set MongoDB dbpath
RUN mkdir -p /home/acm/Data

# Get OJ Source Code
RUN \
  mkdir -p $GOPATH/src/ProblemData && \
  mkdir -p $GOPATH/src/run

RUN \
  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge && \
  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb && \
  git clone https://gopkg.in/mgo.v2 $GOPATH/src/gopkg.in/mgo.v2
  
# Define working directory.
WORKDIR $GOPATH/src

# Define default command.
CMD ["bash"]
