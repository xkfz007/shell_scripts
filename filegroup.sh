#!/bin/bash
files=`ls *.h *.c`

for fl in $files
do
   num=`awk '/Chapter/{x=length($4);print substr($4,1,x-1)}' $fl`
   len=`expr length $num`
   if [ $len -eq 1 ]
   then
      dirname=ch0$num
   else
      dirname=ch$num
   fi
   
   if !([  -d $dirname ])
   then
     mkdir $dirname
   fi
   mv -v $fl $dirname
done
