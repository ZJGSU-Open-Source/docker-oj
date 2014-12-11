# Pull base image.
FROM ubuntu:14.04
MAINTAINER clarkzjw <clarkzjw@gmail.com>

RUN apt-get update && apt-get install -y build-essential vim git flex

RUN mkdir /home/acm/go

# Install Go
RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.4.src.tar.gz | tar xvzf - -C /goroot --strip-components=1

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

# Get OJ Source Code
RUN \
  mkdir $GOPATH/src/ProblemData && \
  mkdir $GOPATH/src/run

go get gopkg.in/mgo.v2

git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge
git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer
git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb

# Compile OJ
cd $GOPATH/src/GoOnlineJudge
git checkout master
go build
cd ../RunServer
./make.sh

echo
echo ----------
echo installed.
echo ----------
echo

# Define working directory.
WORKDIR $GOPATH/src

# Define default command.
CMD ["bash"]
