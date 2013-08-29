#!/bin/bash

# Run all application containers

echo Starting Hipache reverse proxy container...

#run the main hipache container
HIPACHE_CONTAINER=$(sudo docker run -d -p 80:80 -p 6379 test/hipache)

#what port is hipache running on? in case we ever decide to change from -p 80:80
HIPACHE_PORT=$(sudo docker port $HIPACHE_CONTAINER 80)
HIPACHE_BRIDGE=$(sudo docker inspect $HIPACHE_CONTAINER | grep Bridge | cut -d":" -f2 | cut -d'"' -f2)

#this is temporary and fails if you're running containers are on disparate docker hosts
BRIDGE_IP=$(/sbin/ifconfig $HIPACHE_BRIDGE | sed -n '2 p' | awk '{print $2}' | cut -d":" -f2)

#get the port that REDIS is running on
REDIS_PORT=$(sudo docker port $HIPACHE_CONTAINER 6379)
REDIS_HOST=$BRIDGE_IP

echo Starting MongoDB container...

#run the mongodb container
MONGODB_CONTAINER=$(sudo docker run -d -v=/data/db/testdb:/tmp/data -e DATA_DIR=/tmp/data -e OPTS="--smallfiles" -p 27017 test/mongodb)
MONGODB_PORT=$(sudo docker port $MONGODB_CONTAINER 27017)
MONGODB_HOST=$BRIDGE_IP

echo Starting Meteor application containers...

#run two instances of meteor application
METEOR_CONTAINER_1=$(sudo docker run -d -p 3000 -e PORT=3000 -e DISABLE_WEBSOCKETS=YES -e MONGO_URL=mongodb://$MONGODB_HOST:$MONGODB_PORT test/meteor)
METEOR_PORT_1=$(sudo docker port $METEOR_CONTAINER_1 3000)
METEOR_HOST_1=$BRIDGE_IP

# METEOR_CONTAINER_2=$(sudo docker run -d -p 3001 -e PORT=3001 -e DISABLE_WEBSOCKETS=YES -e MONGO_URL=mongodb://$MONGODB_HOST:$MONGODB_PORT test/meteor)
# METEOR_PORT_2=$(sudo docker port $METEOR_CONTAINER_2 3001)
# METEOR_HOST_2=$BRIDGE_IP


echo Registering application instances in Hipache, please wait...

#redis takes a bit of time to load up...
sleep 5

#make sure the main hipache knows about our new http://test.local domain`
redis-cli -h $REDIS_HOST -p $REDIS_PORT rpush frontend:test.local testlocal
redis-cli -h $REDIS_HOST -p $REDIS_PORT rpush frontend:test.local http://$METEOR_HOST_1:$METEOR_PORT_1
# redis-cli -h $REDIS_HOST -p $REDIS_PORT rpush frontend:test.local http://$METEOR_HOST_2:$METEOR_PORT_2

echo Done.
