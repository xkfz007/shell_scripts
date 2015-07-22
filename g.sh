#!/bin/bash
if [ $# -lt 1 ];then
   grep --help 
   exit
fi
opts=()
args=()
while [ $# -gt 0 ]; do
    case "$1" in
        -*) opts+=("$1") ;;
        *)  args+=("$1") ;;
    esac
    shift
done

opts+=("${args[@]}")
set -- "${opts[@]}"

while getopts ":iwxnor" OPT; do
    case ${OPT} in
        "i") opt_str=${opt_str}"i";;
        "w") opt_str=${opt_str}"w";;
        "x") opt_str=${opt_str}"x";;
        "n") opt_str=${opt_str}"n";;
        "o") opt_str=${opt_str}"o";;
        "r") opt_str=${opt_str}"r";;
        \?)
            echo "Unexpected Arguments"
            exit;;
    esac
done 
shift $(($OPTIND - 1))

if [ x"$1" == 'x--' ]; then 
    shift 
fi
echo "argv=$*"
str=""
if [ ! -z "$*" ];then
    str="$1"
fi
dir_or_file=""
if [ ! -z "$*" ];then
    dir_or_file="$2"
fi

echo "opt_str="${opt_str}
echo "str="$str
echo "dir_or_file="${dir_or_file}

cmd_line="grep -$opt_str $str $dir_or_file"
echo $cmd_line

