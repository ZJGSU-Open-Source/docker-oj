export GOPATH=/home/acm/go
echo $GOPATH

export GOROOT=/goroot
echo $GOROOT

export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

mongod --fork --logpath /home/acm/Data/mongo.log -port 8090 --dbpath /home/acm/Data

cd $GOPATH/src
restweb run GoOnlineJudge
