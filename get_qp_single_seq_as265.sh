#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=qp_each_frame.txt
test_file $tt

#frame_bf=$(grep -o "POC.*bits" $cons|awk '{print $7}'|awk -F"(" '{print $1}'|tr -t '\n' ' ')
idx=7
. create_as265_cmd.seg
echo $cmd
frame_bf=$(eval $cmd)

echo $frame_bf >$tt

