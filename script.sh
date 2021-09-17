#!/bin/bash
#echo "Hello World"
# update package manager
sudo apt-get update && upgrade -y
#Instll curl
#apt-get install curl -Y
#Install git and clone rCMtoo l

sudo apt install git -y && sudo git clone https://github.com/maheshmarri/rCMTool.git &&
#file permission&execute

sudo chmod 755 -R /home/ubuntu/rCMTool/bin/* &&

cd /home/ubuntu/rCMTool/bin &&

sudo ./cmtool.pl
