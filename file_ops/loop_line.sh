#! /bin/bash

var=$(cat loop_line.sh)

echo "Process Substitution"
while read line
do
        echo "$line"
done < <(echo "$var")

echo "Pipe"
echo "$var" | while read line
do
        echo "$line"
done

echo "Here Document"
while read line
do
        echo "$line"
done <<!
$var
!

echo "Here String"
while read line
do
        echo "$line"
done <<< "$var"

exit
