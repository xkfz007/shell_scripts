#!/bin/bash
# this script is used to get the macroblock data of a image.
# the reason of the script is that during the analysis of the encoding data of
# JM14.1, the data of some specific macroblock is needed
let allrows=144/4-1
let allcols=176/4-1
#echo "allrows="$allrows
#echo "allcols="$allcols
#echo $#
if [ $# -lt 1 ]
then 
   echo "Usage xxx row col"
elif [ $# -eq 1 ]
then
   let row=$2/$allrows
   let col=$2%$allcols
   echo "row="$row
   echo "col="$col
elif [ $# -ge 2 ]
then
   row=$2
   col=$3
   echo "row="$row
   echo "col="$col
fi
let rowS=$row*4+1
let rowE=$rowS+7
let colS=$col*4+1
let colE=$colS+7

sed -n "$rowS"','"$rowE"'p' $1 |awk -v colS=$colS -v colE=$colE '{for(i=colS;i<=colE+1;i++)printf("%s ",$i);printf("\n")}'
