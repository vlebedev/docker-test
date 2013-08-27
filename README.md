docker-test
===========

Run meteor app with hipache frontend and mongodb backend.
All conponents are in their docker containers.


Initialization
--------------

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
1. Run build script: `./buildimages.sh`
1. Check if all three images (test/hipache, test/mongodb, test/meteor) are generated: `sudo docker images`

### Edit /etc/hosts
1. Edit /etc/hosts both on MacOS and ubuntu, add the following entry: `127.0.0.1    test.local`

### Run containers
1.


