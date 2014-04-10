#!/bin/sh

echo "=> Updating apt"
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "=> Cleanup"
sudo apt-get autoremove -y
