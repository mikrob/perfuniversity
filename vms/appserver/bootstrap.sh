#!/usr/bin/env bash

apt-get update
apt-get upgrade
apt-get install -y curl git byobu make libxml2-dev libxslt1-dev

mkdir /opt/devoxx/
chown vagrant /opt/devoxx/
