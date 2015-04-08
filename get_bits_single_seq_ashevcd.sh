#!/bin/bash
cons=cons.txt
if [ $# -gt 0 ];then
    cons=$1
fi
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
tt=bits_each_frame.txt
test_file $tt
idx=3
#format_string="Frm.*" 
#cmd="grep -o $format_string $cons"
#cmd="$cmd|awk '{print \$$idx}'"
#cmd="$cmd|tr -t '\n' ' '"
. create_ashevcd_cmd.seg
echo $cmd
frame_bits=$(eval $cmd) 
#frame_bf=$(obtain_frame_bits $cons)
#frame_bits=$(grep -o "Frm.*" $cons|awk '{print $3}'|tr -t '\n' ' ')

echo $frame_bits >$tt

