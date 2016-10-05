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
#echo "before="$*
#ARGV=($(getopt -o abcd -- "$@")) 
#echo "ARGV="${ARGV[@]}
#echo "middle="$*
#for((i = 0; i < ${#ARGV[@]}; i++)) { 
#    eval opt=${ARGV[$i]} 
#    case $opt in 
#    -a) opts=${opts}"a" ;; 
#    -b) opts=${opts}"b" ;; 
#    -c) opts=${opts}"c" ;; 
#    -d) opts=${opts}"d" ;; 
#    --)
#        ARR=$opt
#       break 
#       ;;
#    esac
#}
#echo "after ="$*
#echo "opts="${opts}
#echo "args="${ARGV[$i+1]}
#echo "ARR="$opt

#set -o 
#
#function replace_line
#{
#   f=$1
#   lineno=$2
#   content=$3
#   sed -i "${lineno}s/.*/${content}/g" $f
#}
#function change_pc
#{
#    f=$1
#    path=$2
#    echo "path1"=$path
#    path2=${path//\//\\\/}
#    echo "path2"=$path2
#    line_content="prefix=$path2"
#    replace_line "$f" 1 "$line_content"
#
#}
##change_pc x265.pc "\/usr\/bin\/"
#change_pc x265.pc "/usr/lib/"
##replace_line x265.pc 1 "\/usr\/bin\/"
#cat x265.pc

