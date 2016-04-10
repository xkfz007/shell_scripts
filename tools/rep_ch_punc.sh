#!/bin/bash
case $# in
    0)
        echo "usage:rep_cn_punc dir/filename"
        exit
        ;;
    *)
        for i in $@
        do
            name=$(echo $i|sed -e 's/。/\./g' \
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
            echo $name
        done
        ;;
esac
            
