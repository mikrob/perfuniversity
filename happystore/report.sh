BASEDIR=$(dirname $0)
GATLING_HOME=$BASEDIR/gatling

if [ "$1" = "" ] ; then 
  echo
  echo "Available results:"
  ls -1 "$GATLING_HOME/results"
  echo
  read -p "Select the result you want to generate a report for: " NAME
  echo
else
  NAME=$1
fi

"$GATLING_HOME/bin/gatling.sh" -ro $NAME

