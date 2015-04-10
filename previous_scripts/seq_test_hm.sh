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
#qpstep=2
#ratetol=1.0
#decay=1.0
#ipfactor=1.0

qp=37
shflag=0
rdoq=0
rcflag=0
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
    echo ' -c cfg'
    echo ' -T tag'
    echo ' -t Trellis'
}

while getopts ":i:I:f:F:W:H:hq:c:T:t" OPT; do
    case ${OPT} in
        "i") seq_name=${OPTARG} ;;
        "I") interval=${OPTARG} ;;
        "f") frs=${OPTARG} ;;
        "F") fps=${OPTARG} ;;
        "W") width=${OPTARG} ;;
        "H") height=${OPTARG} ;;
        "h") usage;exit ;;
        "q") qp=${OPTARG};;
        "c") cfg=${OPTARG} ;;
        "T") tag=${OPTARG} ;;
        "t") rdoq=1 ;;
    esac
done

if [ "$cfg" == "" ]; then
    #cfg=encoder_lowdelay_B_main_std_gop4_ref1_test2.cfg
    #cfg=encoder_lowdelay_P_main_std_gop2_ref1_test2.cfg
    #cfg=encoder_lowdelay_P_main_std_gop1_ref1_test2.cfg
#    cfg=E:/STD.HEVC/hm.docs/encoder_randomaccess_main_gop4.cfg
    cfg=E:/STD.HEVC/hm.docs/encoder_randomaccess_main.cfg
fi
if [ "$tag" = "" ];then
    tag=`date +%Y%m%d%H%M%S`
fi
yuv=${seq_name}.yuv
bin=${seq_name}_$tag.bin
rec=${seq_name}_rec_$tag.yuv
log=${seq_name}_$tag.log
infile=f:/sequences/$yuv
if [ "$width" == "" ] || [ "$height" == "" ];then
    reso=${seq_name#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
fi
if [ "$fps" == "" ];then
    fps=${reso2#*_}
    fps=${fps%_*}
fi

if [ "$gopsize" == "" ];then
    gopsize=$(grep "GOPSize" $cfg|awk '{print $3}')
#    gopsize=${cfg#*gop}
#    gopsize=${gopsize%%_*}
fi
#echo $gopsize

if [ "$interval" == "" ];then
    interval=$fps
#    if (( interval<30 )) ; then
#        interval=30
#    fi
    rem=$((interval%gopsize))
    if [ $rem -ne 0 ];then
        quo=$((interval/gopsize))
        quo=$((quo+1))
        interval=$((quo*gopsize))
    fi
fi

exe=E:/SRC.HM/HM-14.0/bin/vc10/Win32/Debug/TAppEncoder.exe 

cmd="$exe -c $cfg --InputFile=$infile --BitstreamFile=$bin --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --IntraPeriod=$interval "

#Set QP value
cmd=$cmd" --QP=$qp "

# RateControl
cmd=$cmd"--RateControl=0 "

# RDQO
cmd=$cmd"--RDOQ=$rdoq "

# SignHideFlag
cmd=$cmd" --SignHideFlag=$shflag "


cmd=$cmd" | tee $log -a"
echo "$cmd" >$log
eval $cmd
