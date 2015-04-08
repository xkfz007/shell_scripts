#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr

tt=all_data_rc_frame_buffer_fill.txt
test_file $tt

for i in $seq_list
do
    cons=${i}_cons.log
    test ! -f $cons && continue
    frame_bitrate=$(obtain_frame_buffer_fill $cons)

    echo "${i} $frame_bitrate" >>$tt
    echo -n "."

done
    
