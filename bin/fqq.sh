#!/bin/bash
pid=`ps aux |grep moonssh|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]
then
    kill $pid && echo "the running ssh has been killed....."|| (echo "kill ssh failure:"$pid && exit)
fi
echo "trying to run ssh....."
(sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s10.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s9.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s8.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s7.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s6.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s5.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s4.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s3.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s3.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s2.moonssh.com || \
sshpass -p ft6t60nHE1 ssh -qTfnN -D 7070 abbbfyah@s1.moonssh.com \
) &&echo "Success!!!ssh is running"||echo "Run ssh failure"

