#!/bin/bash
if test -z "$1" # 没有参数传递进来?
then
echo "Usage: `basename $0` Process(es)_to_kill"
exit 
fi

pname="$1"
#ps ax | grep "$PROCESS_NAME"|grep -v "grep" | awk '{print $1}' | xargs -i kill {} 2&>/dev/null
pid=`ps ax|grep "$pname"|grep -v "grep"|awk '{print $1}'`
echo $pid
