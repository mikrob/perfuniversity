setlocal
set ANT_HOME=%~dp0ant
set APP_HOME=%~dp0app
"%ANT_HOME%\bin\ant.bat" -f %APP_HOME%\build.xml %*
endlocal
