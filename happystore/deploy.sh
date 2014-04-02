BASEDIR=$(dirname $0)
TOMCAT_HOME=${BASEDIR}/tomcat
APP_HOME=${BASEDIR}/app
$BASEDIR/compile.sh package -Dmaven.test.skip=true
cp $APP_HOME/target/happystore-0.1-SNAPSHOT.war $TOMCAT_HOME/webapps/happystore.war

