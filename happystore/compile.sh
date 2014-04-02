BASEDIR=$(dirname $0)
ANT_HOME=${BASEDIR}/ant
APP_HOME=${BASEDIR}/app
"$ANT_HOME/bin/ant" -f $APP_HOME/build.xml $*

