#!/bin/bash
usage(){
    echo "$0 [option]"
    echo "options:"
    echo ' -i <string> input_file'
    echo ' -C <string> the ffmpeg commands'
    echo ' -e the output file extension'
    echo ' -h print this help'
    echo ' -H print the help of ffmpeg'
}
FFMPEG_BIN="ffmpeg.exe"
input_file=""
output_file=""
extra_cmd=""
ext=""

while getopts ":i:C:e:hH" OPT; do
    case ${OPT} in
        "i") input_file=${OPTARG} ;;
        "C") extra_cmd=${OPTARG} ;;
        "e") ext=${OPTARG} ;;
        "h") usage;exit ;;
        "H") 
            cmd_line=$FFMPEG_BIN" -h"
            eval $cmd_line
            exit;;
        *)
            echo "Unexpected Arguments"
            exit;;
    esac
done 
shift $(($OPTIND - 1))

if [ ! -z "$*" ];then
    output_file="$*"
fi

echo $input_file
echo $output_file
if [ -z $input_file ];then
    usage;
    exit;
fi
file_name=${input_file%.*}
file_ext=${input_file##*.}
echo $file_name
echo $file_ext

if [ -z $output_file ];then
    if [ -z $ext ];then
        output_file=$file_name"_out"$file_ext
    else
        if [ ${ext:0:1} != '.' ];then
            ext="."$ext
        fi
        output_file=$file_name$ext
    fi
fi

cmd_line=$FFMPEG_BIN
cmd_line=$cmd_line" -i "$input_file
cmd_line=$cmd_line" "$extra_cmd
cmd_line=$cmd_line" "$output_file
echo $cmd_line
eval $cmd_line

