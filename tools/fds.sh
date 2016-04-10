#!/bin/bash
num=`echo $RANDOM`
echo $num
season=`expr $num % 11`
epis=`expr $num % 25`
echo $epis
if [ ! -d "/media/NETAC" ]; then
    exit
fi

path="/media/NETAC/movies/americantv/friends/"

path2=$path"*$season/"
file=$path2"*$epis*"
echo $file
mplayer $file
#eval `cd $path2`
