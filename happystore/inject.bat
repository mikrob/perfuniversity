setlocal
set GATLING_HOME=%~dp0gatling
"%GATLING_HOME%\bin\gatling.bat" -s FullSimulation
endlocal
