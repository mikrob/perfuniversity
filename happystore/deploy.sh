BASEDIR=$(dirname $0)

ssh app "sudo service tomcat7 stop"
scp $BASEDIR/app/target/happystore-1.0-SNAPSHOT.war app:happystore.war
ssh app "sudo chown tomcat7:tomcat7 happystore.war && sudo mv happystore.war /var/lib/tomcat7/webapps/"
ssh app "sudo service tomcat7 start"

scp -r $BASEDIR/injector/src/test/resources/data tools:gatling-charts-highcharts-1.5.5/user-files
scp -r $BASEDIR/injector/src/test/scala/simulations tools:gatling-charts-highcharts-1.5.5/user-files
