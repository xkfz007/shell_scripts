#!/bin/bash
pid=`ps aux |grep firefox|grep -v grep|awk '{print $2}'`
#echo $pid
if [ -n "$pid" ]
then
    kill $pid
    stat=`echo $?`
    if [ $stat -eq 0 ]
    then
        echo "firefox has been killed"
    else
        echo "kill firfox failure:"$pid
    fi
else
    echo "no firefox running"
fi
