Performance university
======================

This application is used to demonstrate the four main performance test
* Unitary performance test: How does a single user performs?
* Load testing: How does your normal server load performs?
* Limit testing: How many users your system can stand without breaking or getting really slow?
* Endurance: If running for a long time, does your system provides stable performances?

How to run locally
------------------
~~~bash
cd happystore
sh launch.sh
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

Start app server VM
-------------------
~~~bash
cd vms/appserver
vagrant up
~~~

Start tool server VM
--------------------
~~~bash
cd vms/toolserver
vagrant up
~~~

Deploy to the app server VM
---------------------------
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
