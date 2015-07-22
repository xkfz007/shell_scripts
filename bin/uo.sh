#!/bin/bash
testdir()
{
    orig="c_os d_software e_study d_documents HITACHI SKIPPER PRIVATE UNIS INTEL NETAC"
    echo $orig |grep -q $1 && return 1 || return 0
}
dirlist=`ls /media/`
#echo $dirlist
for i in $dirlist
do
    test -d "/media/$i" ||  continue
    #echo $i
    testdir $i
    #echo $?
    result=$?
    test $result -eq 1 &&continue
    umount "/media/$i" &&echo "ok! /media/$i umounted" || echo "/media/$i not exist!"
done
