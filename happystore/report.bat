@echo off

setlocal
set GATLING_HOME=%~dp0gatling

if not "%1" == "" goto param
echo.
echo Available results:
echo.
dir /b "%GATLING_HOME%\results"
echo.
set /p NAME=Select the result you want to generate a report for: 
echo.

goto run

:param
set NAME=%1

:run
"%GATLING_HOME%\bin\gatling.bat" -ro %NAME%
endlocal
