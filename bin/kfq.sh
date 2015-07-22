#!/bin/bash
pid=`ps aux |grep moonssh|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]
then
    kill $pid
    stat=`echo $?`
    if [ $stat -eq 0 ]
    then
        echo "SSH has been killed"
    else
        echo "Kill SSH failure:"$pid
    fi
else
    echo "no fqSSH running"
fi
