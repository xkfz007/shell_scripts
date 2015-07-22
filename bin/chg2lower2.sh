#!/bin/bash
files=`ls -1 $path`
for i in "$files"
do
    mv -v "$i" "`echo $i |tr '[A-Z]' '[a-z]'`"
done
