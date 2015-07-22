#!/bin/bash
#cal the size of some dirs
#usage:before using the program, you should initialize the environment varibles "path" and "dirs"
cd $path
for i in $dirs
do
  dirSize=`du -s $i|awk '{print $1}'`
  dirSize2=`echo $dirSize/1024|bc`
  dirSize3=`echo $dirSize/1024/1024|bc`
  echo $dirSize" "$dirSize2"MB  "$dirSize"GB"
  let "total=$total+$dirSize"
done
total2=`echo $total/1024|bc -l`
total3=`echo $total/1024/1024|bc -l`
echo "total="$total"  " $total2"MB "$total3"GB"

cd -
