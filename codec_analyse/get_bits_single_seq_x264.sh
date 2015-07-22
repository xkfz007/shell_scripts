#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=bits_each_frame.txt
test_file $tt

idx=10
#frame_bits=$(grep -o "size=.*bits" $cons|awk '{print $1}'|awk -F"=" '{print $2}'|tr -t '\n' ' ')
. create_x264_cmd.seg
echo $cmd
frame_bits=$(eval $cmd)

echo $frame_bits >$tt

