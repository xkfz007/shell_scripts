#!/bin/bash
num=`echo $RANDOM`
echo $num
season=`expr $num % 3`
epis=`expr $num % 62`
echo $epis
path="/media/HITACHI/animation/The.Penguins.of.Madagascar/"
path2=$path"*$season/"
file=$path2"*$epis*"
echo $file
mplayer $file
#eval `cd $path2`
