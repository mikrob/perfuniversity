#!/usr/bin/env bash

apt-get update --assume-yes --quiet=2
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
apt-get install -assume-yes --quiet=2 curl git byobu make libxml2-dev libxslt1-dev tomcat7 openjdk-7-jdk
apt-get autoremove

reboot
