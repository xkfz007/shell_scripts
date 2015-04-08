#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=bitrate_each_frame.txt
test_file $tt

rc_info=($(obtain_rc_info_as265 $cons))
target_bitrate=${rc_info[0]}
#echo "target_bitrate=$target_bitrate"

final_bitrate=$(obtain_final_bitrate_as265 $cons)
#echo "final_bitrate=$final_bitrate"
frame_bitrate=$(obtain_frame_bitrate $cons)

data="$target_bitrate $final_bitrate $frame_bitrate"
echo $data >$tt

