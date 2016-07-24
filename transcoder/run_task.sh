#!/bin/bash
#($path/run_task.sh  cctv1hd    udp://236.114.126.32:10001 2601 1 &)
#($path/run_task.sh  cctv14hd   udp://236.114.126.47:10001 4302 1 &)
if [ $# -lt 3 ];then
   echo "Not enough parameters"
   echo "useage:run_tastk.sh <channel_name> <udp> <programd id> <do_execute>"
   exit -1

fi

channel_name=$1
channel_src=$2
channel_pid=$3

hlsdir="`pwd`/${channel_name}"
remote_dir="/mnt/remote/r4/wd_r4/test/test_mpts_audio/${channel_name}"

do_execute=0
if [ $# -gt 3 ];then
   do_execute=$4
fi

log1="${channel_name}_monitor.log"
cmd1="/home/ubuntu/codec/release/monitor_merge \"$hlsdir\"  \"$remote_dir\" 10 >$log1 2>&1"
echo $cmd1
log2="${channel_name}_lvtranscode.log"
cmd2="/home/ubuntu/codec/release/lvtranscode -nhb -hide_banner -threads auto -y -itsoffset 0.5 -async 1 -i \"${channel_src}?overrun_nonfatal=1&buffer_size=100000000&fifo_size=100000000\" -map p:${channel_pid} -vf '[in]scale=640:480[scaled_video];movie=/home/ubuntu/codec/logo/zb_44.tga,scale=123.0:30.0[logo];[scaled_video][logo]overlay=main_w-overlay_w-32.0:24.0[out]' -c:v libx264 -preset superfast -profile:v main -level:v 3.1 -s 640x480 -r 25 -x264-params keyint=50:scenecut=0 -b:v 318k -c:a libfdk_aac -profile:a aac_low -b:a 32k -ac 2 -ar 44100 -sn -metadata 'service_provider=WONDERTEK' -f tee [hls_wrap=0:hls_time=10:hls_list_size=15:hls_flags=discont_start:hls_segment_filename=\"${hlsdir}/20160715171359-01-%d.ts\":start_number=1468574039]\"${hlsdir}/01.m3u8\" >>$log2 2>&1"
echo $cmd2

echo $do_execute

if [ $do_execute != "0" ];then
   if [ ! -e $hlsdir ];then
      mkdir -p $hlsdir
   fi

   if [ ! -e $remote_dir ];then
      mkdir -p $remote_dir
   fi

   (eval "$cmd1" &)
   sleep 10
   export FFREPORT=file="ffreport-${channel_name}-%t.log":level=32

   #(eval "$cmd2" &)
   while true
   do
    eval $cmd2

   done
fi
