#!/bin/bash
# this is used to test some programs
limit=10000
for(( i=0;i<100;++i))
do
    a=`echo $(($RANDOM%$limit))`
    b=`echo $(($RANDOM%$limit))`
    r1=`expr $a \* $b`
    r2=`./big_int_multiply $a $b`
    echo -ne "a=$a\tb=$b\tr1=$r1\tr2=$r2\t"
    if [ $r1 -eq $r2 ]
    then
        echo "ok"
    else
        echo "ohh,bad"
    fi
done


