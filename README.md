docker-test
===========

Run meteor app with hipache frontend and mongodb backend.
All conponents are in their docker containers.

### MacOS X vagrant setup (skip if you are already on Linux)
1. Install vagrant, see here: http://docs.vagrantup.com/v2/installation/
1. Create ubuntu 12.04 virtual machine with docker pre-installed: run `vagrant up`
1. Reload virtual machine: `vagrant reload`
1. Login into virtual machine: `vagrant ssh`

### Get some packages for ubuntu
1. Update packages: `sudo apt-get -y update`
1. Install some useful packages: `sudo apt-get -y install curl git redis-server mongodb-clients vim`
1. Install meteor: `curl https://install.meteor.com | sh`

### Build docker images
1. Go to shared directory: `cd /vagrant`, this directory is shared between MacOS and ubuntu
1. Go to docker files directory: `cd docker`
1. Build docker images: `./buildimages.sh`
1. Check if all three images (test/hipache, test/mongodb, test/meteor) are generated: `sudo docker images`

### Build and mount mongodb data file
1. Create a directory out of the /vagrant tree, i.e.: `sudo mkdir /data; sudo chown vagrant.vagrant /data`
1. Create subdirectories: `mkdir /data/files; mkdir /data/db; mkdir /data/db/testdb`
1. To init a file for database volume and mount it on /data/db/testdb run this script: `./builddbvolume.sh`

### Edit /etc/hosts
1. Edit /etc/hosts both on MacOS and ubuntu, add the following entry: `127.0.0.1    test.local`

### Run containers
1. Go to `/vagrant/docker`
1. Run `./run.sh`
1. Point your browser to http://test.local:8000 (on MacOS) or http://test.local (on ubuntu)

TODO
----

1. Resolve problem with websockets when multiple app containers configured in Hipache


