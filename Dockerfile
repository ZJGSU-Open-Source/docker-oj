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
MAINTAINER clarkzjw <clarkzjw@gmail.com>

# Install Ubuntu.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential git vim wget flex && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Install Golang.
RUN \
  mkdir -p /goroot && \
  wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz && \
  tar xzf go1.4.2.linux-amd64.tar.gz && \
  cp -r go/* /goroot/ && \
  mkdir -p /home/acm/go/src /home/acm/go/pkg /home/acm/go/bin

# Set environment variables for Golang.
ENV GOROOT /goroot
ENV GOPATH /home/acm/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  mkdir -p /home/acm/Data && \
  rm -rf /var/lib/apt/lists/* && \
  mongod -port 8090 --dbpath /home/acm/Data

# Get OJ Source Code
RUN \
  mkdir -p $GOPATH/src/ProblemData && \
  mkdir -p $GOPATH/src/run && \
  mkdir -p $GOPATJ/src/log

RUN \
  go get gopkg.in/mgo.v2 && \
  go get github.com/djimenez/iconv-go && \
  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge && \
  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
  git clone https://github.com/ZJGSU-Open-Source/vjudger.git $GOPATH/src/vjudger && \
  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb

# Build OJ
RUN \
  cd $GOPATH/src/restweb && \
  go install && \
  cd $GOPATH/src/GoOnlineJudge && \
  go build && \
  cd $GOPATH/src/RunServer && \
  ./make.sh

# Expose ports
EXPOSE 8080

# Define working directory.
WORKDIR $GOPATH/src/GoOnlineJudge

# Define default command.
CMD ["go", "run", "main.go"]