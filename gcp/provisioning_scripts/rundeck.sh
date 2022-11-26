#!/bin/bash
sudo yum update -y
sudo yum install java-11-openjdk -y
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck
sudo yum install rundeck -y
sudo systemctl start rundeckd
sudo systemctl enable rundeckd