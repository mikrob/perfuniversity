BASEDIR=$(dirname $0)
mvn -f $BASEDIR/injector/pom.xml package gatling:execute -Dgatling.simulationClass=FullSimulation
