#!/bin/bash
filename="0001.中国网络电视台-《特别呈现》 2011-02-03 《帝国的兴衰》 第一集.mp4"
 . /cygdrive/d/workspace/as265_shell_scripts/trunk/funcs.sh
name=${filename%.*}
ext=${filename##*.}
name=$(get_fname "$filename")
ext=$(get_fext "$filename")
echo $name
echo $ext

