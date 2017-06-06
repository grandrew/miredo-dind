#!/bin/bash

# TODO: run this in build image, then copy

sudo apt-get install miredo python-pip

sudo pip install dockerize

sudo dockerize --filetools -t miredo -a /etc/miredo.conf /etc/miredo.conf -a /etc/miredo/miredo.conf /etc/miredo/miredo.conf -a /etc/miredo/client-hook /etc/miredo/client-hook -a /usr/lib/x86_64-linux-gnu/miredo/miredo-privproc /usr/lib/x86_64-linux-gnu/miredo/miredo-privproc /usr/sbin/miredo /bin/bash /bin/ip /sbin/ip /sbin/ifconfig /sbin/route /usr/bin/teredo-mire /usr/sbin/miredo-checkconf /bin/sh /lib/x86_64-linux-gnu/libresolv.so.2 /lib/x86_64-linux-gnu/libresolv-2.23.so
sudo docker save miredo > ./miredo.tar
tar xvf ./miredo.tar `tar -tvf ./miredo.tar | grep layer | xargs | cut -d' ' -f6` --strip-components 1
rm ./miredo.tar

sudo docker build -t miredo-dind .
