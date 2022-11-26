#!/bin/bash
sudo apt-get update -y
sudo apt-get install openjdk-11-jre-headless -y
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/deb-setup.sh 2> /dev/null | sudo bash -s rundeckpro