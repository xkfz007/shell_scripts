#!/bin/bash
ls -1 .|while read file 
do
    newname="`echo $file |tr '[A-Z]' '[a-z]'`"
    if [ "$newname" = "$file" ]
    then
        echo "$newname.......pass"
        continue
    fi
    mv -v  "$file" "$newname"
done
