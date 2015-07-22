#!/bin/bash
for i in *
do
    if [ ! -d $i ];then
        continue
    fi
    cd $i
    \rm -v *gif *html *htm *js
    for j in *
    do
        if [ -d $j ]
        then
            \rm -rv $j
            continue
        fi
        #找出含有jpg或jpeg的图片
        a=`echo $j|grep jpg`
        xa=`echo $?`
        b=`echo $j|grep jpeg`
        xb=`echo $?`
       if [ $xa -eq 1 ] && [ $xb -eq 1 ]
       then
           \rm -v $j
           continue
       fi
       #得到图片的尺寸
       sze=`identify $j|awk '{print $3}'`
       width=${sze%x*}
       height=${sze#*x}
       if [ $width -lt 400 ] && [ $height -lt 400 ]
       then
           \rm -v $j
       fi
   done
   cd .. 
done
