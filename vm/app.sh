#!/bin/sh

echo "Set offline-proxy"
export http_proxy=http://192.168.56.1:3128

echo "=> Updating apt"
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "=> Install java and git"
sudo apt-get install openjdk-7-jdk -y
sudo apt-get install git -y

echo "=> Install Tomcat"
sudo apt-get install tomcat7 -y
sudo echo "JAVA_OPTS=\$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8104 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false" | sudo tee -a /usr/share/tomcat7/defaults.template
sudo service tomcat7 restart

echo "=> Cleanup"
sudo apt-get autoremove -y
