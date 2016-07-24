#!/bin/bash
let allrows=144/16
let allcols=176/16
#echo "allrows="$allrows
#echo "allcols="$allcols
#echo $#
if [ $# -lt 1 ]
then 
   echo "Usage xxx row col"
elif [ $# -eq 1 ]
then
   let row=$1/$allrows
   let col=$1%$allcols
   echo "[row,col]=["$row","$col"]"
elif [ $# -ge 2 ]
then
   row=$1
   col=$2
   echo "[row,col]=["$row","$col"]"
fi
let rowS=$row*4+1
let rowE=$rowS+3
let colS1=$col*4+1
let colS2=$col*4+2
let colS3=$col*4+3
let colS4=$col*4+4
#echo "colS1="$colS1 "colS2="$colS2 "colS3"=$colS3 "colS4"=$colS4
#aa="${rowS},${rowE}"
#echo $aa
#sed -n "$rowS"','"$rowE"'p' mv.txt |awk '{print $colS1 $colS2 $colS3 $colS4}'
sed -n "$rowS"','"$rowE"'p' mv.txt |awk -v colS1=$colS1 -v colS2=$colS2 -v colS3=$colS3 -v colS4=$colS4 '{for(i=colS1;i<=colS4;i++) printf("%s ",$i);printf("\n")}'
