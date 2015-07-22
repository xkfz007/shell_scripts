#!/bin/bash
set -- `getopt -o abcd -- "$@"`  
while [ -n "$1" ]  
do  
  case "$1" in  
  -a)  echo "option -a";;  
  -b)  echo "option -b";;  
  -c) echo "option -c";;  
  -d) echo "option -d";;  
  --) shift  
      break;;  
  *) echo "$1 not option";;  
 esac  
 shift  
done  
echo $*
count=1  
for para in "$@"  
do  
 echo "#$count=$para"  
 count=$[$count+1]  
done 
