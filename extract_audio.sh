#!/bin/bash
#should execute this script under the directory
. /cygdrive/d/workspace/as265_shell_scripts/trunk/funcs.sh
#duration="-ss 00:10:00 -t 00:00:30"
extra_opts="-threads 2"
if [ $# -eq 0 ];then
    dirname="."
else
    dirname=$1
fi
v_cmd="-vn"
a_cmd_pre="-c:a"

for i in $dirname/*
do
    #echo $i
    name=$(get_fname "$i")
    ext=$(get_fext "$i")
    case $ext in 
        [Mm][Pp]4|[Ff][Ll][Vv]|[Mm][Kk][Vv])
            new_ext="aac"
            a_enc="copy"
            ;;
        [Aa][Vv][Ii])
            new_ext="mp3"
            a_enc="copy"
            ;;
        [Rr][Mm][Vv][Bb])
            new_ext="mp3"
            a_enc="libmp3lame"
            a_cmd_post="-b:a 64k"
            #new_ext="ra"
            #a_enc="copy"
            ;;
        *)
            echo "\"$i\": not supported video file"
            continue
    esac
    new_name="$name.$new_ext"
    a_cmd="$a_cmd_pre $a_enc $a_cmd_post"
    cmd="ffmpeg.exe -y -i \"$i\" $v_cmd $a_cmd $extra_opts \"${new_name}\""
    echo $cmd
    eval $cmd
done


