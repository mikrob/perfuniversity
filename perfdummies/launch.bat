setlocal
set CATALINA_HOME=%~dp0tomcat
set CATALINA_OPTS=-Xmx128m
"%CATALINA_HOME%\bin\startup.bat"
endlocal
