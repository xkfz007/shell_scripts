#!/bin/bash
if [ $# -lt 1 ];then
    echo "Not enough arguments"
    exit
fi
file_test="$1/all_data.txt"
file_testa="$1-a/all_data.txt"
file_testb="$1-b/all_data.txt"
file_testc="$1-c/all_data.txt"

#echo $file_test
#echo $file_testa
#echo $file_testb
#echo $file_testc

[ -f "$file_test" ] && [ -f "$file_testa" ] && [ -f "$file_testb" ] && [ -f "$file_testc" ] || exit


exec 3<"$file_test"
exec 4<"$file_testa"
exec 5<"$file_testb"
exec 6<"$file_testc"

dir=$(basename $1)
tt=${dir}_data_of_all_qp.txt
[ -f $tt ] && >$tt || touch $tt

while read line <&3 && read linea <&4 && read lineb <&5 && read linec <&6
do
    echo $line >>$tt
    echo -n "."
    echo $linea >>$tt
    echo -n "."
    echo $lineb >>$tt
    echo -n "."
    echo $linec >>$tt
    echo -n "#"
done


