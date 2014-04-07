#!/bin/sh

echo "=> Updating apt"
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "=> Install java and git"
sudo apt-get install openjdk-7-jdk -y
sudo apt-get install git -y

echo "=> Install Tomcat"
sudo apt-get install tomcat7 -y
