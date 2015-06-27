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

# Install Ubuntu and base software.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential git wget flex supervisor && \
  mkdir -p /var/log/supervisor && \
  rm -rf /var/lib/apt/lists/*

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

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts
ADD root/supervisord.conf /etc/supervisord.conf

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb && \
  mkdir -p $GOPATH/Data && \
  rm -rf /var/lib/apt/lists/*

# Get OJ Source Code.
RUN \
  mkdir -p $GOPATH/src/ProblemData && \
  mkdir -p $GOPATH/src/run && \
  mkdir -p $GOPATJ/src/log && \
  go get gopkg.in/mgo.v2 && \
  go get github.com/djimenez/iconv-go && \
  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge && \
  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
  git clone https://github.com/ZJGSU-Open-Source/vjudger.git $GOPATH/src/vjudger && \
  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb

# Build OJ
RUN \
  mkdir -p $GOPATH/src/GoOnlineJudge/log && \
  cd $GOPATH/src/restweb && \
  cd restweb && \
  go install && \
  cd $GOPATH/src && \
  restweb build GoOnlineJudge && \
  cd $GOPATH/src/RunServer && \
  ./make.sh

# Expose ports
EXPOSE 8080

# Define working directory.
WORKDIR $GOPATH/src

# Define default command.
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
