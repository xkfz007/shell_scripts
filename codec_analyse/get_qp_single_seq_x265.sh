#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=qp_each_frame.txt
test_file $tt

idx=4
. create_x265_cmd.seg
echo $cmd
#frame_bf=$(grep -o "POC.*bits" $cons|awk '{print $4}'|awk -F"(" '{print $1}'|tr -t '\n' ' ')
frame_bf=$(eval $cmd)

echo $frame_bf >$tt

