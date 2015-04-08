#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=psnr_each_frame.txt
test_file $tt

frame_bf=$(obtain_frame_psnr $cons)

echo $frame_bf >$tt

