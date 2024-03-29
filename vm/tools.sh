#!/bin/sh

echo "Set offline-proxy"
export http_proxy=http://192.168.56.1:3128

echo "=> Updating apt"
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "=> Install Java and required tools"
sudo apt-get install openjdk-7-jdk -y

echo "=> Install Apache"
sudo apt-get install apache2 -y
sudo ln -s gatling-charts-highcharts-1.5.5/results /var/www/gatling

echo "=> Install Gatling"
if [ ! -f gatling-charts-highcharts-1.5.5-bundle.tar.gz ]; then
  wget https://s3-eu-west-1.amazonaws.com/software-factory-2/gatling-charts-highcharts-1.5.5-bundle.tar.gz
  tar xvf gatling-charts-highcharts-1.5.5-bundle.tar.gz
  rm -rf gatling-charts-highcharts-1.5.5/user-files/*
else
  echo "Skipped"
fi

echo "=> Cleanup"
sudo apt-get autoremove -y
