#!/bin/bash
usage(){
    echo "usage:$0 filename [option]"
    exit
}
[ $# -eq 0 ]&& usage
ARGS=`getopt -o 12f: -- "$@"`
[ $? -ne 0 ] && usage
eval set -- "${ARGS}"
echo $@
while true
do
    case "$1" in
        -1)
            fps=15;shift;;
        -2)
            fps=30;shift;;
        -f)
            fps=$2
            tmp=${ftp//[0-9]/}
            test -z $tmp && echo "fps should be a number"&&exit
            shift 2;;
        --)
            shift;break;;
    esac
done
filename=$1
#echo $filename
[ -z $filename ] && (echo "please give the filename")&&usage
if [ -z $fps ] 
then
    fps=30
fi
eval mplayer -fps $fps $filename



