#!/bin/bash
usage(){
    echo "usage:eraseblank [dir/filename]"
}
rep_ops(){
    name=$(echo "$1"|tr -d [:space:])
  name2=$(echo $name|sed -e 's/。/\./g' \
      -e 's/，/,/g' \
      -e 's/　//g' \
      -e 's/；/\;/g' \
      -e 's/？/?/g' \
      -e 's/：/\:/g' \
      -e "s/’/\'/g" \
      -e "s/‘/\'/g" \
      -e 's/”/\"/g' \
      -e 's/“/\"/g' \
      -e 's/《/\</g' \
      -e 's/》/\>/g' \
      -e 's/——/_/g' \
      -e 's/【/[/g' \
      -e 's/】/]/g' \
      -e 's/（/\(/g' \
      -e 's/）/\)/g' \
      -e 's/……/^/g' \
      -e 's/！/\!/g' \
      -e 's/『/\{/g' \
      -e 's/』/\}/g' \
      -e 's/￥/\$/g')                     
  echo $name2
}
rename(){
    name=$(rep_ops "$1")
    if [ "$1" = "$name" ]
    then
        echo $1".....pass"
    else
        mv -v "$1" "$name"
    fi
}
case $# in
    0)
        for i in *
        do
            rename "$i"
        done
       
        ;;
    1)
        test ! -e "$1" && ( echo "$1"" not exist!";exit)
        rename "$1"
        ;;
esac


