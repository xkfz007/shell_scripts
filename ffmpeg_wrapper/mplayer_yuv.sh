#!/bin/bash
#use mplayer to play yuv files
usage(){
    echo "usage:$0 filename [option]"
    exit
}
[ $# -eq 0 ]&& usage
ARGS=`getopt -o 123r: -- "$@"`
[ $? -ne 0 ] && usage
eval set -- "${ARGS}"
while true
do
    case "$1" in
        -1)
            width=176;height=144;shift;;
        -2)
            width=352;height=288;shift;;
        -3)
            width=704;height=576;shift;;
        -r)
            resl=$2
            width=${resl%x*}
            height=${resl#*x}
            shift 2;;
        --)
            shift;break;;
    esac
done
filename=$1
[ -z $filename ] && (echo "please give the filename")&&usage
if [ -z $width ] || [ -z $height ]
then
    width=176
    height=144
fi
eval mplayer -demuxer rawvideo -rawvideo w=$width:h=$height $filename 





