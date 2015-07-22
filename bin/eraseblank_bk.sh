#!/bin/bash
if [ $# -gt 0 ]
then
    name="$(echo "$1"|tr -d [:space:])"
#   echo $name
    if [ "$name" = "$1" ]
    then 
        echo "$1 .....pass"
        continue
    fi
    mv -v  "$1" "$name"
else
    
    for i in *
    do
        name="$(echo "$i"|tr -d [:space:])"
    #    echo $name
        if [ "$name" = "$i" ]
        then 
            echo "$i .....pass"
            continue
        fi
        mv -v  "$i" "$name"
    done
fi  

