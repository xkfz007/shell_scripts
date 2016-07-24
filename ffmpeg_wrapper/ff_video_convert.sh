#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/trunk/funcs.sh
#duration="-ss 00:10:00 -t 00:00:30"
extra_opts="-threads 2"
#ffmpeg.exe -i *Monsters*rmvb -vf scale=-2:576 $extra_opts Monsters.1024x576.mp4 -y
#ffmpeg.exe -i *The.Imitation.Game.2014.*rmvb -vf scale=-2:576 $extra_opts The.Imitation.Game.2014.1024x576.mp4 -y
#ffmpeg.exe -i Dogville.2003.*mkv -vf scale=-2:480 -c:a copy $extra_opts Dogville.2003.480p.mkv -y
dir_list='PBS*LINCOLNS PBS*Woodrow*Wilson Teddy* '
for j in $dir_list
do
    echo $j
    cd "${j}"
    for i in *
    do
        name=$(get_fname $i)
        ext=$(get_fext $i)
        if  [ ! "$ext" = "mp4" ] && [ ! "$ext" = "mkv" ];then
            continue
        fi
        new_name=${i}.mp4
        cmd="ffmpeg.exe -y -i \"${i}\" $extra_opts $duration \"${new_name}\""
        echo $cmd
        #eval $cmd
    done
    cd ..
done
for j in dmg*/*
do
    name=$(get_fname $j)
    ext=$(get_fext $j)
    new_name=$name".480p."$ext
    cmd="ffmpeg.exe -y -i \"${j}\" -vf scale=-2:480 -c:a copy $extra_opts $duration \"${new_name}\""
    echo $cmd
    #eval $cmd
done

for j in *5000*/*
do
    name=$(get_fname $j)
    ext=$(get_fext $j)
    if [ ! $ext = "avi" ];then
        continue
    fi
    
    new_name=$name".mp4"
    cmd="ffmpeg.exe -y -i \"${j}\" $extra_opts $duration \"${new_name}\""
    echo $cmd
    #eval $cmd
done
#ffmpeg.exe -i ./supercarrier.uss.ronald.regan.720p-dhd.mkv -vf scale=-2:480 -c:a copy $extra_opts supercarrier.uss.ronald.regan.480p.mkv

