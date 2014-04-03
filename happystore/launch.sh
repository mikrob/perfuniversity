BASEDIR=$(dirname $0)
mvn -f ${BASEDIR}/app/pom.xml tomcat7:run
