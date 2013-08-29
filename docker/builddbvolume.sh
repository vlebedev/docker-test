#!/bin/bash

# building mongodb volume

DIR="/data/files"
FILE="testdbdata"

DB_DIR="/data/db/testdb"


echo Initializing 640Mbyte data file $DIR/$FILE, please wait...
dd if=/dev/zero of=$DIR/$FILE count=1310720
yes | mkfs -t ext3 $DIR/$FILE

echo Mounting data file on $DB_DIR...
sudo mount -o loop=/dev/loop0 $DIR/$FILE $DB_DIR

echo Done.