#!/bin/bash
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

while getopts ':abcd' opt; do
    case "$opt" in
        [a-d]) eval opt_"$opt"=y ;;
        \?) exit 1 ;;
    esac
done
shift $((OPTIND-1))

if [ x"$1" == 'x--' ]; then 
    shift 
fi

printf '%s\n' "$opt_a" "$opt_b" "$opt_c" "$opt_d" "$@"
