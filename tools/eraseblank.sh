#!/bin/bash
usage(){
    echo "usage:eraseblank [dir/filename]"
}
rep_ops(){
    #name=$(echo "$1"|tr -d [:space:])
    name=$(echo "$1"|sed -e 's/ //g'\
        -e 's/,/\./g' \
    )
    #name2=$(echo $name|sed -e 's/。/\./g' \
    #    -e 's/，/\./g' \
    #    -e 's/　//g' \
    #    -e 's/；/\;/g' \
    #    -e 's/？/?/g' \
    #    -e 's/：/\./g' \
    #    -e "s/’/\'/g" \
    #    -e "s/‘/\'/g" \
    #    -e 's/”/\./g' \
    #    -e 's/“/\./g' \
    #    -e 's/《/\./g' \
    #    -e 's/》/\./g' \
    #    -e 's/——/_/g' \
    #    -e 's/【/[/g' \
    #    -e 's/】/]/g' \
    #    -e 's/（/\(/g' \
    #    -e 's/）/\)/g' \
    #    -e 's/……/\./g' \
    #    -e 's/！/\./g' \
    #    -e 's/『/\{/g' \
    #    -e 's/』/\}/g' \
    #    -e 's/￥/\$/g'\
    #    )
    echo $name
}
rename(){
    fname=$(basename "$1")
    dname=$(dirname "$1")

    #name=$(rep_ops "$1")
    new_name=$(rep_ops "$fname")
    if [ "$fname" = "$new_name" ]
    then
        echo $1".....pass"
    else
        cmd="mv -v \"$dname/$fname\" \"$dname/$new_name\""
        echo $cmd
        eval $cmd
    fi
}

if [ $# -eq 0 ]
then
    usage
    exit
else
    for i in "$@"
    do
        #echo $i
        if [ -f "$i" ]
        then
            test ! -e "$i" && ( echo "$i"" not exist!";exit)
            rename "$i"
        elif [ -d "$i" ]
        then
            for file in "$i"/*
            do
                rename "$file"
            done
        else
            echo "\"$i\" not exist!"
        fi
    done
fi





