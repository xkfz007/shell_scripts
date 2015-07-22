#!/bin/bash
#[ $# -lt 2 ] && exit
tag=`date "+%Y%m%d%H%M"`
msg="first commit $tag"
git init
git add *
cmd="git commit -m $msg"
eval $cmd
cmd="git remote add origin git@github.com:xkfz007/$1.git"
eval $cmd
git push -u origin master

