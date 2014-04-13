Performance university
======================

This application is used to demonstrate the four main performance test
* Unitary performance test: How does a single user performs?
* Load testing: How does your normal server load performs?
* Limit testing: How many users your system can stand without breaking or getting really slow?
* Endurance: If running for a long time, does your system provides stable performances?

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
* gem install bundle
* bundle
* Installer vagrant avec l'installer natif trouvé sur le site

How to run locally
------------------
~~~bash
cd happystore
sh local_launch.sh
~~~

See the application
-------------------

URL: http://localhost:8080/happystore

You will see
* Test URLs for the different REST services
* A link to the H2 console
* See where to find JMX beans to consult

Compile the application
-----------------------
~~~bash
cd happystore
mvn install
~~~

Launch Gatling
--------------
~~~bash
cd happystore
sh inject.sh
~~~

Start the servers
-------------------
~~~bash
cd vm
vagrant up
~~~

Reset the servers
-------------------
~~~bash
cd vm
vagrant destroy app
vagrant destroy tools
vagrant destroy db
~~~

Deploy the application and gatling simulations
----------------------------------------------

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
----------------------------
To desactivate the performance issues that are activated by default, you can
1. Use the performance MBean
2. Pass a -D parameter matching the MBean name with the value false (e.g. `-DstatFilterEnabled=false`)
