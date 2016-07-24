#!/bin/bash

STREAM_FILE_LIST=/home/ubuntu/videos/iceage4_480p_1M.ts

FFMPEG_BIN=lvtranscode
OUT_ADDRESS="udp://239.1.1.2:50010?pkt_size=1316&buffer_size=1"
#OUT_ADDRESS=udp://192.168.10.110:5501

FLOG="stream.log"

while :
do
  for fname in $STREAM_FILE_LIST
  do
    [ ! -e $fname ] && continue
    #CMD="$FFMPEG_BIN -re -i $fname -c copy -bsf:v h264_mp4toannexb -f mpegts $OUT_ADDRESS"
    CMD="$FFMPEG_BIN -re -i $fname -c copy -f mpegts $OUT_ADDRESS"
    echo ">>>>>>>>>>>>>>>> $CMD" >> $FLOG 2>&1
    $CMD >> $FLOG 2>&1
  done
done

exit 0

