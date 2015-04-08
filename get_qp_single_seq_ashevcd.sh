#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=qp_each_frame.txt
test_file $tt
idx=20
#frame_bf=$(obtain_frame_qp $cons)
#frame_qp=$(grep -o "cu_avg_qp.*" $cons|awk '{print $3}'|tr -t '\n' ' ')
. create_ashevcd_cmd.seg
echo $cmd
frame_bits=$(eval $cmd) 

echo $frame_qp >$tt

