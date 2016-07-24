#!/bin/bash
FFMPEG_BIN="ffmpeg.exe"
input_file=""
output_file=""
extra_cmd=""
ext=""

cmd="for i in ./$input_list;\
do\
    echo \$i;\
    ffmpeg.exe -i \"\$i\" -vn -c:a copy \"a.aac\";\
done"
echo $cmd

input_list="./*6*mp4 ./*7*mp4"
for i in $input_list
do
    echo $i
    cmd="ffmpeg.exe -i \"$i\" -vn -c:a copy \"$i.aac\" -y"
    echo $cmd
    eval $cmd
done

#cmd_line=$FFMPEG_BIN
#cmd_line=$cmd_line" -i \"$input_file\""
#cmd_line=$cmd_line" "$extra_cmd
#cmd_line=$cmd_line" \"$output_file\""
#echo $cmd_line
#eval $cmd_line

