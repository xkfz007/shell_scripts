#!/bin/bash
. ./functions.lbr

seq_name=navyflight_1920x1088_30_2973
reso_info=($(get_reso_info $seq_name))
nSrcWidth=${reso_info[0]}
nSrcHeight=${reso_info[1]}
fFrameRate=${reso_info[2]}
echo ${reso_info[@]}
trace_flag=0
((trace_flag|=2))
echo $trace_flag

reso="1920x1088"
width=${reso%x*}
height=${reso#*x}
echo $width
echo $height
