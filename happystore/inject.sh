BASEDIR=$(dirname $0)
mvn -f $BASEDIR/injector/pom.xml gatling:execute -Dgatling.simulationClass=FullSimulation
