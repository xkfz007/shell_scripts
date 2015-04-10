#!/bin/bash
#seq_list="ChinaSpeed_1024x768_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 SlideEditing_1280x720_30 SlideShow_1280x720_20 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop"

seq_list="BasketballDrill_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60"

qpi=22
if [ $# -ge 1 ]
then
    qpi=$1
fi

case $qpi in
    "22" )
        target=( 8570 4004 3315 3298 1655 1401 34323 75171 36255 8483 13592 9087 23966 52342 )
        ;;
    "27" )
        target=( 4921 1695 1020 1320 1227 903 12689 17032 10706 4068 5693 4441 9448 25491 )
        ;;
    "32" )
        target=( 2709 877 471 648 886 566 5925 5433 4876 2093 2505 2290 4242 13696 )
        ;;
    "37" )
        target=( 1391 479 254 350 622 352 3033 2210 2325 1076 1150 1231 2166 7765 )
        ;;
    "42" )
        target=( 660 259 146 196 393 221 1721 1058 1201 594 588 720 1194 4624 )
        ;;
    "47" )
        target=( 282 138 87 111 211 136 991 670 636 333 289 437 725 2657 )
        ;;
esac

((qpp=qpi+1))

frs=300 #FramesToBeEncoded

rcflag=1
bunit=1
rcmode=0

brate=0

j=0
for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    yuv=${i}.yuv
    out=${i}.264
    rec=${i}_rec.yuv
    cons=${i}_cons.txt
    infile="D:\\hfz\\sequences\\"$yuv

    rem=$((fps%2))
    if [ $rem -eq 0 ]
    then
        interval=$fps
    else
        quo=$((fps/2))
        quo=$((quo+1))
        interval=$((quo*2))
    fi
    brate=${target[$j]}
    ((brate*=1000))
    frs=${frameNum[$j]}
    ((j++))
    ((bunit=width/16))


#    cmd="lencod.exe -f encoder_JM_LP_HEVC.cfg -p InputFile=$infile -p OutputFile=$out -p ReconFile=$rec -p FrameRate=$fps -p SourceWidth=$width -p SourceHeight=$height -p FramesToBeEncoded=$frs -p IntraPeriod=$interval -p RateControlEnable=$rcflag -p BasicUnit=$bunit -p Bitrate=$brate -p RCUpdateMode=$rcmode -p QPISlice=$qpi -p QPPSlice=$qpp  >$cons 2>&1"
    cmd="lencod.exe -f encoder.cfg -p InputFile=$infile -p OutputFile=$out -p FrameRate=$fps -p SourceWidth=$width -p SourceHeight=$height -p FramesToBeEncoded=$frs -p IntraPeriod=30 -p QPISlice=$qpi -p QPPSlice=$qpp  >$cons 2>&1"

    echo $cmd
done
