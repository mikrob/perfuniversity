setlocal
call mvn -f %~dp0app\pom.xml tomcat7:run
endlocal
