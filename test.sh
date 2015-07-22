#!/bin/bash
#. ./functions.lbr
#
#seq_name=navyflight_1920x1088_30_2973
#reso_info=($(get_reso_info $seq_name))
#nSrcWidth=${reso_info[0]}
#nSrcHeight=${reso_info[1]}
#fFrameRate=${reso_info[2]}
#echo ${reso_info[@]}
#trace_flag=0
#((trace_flag|=2))
#echo $trace_flag
#
#reso="1920x1088"
#width=${reso%x*}
#height=${reso#*x}
#echo $width
#echo $height
echo "before="$*
ARGV=($(getopt -o abcd -- "$@")) 
echo "ARGV="${ARGV[@]}
echo "middle="$*
for((i = 0; i < ${#ARGV[@]}; i++)) { 
    eval opt=${ARGV[$i]} 
    case $opt in 
    -a) opts=${opts}"a" ;; 
    -b) opts=${opts}"b" ;; 
    -c) opts=${opts}"c" ;; 
    -d) opts=${opts}"d" ;; 
    --)
        ARR=$opt
       break 
       ;;
    esac
}
echo "after ="$*
echo "opts="${opts}
echo "args="${ARGV[$i+1]}
echo "ARR="$opt

