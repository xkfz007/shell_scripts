#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=bits_each_frame.txt
test_file $tt

idx=8
. create_as265_cmd.seg
echo $cmd
frame_bits=$(eval $cmd)
#frame_bf=$(obtain_frame_bits $cons)
#frame_bits=$(grep -o "POC.*bits" $cons|awk '{print $8}'|tr -t '\n' ' ')

echo $frame_bits >$tt

