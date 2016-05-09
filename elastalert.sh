#!/bin/bash
# © ydh @ 2016


NAME=elastalert-service
export VIRTUAL_ENV="/home/elastalert/.virtualenvs/elastalert"
export PATH="$VIRTUAL_ENV/bin:$PATH"
unset PYTHON_HOME
PIDFILE=/var/run/$NAME.pid
elastalert_dir="/home/elastalert/"

case $1 in
   start)
  	echo $"Starting process  $NAME as pid $PIDFILE"
        cd $elastalert_dir
  	elastalert --verbose --rule example_rules/frequency_alert.yaml 2>/dev/null &
  	RETVAL=$?
  	pid=`ps -ef |grep python |grep elastalert |awk '{print $2}' >$PIDFILE`

#if [ -n "$pid"]; then
#  echo $pid > "$PIDFILE"
#fi
;;

   status)

	if [ -f "$PIDFILE" ]
	then
	echo "elastic alert is running, pid status is: `cat $PIDFILE`"
	else
	echo "elastalert is not running"
	fi
;;

   stop)

	ps -ef | grep elastalert | grep -v grep | awk '{print $2}' | xargs kill -9 | rm  $PIDFILE
;;

*)
 echo "Elastalert init script service. how to use it: elastalert (start | status | stop )";;

esac
exit 0
