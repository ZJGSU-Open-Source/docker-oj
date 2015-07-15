#
# GoOnlineJudge Dockerfile
#
# Github
# https://github.com/ZJGSU-Open-Source/docker-oj
#

# Pull base image.
FROM google/golang
MAINTAINER Sakeven "sakeven.jiang@daocloud.io"

# Set environment variables for Golang.

ENV GOPATH /gopath/app
ENV PATH $GOPATH/bin:$PATH
ENV OJ_HOME $GOPATH/src
ADD . /gopath/app/src/

# Get OJ Source Code.
RUN \
  mkdir -p $OJ_HOME/ProblemData && \
  mkdir -p $OJ_HOME/run && \
  mkdir -p $OJ_HOME/log && \
  mkdir -p $GOPATH/Data

RUN \
  go get gopkg.in/mgo.v2 && \
  go get github.com/djimenez/iconv-go

# Install Ubuntu and base software.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential flex supervisor openjdk-7-jre && \
  mkdir -p /var/log/supervisor && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/supervisord.conf /etc/supervisord.conf

# Build OJ
RUN \
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

RUN \
  ls GoOnlineJudge

# Define default command.
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
