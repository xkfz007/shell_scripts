#!/bin/bash
tt=cost.txt
[ -f $tt ] && >$tt || touch $tt
seq_list="HotelPassage_448x336_15"
for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    cons=${i}_cons.txt
    line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
    ((line_no1+=2))

    frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`
    ((frame_end=frames-1))

    col1=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost=" ){print i;break} }'`
    ((col1++))
    col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost2=" ){print i;break} }'`
    ((col2++))

    for ((j=0;j<$frames;j++))
    do
        poc_str=`printf "POC %4d" $j`
        line=`grep "$poc_str" $cons`
        cost=`echo $line|awk -v x=$col1 '{print $x}'`
        cost2=`echo $line|awk -v x=$col2 '{print $x}'`
        echo $cost" "$cost2 >>$tt
        printf "."
    done
    echo >>$tt
done

