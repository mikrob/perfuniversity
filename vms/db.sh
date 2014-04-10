#!/usr/bin/env bash

apt-get update --assume-yes --quiet=2
apt-get dist-upgrade --assume-yes --quiet=2
apt-get install -assume-yes --quiet=2  curl git byobu make libxml2-dev libxslt1-dev
apt-get autoremove

reboot
