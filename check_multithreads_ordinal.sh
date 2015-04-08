#!/bin/bash
#tt=all_data_rc_bitrate.txt
#[ -f $tt ] && >$tt || touch $tt

. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg

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
seq_list="BlowingBubbles_416x240_50"

frames_to_be_encoded=100
if [ 0 ];then
for i in $seq_list
do
    cons=${i}_cons.log
    echo "Checking POC of ${i} ......."
    order=0
    for((j=0;j<$frames_to_be_encoded;j++))
    do
        template="POC.${j}.POCG"
        line=$(grep -o "POC.*POCG.*TID.*bRef.*Qp..." $cons|grep -n "$template")
        num=$(echo $line|awk -F: '{print $1}')
        tex=$(echo $line|awk -F: '{print $2}')
        ((order++))
        if [ $num -eq $order ];then
            result="\e[32mOK\e[0m"
        else
            result="\e[31mNO\e[0m"
        fi
        echo -e "$tex $result"
    done

done
fi
    
for i in $seq_list
do
    cons=${i}_cons.log
    echo "Checking Ratecontrol of ${i} ......."
    order=0
    for((j=0;j<$frames_to_be_encoded;j++))
    do
        template="poc=${j}.bitrate="
        line=$(grep "as265_ratecontrol_end:thread=.*poc.*bitrate.*" $cons|grep -n "$template")
        num=$(echo $line|awk -F: '{print $1}')
        tex=$(echo $line|awk -F: '{print $2":"$3}')
        ((order++))
        if [ $num -eq $order ];then
            result="\e[32mOK\e[0m"
        else
            result="\e[31mNO\e[0m"
        fi
        echo -e "$tex $result"
    done

done
