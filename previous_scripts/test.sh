#!/bin/bash

#tt=psnr_data.txt
#[ -f $tt ] && > $tt || touch $tt

#fps=50

cons=cons2.txt
#line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
#((line_no1+=2))
#frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`

#line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`
#psnr_sum=0
#echo -n $i" " >>$tt

#col=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="bits" ){print i;break} }'`
#((col--))
#echo $col
#col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost=" ){print i;break} }'`
#((col2++))
#echo $col2
#col_array=($col $col2)
#echo ${#col_array}
#echo ${col_array[@]}

#grep -n "I-SLICE," cons2.txt |awk -v x=$col -v y=$col2 '{print $x,$y}'
#nums=(`grep -n "I-SLICE," cons2.txt |awk -F: '{print $1}'`)
#echo ${nums[*]}
#len=`echo ${#nums[@]}`

#for ((i=0;i<$len;i++))
#do
#    linum=${nums[i]}
#    bits=`sed -n -e "$linum"'p' $cons |awk -v x=$col '{print $x}'`
#    ((linum++))
#    sad=`sed -n -e "$linum"'p' $cons |awk -v x=$col2 '{print $x}'`
#    echo $sad  $bits

#done
flag="20 20 20 20 10 10 10 10 10 10 10 10 20 20 10 8 8 10 20 20 20 10 10 10 10 10 20"
flag_added="10 20 20 20 15 10 10 20"
flag=$flag" "$flag_added
flag=($flag) 
echo ${flag[@]}
