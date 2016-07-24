#!/bin/bash
#get the file extension from filename
function get_fext()
{
    filename=$1
    ext=${filename##*.}
    echo "$ext"
}
function get_fname()
{
    filename=$1
    name=${filename%.*}
    echo $name
}
