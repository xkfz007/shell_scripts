#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=qp_each_frame.txt
test_file $tt

idx=3

#frame_bf=$(grep -o "QP=....." $cons|awk -F"=" '{print $2}'|tr -t '\n' ' ')
. create_x264_cmd.seg
echo $cmd
frame_bf=$(eval $cmd)

echo $frame_bf >$tt

