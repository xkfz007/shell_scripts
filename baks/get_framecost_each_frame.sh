#!/bin/bash
tt=all_data_framecost.txt
[ -f $tt ] && >$tt || touch $tt

. /cygdrive/e/workspace/as265_shell_scripts/sequence_list.sh

#seq_list="$seq_list $classA"
#seq_list="$seq_list $classB"
seq_list="$seq_list $classC"
seq_list="$seq_list $classD"
seq_list="$seq_list $classE"
seq_list="$seq_list $classF"
#seq_list="$seq_list $othersB"
seq_list="$seq_list $othersC"
seq_list="$seq_list $othersD"
seq_list="$seq_list $othersE"
seq_list="$seq_list $othersF"
seq_list="$seq_list $othersReso"

for i in $seq_list
do
    cons=${i}_cons.log
    framecost=$(grep -o "slicetype_frame_cost2:poc=.*i_cost_est.*" $cons |awk -F"=" '{print $3}' |tr -t '\n' ' ')
    #duration=$(grep -o "fps=.*duration.*" $cons |awk -F"=" '{print $3}'|tr -t '\n' ' ')

    echo "${i} $framecost" >>$tt
    echo -n "."

done
    
