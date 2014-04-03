BASEDIR=$(dirname $0)
mvn -f ${BASEDIR}/app/pom.xml -Dmetrics.graphite.enabled=true -Dmetrics.graphite.port=8888 -Dmetrics.graphite.host=localhost -Dspring.profiles.active="h2" tomcat7:run
