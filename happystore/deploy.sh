BASEDIR=$(dirname $0)
IP=192.168.56.10
USER=vagrant

ssh USER@IP "sudo service tomcat stop"
scp $BASEDIR/happystore/app/target/happystore-1.0-SNAPSHOT.war USER@IP:/var/lib/tomcat7/webapps/happystore.war
ssh USER@IP "sudo service tomcat start"
