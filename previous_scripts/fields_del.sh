#!/bin/bash
#set -xv
cons=cons.txt
col1=`grep "POC    0" $cons | awk '{for(i=1;i<=NF;i++) if( $i =="short_cplxsum="){print i;break} }'`
if [ "$col" = "" ];then
    col1=0
fi

col2=`grep "POC    0" $cons | awk '{for(i=1;i<=NF;i++) if( $i =="qscale="){print i;break} }'`
if [ "$co2" = "" ];then
    col2=0
else
    ((col2++))
fi

line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
((line_no1+=2))
frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`
#echo $frames

line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`
for (( j=1;j<$line_no;j++ ))
do
    line=`sed -n -e "${j}p" $cons`
    echo $line
done
for (( j=0;j<$frames;j++ ))
do
    line=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col1 -v y=$col2 '{for(i=1;i<=NF;i++)if(i<x||i>y) {print $i" "}}'`
    echo $line
    ((line_no+=1))
#    printf "."
done

total_num=`awk 'END{print NR}' $cons`

for (( j=$line_no;j<=$total_num;j++ ))
do
    line=`sed -n -e "${j}p" $cons`
    echo $line
done

