#!/bin/bash
count=1
for i in *files
do
    cd $i
    find . ! -name '*jpg' -exec rm -v {} \;
    cd -
    mv -v $i  ine${count}
    count=$(($count+1))
done
