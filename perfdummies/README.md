This application is used to demonstrate the four main performance test
* Unitary performance test: How does a single user performs?
* Load testing: How does your normal server load performs?
* Limit testing: How many users your system can stand without breaking or getting really slow?
* Endurance: If running for a long time, does your system provides stable performances?

-- How to run --

--- See the application ---
URL: http://localhost:8080/happystore

You will see
* Test URLs for the different services
* A link to the H2 console
* How to have a look at the cache manager

--- Compile the application ---
compile.bat clean|compile|compile-tests|test|package

--- Deploy the application ---
deploy.bat

--- Launch the tomcat server ---
launch.bat

--- Launch Gatling ---
inject.bat

--- Generate a report from a simulation result ---
report.bat [result_name]
