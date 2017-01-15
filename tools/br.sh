#!/bin/bash
if [ $# -lt 1 ];then
    echo "Usage: br <mediafile>"
    exit
fi
mediafile=$1
bitrate=$(minfo.sh $mediafile "bit_rate")
if [ "$bitrate" = "N/A" ];then
    duration=$(minfo.sh $mediafile "duration")
    if [ "$duration" != "N/A" ];then
        filesize=$(stat -c%s $mediafile)
        bitrate=$(awk -v x=$filesize -v y=$duration 'BEGIN {printf "%.2f",x*8/y/1000}')
    fi
fi
echo $bitrate
