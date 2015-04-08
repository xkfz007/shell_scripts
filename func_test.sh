#!/bin/bash
function  get_param
{
    a="a"
    echo $a
    a="b"
    echo $a
    a="c"
    echo $a
    a="d"
    echo $a
}
res=($(get_param))
echo ${res[0]}
echo ${res[1]}
echo ${res[2]}
echo ${res[3]}
echo ${res[2]}
