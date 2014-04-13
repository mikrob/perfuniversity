Performance university
======================

This application is used to demonstrate the four main performance test
* Unitary performance test: How does a single user performs?
* Load testing: How does your normal server load performs?
* Limit testing: How many users your system can stand without breaking or getting really slow?
* Endurance: If running for a long time, does your system provides stable performances?

<<<<<<< .mine
Offline proxy
-------------
install node.js (node-v0.10.26 is ok)
cd <your directory for projects>
git clone https://github.com/bpaquet/offline-proxy.git
npm install 
node proxy

Install Ruby for master-cap in Windows
--------------------------------------
=== Install Ruby ===
* Install http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.0.0-p451-x64.exe?direct
* Extract http://cdn.rubyinstaller.org/archives/devkits/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe in C:\DevKit
* cd C:\DevKit
* ruby dk.rb init
* ruby dk.rb install
* gem install bundle
=== Install Chocolatey ===
* @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin
* choco sources add -name Nuget -source https://www.nuget.org/api/v2/
=== Install nokogiri prerequisites ===
cinst libxml2
cinst libxslt
cinst libiconv
=== Install master-cap ===
* git clone https://github.com/kitchenware/master-cap
* cd master-cap
* gem install nokogiri -v '1.5.10' -- --with-xml2-include=C:/Chocolatey/lib/libxml2.2.7.8.7/build/native/include --with-xml2-lib=C:/Chocolatey/lib/libxml2.redist.2.7.8.7/build/native/bin/v110/x64/Release/dynamic/cdecl --with-iconv-include=C:/Chocolatey/lib/libiconv.1.14.0.11/build/native/include --with-iconv-lib=C:/Chocolatey/lib/libiconv.redist.1.14.0.11/build/native/bin/v110/x64/Release/dynamic/cdecl --with-xslt-include=C:/Chocolatey/lib/libxslt.1.1.28.0/build/native/include --with-xslt-lib=C:/Chocolatey/lib/libxslt.redist.1.1.28.0/build/native/bin/v110/x64/Release/dynamic
* gem install nokogiri -v '1.5.11' -- --with-xml2-include=C:/Chocolatey/lib/libxml2.2.7.8.7/build/native/include --with-xml2-lib=C:/Chocolatey/lib/libxml2.redist.2.7.8.7/build/native/bin/v110/x64/Release/dynamic/cdecl --with-iconv-include=C:/Chocolatey/lib/libiconv.1.14.0.11/build/native/include --with-iconv-lib=C:/Chocolatey/lib/libiconv.redist.1.14.0.11/build/native/bin/v110/x64/Release/dynamic/cdecl --with-xslt-include=C:/Chocolatey/lib/libxslt.1.1.28.0/build/native/include --with-xslt-lib=C:/Chocolatey/lib/libxslt.redist.1.1.28.0/build/native/bin/v110/x64/Release/dynamic

* gem install bundle
* bundle
* Installer vagrant avec l'installer natif trouv� sur le site

=======


































>>>>>>> .theirs
How to run locally
------------------
~~~bash
cd happystore
sh local_launch.sh
~~~
=> It currently connects to postgreSQL and expects graphite on port 8888

See the application
-------------------

URL: http://localhost:8080/happystore

