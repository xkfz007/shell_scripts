#!/bin/bash
#seq_name=BasketballDrill_832x480_50
#seq_name=BasketballPass_416x240_50
seq_name=BlowingBubbles_416x240_50
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
if [ $# -gt 0 ];then
    seq_name=$1
fi
if [ "$seq_name" = "" ]
then
    echo Sequence should be specified!
    exit
fi
frs=300
if [ $# -gt 1 ];then
    frs=$2
fi

tag=`date +%Y%m%d%H%M%S`
yuv=${seq_name}.yuv
out=${seq_name}_$tag.264
rec=${seq_name}_rec_$tag.yuv
cons=${seq_name}_cons_$tag.txt

reso=${seq_name#*_}
width=${reso%x*}
reso2=${reso#*x}
height=${reso2%%_*}
fps=${reso2#*_}
fps=${fps%_*}
#fps=25
#frs=$fps #FramesToBeEncoded

if [ $width = 1920 ] && [ $height = 1080 ]
then
    brate=4000
elif [ $width = 1280 ] && [ $height = 720 ]
then
    brate=1800
elif [ $width = 1024 ] && [ $height = 768 ]
then
    brate=1600
elif [ $width = 832 ] && [ $height = 480 ]
then
    brate=800
elif [ $width = 416 ] && [ $height = 240 ]
then
    brate=200
fi
#brate=1767
((brate*=1000))

rem=$((fps%2))
if [ $rem -eq 0 ];then
    interval=$fps
else
    quo=$((fps/2))
    quo=$((quo+1))
    interval=$((quo*2))
fi
infile=e:/sequences/$yuv
#infile=//172.20.60.27/hfz/sequences/$yuv
rcflag=0
((bunit=width/16))
rcmode=0
qpi=32
((qpp=qpi+1))

 cmd="./lencod.exe -f encoder_JM_LP_HEVC.cfg -p InputFile=$infile -p OutputFile=$out -p ReconFile=$rec -p FrameRate=$fps     -p SourceWidth=$width -p SourceHeight=$height -p FramesToBeEncoded=$frs -p IntraPeriod=$interval -p RateControlEnable=$rcflag -p BasicUnit=$bunit -p Bitrate=$brate -p RCUpdateMode=$rcmode -p QPISlice=$qpi -p QPPSlice=$qpp | tee $cons " 
echo "$cmd"
eval $cmd
