#!/bin/bash
#version 2

function mount_remote_dir(){
if [ $# -lt 2 ];then
echo "Not enough arguments"
exit
fi
local_dir=$1
#echo $local_dir
remote_dir=$2
#echo $remote_dir

if [ ! -d "$local_dir" ];then
    mkdir -p "$local_dir"
fi
dir_stat=$(mount -l|grep $local_dir)
#echo $dir_stat
if [ "$dir_stat" == "" ];then
mount -t nfs "$remote_dir" "$local_dir"
echo "$remote_dir is mounted under $local_dir"
else
echo "$remote_dir has already been mounted under $local_dir"
fi

}

dir1="/mnt/remote/r1"
dir2="/mnt/remote/r2"
dir3="/mnt/remote/r3"
dir4="/mnt/remote/r4"
remote1="172.17.108.123:/vx/C16_ZBLZ1"
remote2="172.17.108.124:/vx/C16_ZBLZ2"
remote3="172.17.108.125:/vx/C17_ZBLZ3"
remote4="172.17.108.126:/vx/C17_ZBLZ4"

mount_remote_dir $dir1 $remote1
mount_remote_dir $dir2 $remote2
mount_remote_dir $dir3 $remote3
mount_remote_dir $dir4 $remote4


#if [ ! -d "$dir1" ];then
#    mkdir -p "$dir1"
#fi
#
#if [ ! -d "$dir2" ];then
#    mkdir -p "$dir2"
#fi
#
#if [ ! -d "$dir3" ];then
#    mkdir -p "$dir3"
#fi
#
#if [ ! -d "$dir4" ];then
#    mkdir -p "$dir4"
#fi
#
#r1_stat=$(mount -l|grep $dir1)
#if [ "$r1_stat" == "" ];then
#mount -t nfs "$remote1" "$dir1"
#fi

#mount -t nfs "$remote1" "$dir1"
#echo "$remote1 is mounted under $dir1"
#mount -t nfs "$remote2" "$dir2"
#echo "$remote2 is mounted under $dir2"
#mount -t nfs "$remote3" "$dir3"
#echo "$remote3 is mounted under $dir3"
