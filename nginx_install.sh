#!/bin/bash

echo "install nginx"
sudo apt-get -y update
sudo apt-get -y install nginx
sudo service nginx start