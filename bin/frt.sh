#!/bin/bash
#file format test
name=$1
verbose=$2
if [ -z "$name" ]
then
    echo "Usage:ud filename 0"
    exit
fi
if [ ! -f "$name" ]
then
    echo "file:$name not exist"
    exit
fi

sed 's/\^M//g' $name|cat -A|grep -q "\^M"&&cr=1||cr=0
sed 's/\$//g' $name|cat -A|grep -q "\\$"&&lf=1||lf=0

test -z "$verbose" && echo "cr=$cr" && echo "lf=$lf"

if [ $cr -eq 1 ] && [ $lf -eq 1 ]
then
    os=2
    test -z "$verbose" &&echo "file is dos format"
elif [ $lf -eq 1 ]
then
    os=1
    test -z "$verbose" &&echo "file is unix format"
else
    os=0
    test -z "$verbose" &&echo "file is mac format"
fi
test -n "$verbose" &&echo $os
