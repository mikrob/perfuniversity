#!/bin/sh

echo "Set offline-proxy"
export http_proxy=http://192.168.56.1:3128

echo "=> Updating apt"
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "=> Cleanup"
sudo apt-get autoremove -y
