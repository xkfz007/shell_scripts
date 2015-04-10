#!/bin/bash
#seq_name=BasketballDrill_832x480_50
#seq_name=BasketballPass_416x240_50
#seq_name=BlowingBubbles_416x240_50
#seq_name=BlowingBubbles2_416x240_50
#seq_name=BQMall_832x480_60
#seq_name=BQMall2_832x480_60
#seq_name=PartyScene_832x480_50
#seq_name=PartyScene2_832x480_50
#seq_name=PartyScene3_832x480_50
#seq_name=bus_352x288_25
#seq_name=akiyo_176x144_25
#seq_name=Keiba_416x240_30
#seq_name=Flowervase_416x240_30
#seq_name=FourPeople_1280x720_60

seq_name=Mobisode2_416x240_30
frs=50
qp=32
brate=0
rcflag=0 # 0:CQP 1:ABR 
exe="./x265.exe "
bframes=0
aqmode=0
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
        "q") qp=${OPTARG};;
        "b") abrflag=1 ;;
        "B") brate=${OPTARG};abrflag=1 ;;
        "t") tag=${OPTARG} ;;
        "e") exe=${OPTARG} ;;
    esac
done
if [ "$tag" == "" ];then
    tag=`date +%Y%m%d%H%M%S`
fi
yuv=${seq_name}.yuv
out=${seq_name}_str_$tag.bin
rec=${seq_name}_rec_$tag.yuv
log=${seq_name}_$tag.log
infile=e:/sequences/$yuv

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

if [ $abrflag -eq 1 ] && [ $brate -eq 0 ];then 
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
#cmd="./DivX265_1.1.18.exe -i $infile -o $out -s $width"x"$height -fps $fps -n $frs -br $brate -v | tee $log -a"

#basic 
cmd=$exe" -o $out $infile --input-res $width"x"$height --fps $fps -I $interval --no-scenecut --log-level full " 
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
        cmd=$cmd"--bitrate $brte --vbv-maxrate $vmax --vbv-bufsize $vbuf " ;;
esac
# VAQ
cmd=$cmd"--aq-mode $aqmode "
# CUTREE
cmd=$cmd"--no-cutree "

#OUTPUT
cmd=$cmd" >$log 2>&1 "

echo $PWD
echo $cmd 
eval $cmd
echo $cmd >>$log