You will see
* Test URLs for the different REST services
* A link to the H2 console (that doesn't show the actuel H2 database because of a configuration issue)
* See where to find JMX beans to consult

Compile the application
-----------------------
~~~bash
cd happystore
mvn install
~~~

Launch Gatling in local
-----------------------
~~~bash
cd happystore
sh local_inject.sh
~~~

Start the chefless servers
-------------------
~~~bash
cd vm
vagrant up
~~~

Reset the chefless servers
-------------------
~~~bash
cd vm
vagrant destroy app
vagrant destroy tools
vagrant destroy db
~~~

Deploy the application and gatling simulations on the chefless servers
----------------------------------------------------------------------

First, you need to have vagrant ssh private key in your config. Add the following to your ssh config file
~~~
host app
	hostname 192.168.56.10
	identityfile $HOME/.vagrant.d/insecure_private_key
	user vagrant
	
host tools
	hostname 192.168.56.11
	identityfile $HOME/.vagrant.d/insecure_private_key
	user vagrant

host db
	hostname 192.168.56.12
	identityfile $HOME/.vagrant.d/insecure_private_key
	user vagrant
~~~

~~~bash
cd happystore
sh deploy.sh
~~~

The application is available at http://192.168.56.10:8080/happystore

Desactivate performance flaws
-----------------------------
To desactivate the performance issues that are activated by default, you can
1. Use the performance MBean
2. Pass a -D parameter matching the MBean name with the value false (e.g. `-DstatFilterEnabled=false`)

Configure the VMs with chef
===========================

You need:
* Offline proxy: a proxy that will keep in local all downloads made by master chef. This will speed up reinstall
* Master-cap: A capistrano layer over master-chef
* Ruby to run chef and capistrano
* NodeJS to run the offline-proxy
* VirtualBox to create VMs
* Vagrant to provision VMs from the command line easily

VirtualBox
----------
Just install the latest version

Vagrant
-------
Just install the latest version

NodeJS
------
Install the latest version (node-v0.10.26 is ok)

Offline proxy
-------------
cd <your directory for projects>
git clone https://github.com/bpaquet/offline-proxy.git
npm install 
node proxy.js

It should launch without errors and wait for requests. The downloaded binaries are stored in the `storage` directory.

Install Ruby for master-cap in Windows
--------------------------------------

=== Install Ruby ===
* Install http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.0.0-p451-x64.exe?direct
* Extract http://cdn.rubyinstaller.org/archives/devkits/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe in C:\DevKit
* cd C:\DevKit
* ruby dk.rb init
* ruby dk.rb install
* gem install bundle

=== Install Chocolatey ===
* @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin
* choco sources add -name Nuget -source https://www.nuget.org/api/v2/

=== Install nokogiri prerequisites ===
cinst libxml2
cinst libxslt
cinst libiconv

=== Install master-cap ===
* git clone https://github.com/kitchenware/master-cap
* cd master-cap
* gem install nokogiri -v '1.5.10' -- --with-xml2-include=C:/Chocolatey/lib/libxml2.2.7.8.7/build/native/include --with-xml2-lib=C:/Chocolatey/lib/libxml2.redist.2.7.8.7/build/native/bin/v110/x64/Release/dynamic/cdecl --with-iconv-include=C:/Chocolatey/lib/libiconv.1.14.0.11/build/native/include --with-iconv-lib=C:/Chocolatey/lib/libiconv.redist.1.14.0.11/build/native/bin/v110/x64/Release/dynamic/cdecl --with-xslt-include=C:/Chocolatey/lib/libxslt.1.1.28.0/build/native/include --with-xslt-lib=C:/Chocolatey/lib/libxslt.redist.1.1.28.0/build/native/bin/v110/x64/Release/dynamic
* gem install nokogiri -v '1.5.11' -- --with-xml2-include=C:/Chocolatey/lib/libxml2.2.7.8.7/build/native/include --with-xml2-lib=C:/Chocolatey/lib/libxml2.redist.2.7.8.7/build/native/bin/v110/x64/Release/dynamic/cdecl --with-iconv-include=C:/Chocolatey/lib/libiconv.1.14.0.11/build/native/include --with-iconv-lib=C:/Chocolatey/lib/libiconv.redist.1.14.0.11/build/native/bin/v110/x64/Release/dynamic/cdecl --with-xslt-include=C:/Chocolatey/lib/libxslt.1.1.28.0/build/native/include --with-xslt-lib=C:/Chocolatey/lib/libxslt.redist.1.1.28.0/build/native/bin/v110/x64/Release/dynamic
* gem install bundle
* bundle

Install the VMs
---------------

=== Install master-chef on the VMs ===
cap appserver-devoxx chef:install -s user=vagrant
cap toolserver-devoxx chef:install -s user=vagrant
cap dbserver-devoxx chef:install -s user=vagrant

=== Generate local json configuration ===
cap appserver-devoxx chef:generate_local_json
cap toolserver-devoxx chef:generate_local_json
cap dbserver-devoxx chef:generate_local_json


=== Run the installation on the VMs
cap appserver-devoxx chef
cap toolserver-devoxx chef
cap dbserver-devoxx chef