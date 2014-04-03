setlocal
call mvn -f injector\pom.xml gatling:execute -Dgatling.simulationClass=FullSimulation
endlocal
