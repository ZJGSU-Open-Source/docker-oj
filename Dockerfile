#
# GoOnlineJudge Dockerfile
#
# Github
# https://github.com/ZJGSU-Open-Source/docker-oj
#

# Pull base image.
FROM google/golang
MAINTAINER Sakeven "sakeven.jiang@daocloud.io"

# Install Ubuntu and base software.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential mongodb flex supervisor openjdk-7-jdk && \
  mkdir -p /var/log/supervisor && \
  rm -rf /var/lib/apt/lists/*

# Set environment variables for Golang.

ENV GOPATH /gopath/app
ENV PATH $GOPATH/bin:$PATH
ENV OJ_HOME $GOPATH/src
ENV DATA_PATH $GOPATH/Data
ENV LOG_PATH $GOPATH/src/log
ENV RUN_PATH $GOPATH/src/run
ENV JUDGE_HOST "http://127.0.0.1:8888"
ENV MONGODB_PORT_27017_TCP_ADDR=127.0.0.1

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
#CMD ["/bin/bash"]
