#!/bin/bash

# Build docker images

# hipache
cd hipache
sudo docker build -t test/hipache .

# mongodb
cd ../mongodb
sudo docker build -t test/mongodb .

# Rebuild docker image with meteor app

echo Building meteor bundle, it takes awhile, be patient...
cd ../../app
meteor bundle ../docker/meteor/bundle.tgz

echo Building docker image for meteor app
cd ../docker/meteor
sudo docker build -t test/meteor .
