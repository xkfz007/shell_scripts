#!/bin/bash
if [ $# -lt 1 ];then
    echo "Usage: minfo <mediafile> <key>"
    exit
fi
media_file=$1

if [ $# -ge 2 ];then
    key=$2
fi
cmd="ffprobe $media_file"

if [ "$key" != "" ];then
    cmd=${cmd}" -v error -show_entries stream=$key|grep \"$key\"|head -n 1|awk -F= '{print \$2}'"
fi
#echo $cmd
eval $cmd

