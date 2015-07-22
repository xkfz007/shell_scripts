#!/bin/bash
count=1
while read line
do
   # echo $count
    newline=${line#*$count}
    echo $newline
    let "count+=1"
done < $1
