#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=buffer_fill_each_frame.txt
test_file $tt

frame_bf=$(obtain_frame_buffer_fill $cons)

echo $frame_bf >$tt

