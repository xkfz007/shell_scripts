#!/bin/bash
pid=`ps aux |grep moonssh|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]
then
    kill $pid && echo "the running ssh has been killed....."|| (echo "kill ssh failure:"$pid && exit)
fi
echo "trying to run ssh....."
(sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 -p 22 abbbfyah@s3.moonssh.com) &&echo "Success!!!ssh is running"||echo "Run ssh failure"
