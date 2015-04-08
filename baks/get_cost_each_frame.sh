#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=all_data_rc_frame_cost.txt
test_file $tt

for i in $seq_list
do
    cons=${i}_cons.log
    test ! -f $cons && continue
    frame_cost=$(obtain_frame_cost $cons)

    echo "${i} $frame_cost" >>$tt
    echo -n "."

done
    
