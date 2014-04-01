setlocal
set APP_HOME=%~dp0app
set TOMCAT_HOME=%~dp0tomcat
call %~dp0compile.bat package -Dmaven.test.skip=true
@echo on
copy %APP_HOME%\target\happystore-0.1-SNAPSHOT.war %TOMCAT_HOME%\webapps\happystore.war
endlocal
