# This file describes how to build hipache into a runnable linux container with all dependencies installed
# To build:
# 1) Install docker (http://docker.io)
# 2) Clone hipache repo if you haven't already: git clone https://github.com/dotcloud/hipache.git
# 3) Build: cd hipache && docker build .
# 4) Run:
# docker run -d <imageid>
# redis-cli
#
# VERSION		0.3
# DOCKER-VERSION	0.6.0

# CHANGES by vlebedev:
#   - Node version pumped up to 0.10.16
#   - Wget could be slow and pipe to tar may broke, therefore save to /tmp first
#     then untar and remove temp file

from    ubuntu:12.04
run     echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run     apt-get -y update
run     apt-get -y install wget git redis-server supervisor
run     wget -O /tmp/node.tar.gz http://nodejs.org/dist/v0.8.25/node-v0.8.25-linux-x64.tar.gz
run     tar -C /usr/local/ --strip-components=1 -zxvf /tmp/node.tar.gz
run     rm /tmp/node.tar.gz
run     npm install hipache -g
run     mkdir -p /var/log/supervisor
add     ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
add     ./config/config_dev.json /usr/local/lib/node_modules/hipache/config/config_dev.json
add     ./config/config_test.json /usr/local/lib/node_modules/hipache/config/config_test.json
add     ./config/config.json /usr/local/lib/node_modules/hipache/config/config.json
expose  80
expose  6379
cmd     ["supervisord", "-n"]
