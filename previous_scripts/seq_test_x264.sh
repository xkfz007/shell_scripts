#!/bin/bash
seq_name="BlowingBubbles_416x240_50"

frs=50
qp=32
brate=0
rcflag=0 # 0:CQP 1:ABR 
exe="./x264 "
bframes=0

usage(){
    echo "$0 [option]"
    echo "options:"
    echo ' -i input file'
    echo ' -I I frame interval'
    echo ' -f frames to be encoded'
    echo ' -F fps'
    echo ' -W width'
    echo ' -H height'
    echo ' -h help'
    echo ' -q qp'
    echo ' -b Frame level RC'
    echo ' -B bitrate'
    echo ' -t tag'
    echo ' -e execute'
}

while getopts ":i:I:f:F:W:H:hq:bB:t:e:" OPT; do
    case ${OPT} in
        "i") seq_name=${OPTARG} ;;
        "I") interval=${OPTARG} ;;
        "f") frs=${OPTARG} ;;
        "F") fps=${OPTARG} ;;
        "W") width=${OPTARG} ;;
        "H") height=${OPTARG} ;;
        "h") usage;exit ;;
        "q") qp=${OPTARG};rcflag=0;;
        "b") bframes=${OPTARG};;
        "B") brate=${OPTARG};rcflag=1 ;;
        "t") tag=${OPTARG} ;;
        "e") exe=${OPTARG} ;;
    esac
done

if [ "$tag" == "" ];then
    tag=`date +%Y%m%d%H%M%S`
fi

yuv=${seq_name}.yuv
out=${seq_name}_$tag.bin
rec=${seq_name}_rec_$tag.yuv
log=${seq_name}_$tag.log
infile=f:/sequences/$yuv

reso=${seq_name#*_}
reso2=${reso#*x}

if [ "$width" == "" ] || [ "$height" == "" ];then
    width=${reso%x*}
    height=${reso2%%_*}
fi

if [ "$fps" == "" ];then
    fps=${reso2#*_}
    fps=${fps%_*}
#    [ $fps -gt 30 ] && ((fps/=2))
fi

if [ $rcflag -gt 0 ] && [ $brate -eq 0 ];then 
    reso3=$width"x"$height
    case $reso3 in
        "1920x1080" ) base_rate=1500 ;;
        "1280x720"  ) base_rate=600 ;;
        "1024x768"  ) base_rate=568 ;;
        "832x480"   ) base_rate=300 ;;
        "416x240"   ) base_rate=75 ;;
        "640x480"   ) base_rate=222 ;;
        "352x288"   ) base_rate=73 ;;
        "448x336"   ) base_rate=110 ;;
    esac
    ((brate=fps*base_rate*1000/30/1000))
    ((brate*=2))
fi

#basic 
cmd=$exe" -o $out $infile --input-res $width"x"$height --fps $fps -I $interval --no-scenecut -v --no-psy " 
# Frames to be encoded
cmd=$cmd"--frames $frs " 
# Reference Frames
cmd=$cmd"--ref 5 "
# Threads
cmd=$cmd"--threads -1 "
# B frames
cmd=$cmd"-b $bframes --b-adapt 0 "
# ASM
cmd=$cmd"--no-asm "
# PSNR and SSIM
cmd=$cmd"--tune psnr --psnr "
cmd=$cmd"--tune ssim --ssim "

# RateControl
case $rcflag in
    "0" )
        # for CQP
        cmd=$cmd"-q $qp " ;;
    "1" )
        # for ABR
        cmd=$cmd"--bitrate $brate " ;;
    "2" )
        # for VBV-CBR
        vmax=$brate
        #((vbuf=brate+brate/2))
        ((vbuf=2*brate))
        cmd=$cmd"-bitrate $brte --vbv-maxrate $vmax --vbv-bufsize $vbuf " ;;
esac


#OUTPUT
cmd=$cmd" >$log 2>&1 "
echo $PWD
echo $cmd 
eval $cmd
echo $cmd >>$log

