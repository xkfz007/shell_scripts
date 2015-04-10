#!/bin/bash

tt=psnr_qp_data.txt
[ -f $tt ] && >$tt || touch $tt
cons=cons.txt
total_bits=(0 0 0)
qp_num=3
fps=50


line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
((line_no1+=2))

frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`

line=`sed -n -e "${line_no}"'p' $cons`

line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`

col1=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="QP" ){print i;break} }'`
((col1++))

col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="[Y" ){print i;break} }'`
((col2++))

col3=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="bits" ){print i;break} }'`
((col3--))

for (( j=0;j<$frames;j++ ))
do
    for (( ii=0;ii<$qp_num;ii++ ))
    do
        qp_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col1 '{print $x}'`
        psnr_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col2 '{print $x}'`
        bits_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col3 '{print $x}'`
        ((total_bits[$ii]+=bits_tmp))
        brate=`awk -v x=${total_bits[ii]} -v y=$fps -v z=$j 'BEGIN {printf "%f", x/1000.0/((z+1)*1.0/y)}'`
        echo -n $qp_tmp $bits_tmp $psnr_tmp $brate" ">>$tt

    done
    echo >>$tt
    ((line_no+=1))
    printf "."
done
