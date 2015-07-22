#!/bin/bash
case $# in
    2)
        y4m_file=$1
        dname=$2
        ;;
    1)
        y4m_file=$1
        dname=`dirname $y4m_file`
        ;;
    *)
        echo "usage:y4m2yuv *.y4m [savepath]"
        exit
esac
test ! -f $y4m_file && (echo "$y4m_file doesn't exist!";exit)
test ! -d $dname && mkdir $dname
y4mname=`basename $y4m_file`
tmpname=${y4mname%.y4m}
yuvname=${tmpname}.yuv
yuv_file=${dname}"/"${yuvname}
echo -e $y4m_file" -> "$yuv_file
mencoder $y4m_file -ovc raw -of rawvideo -vf format=i420 -o $yuv_file
