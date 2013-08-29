from    ubuntu:12.04
run     echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run     apt-get -y update
run     apt-get -y install wget
run     wget -O /tmp/node.tar.gz http://nodejs.org/dist/v0.8.25/node-v0.8.25-linux-x64.tar.gz
run     tar -C /usr/local/ --strip-components=1 -zxvf /tmp/node.tar.gz
run     rm /tmp/node.tar.gz
add     ./bundle.tgz .
run	    cd bundle/programs/server; npm uninstall fibers; npm install fibers
cmd     ["node", "bundle/main.js"]

