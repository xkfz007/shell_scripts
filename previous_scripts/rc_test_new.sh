#!/bin/bash
#This script is used to output the test command lines for BAT files. The names of sequences must be normalized, in order to analyze the corresponding information of the sequences.
#The target bitrates in this file are only decided by the resolution.
seq_list=" Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop Kimono1_1920x1080_24 ParkScene_1920x1080_24 Cactus_1920x1080_50 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 RaceHorses_832x480_30 BasketballPass_416x240_50 BQSquare_416x240_60 BlowingBubbles_416x240_50 RaceHorses_416x240_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 SlideEditing_1280x720_30 SlideShow_1280x720_20 "

#seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30 news_352x288_30 paris_352x288_30 walk_640x480_30 gopro_1280x720_25 LensRotation-b_1920x1080_23 panning-a_1920x1080_23 car_1920x1080_22 HotelPassage_448x336_15 dancing_1280x720_30 "
flag=(20 20 20 20 10 10 10 10 10 10 10 10 20 20 10 8 8 10 20 20 20 10 10 10 10 10 20 10 20 20 20 15 10 10 20 20)

cfg=encoder_lowdelay_P_main_std_gop2_ref1_test2.cfg
#cfg=encoder_lowdelay_B_main_std_gop4_ref1_test2.cfg
frs=50 #FramesToBeEncoded
qp=22
qpstep=2
ratetol=1.0
lcu=0
decay=1.0
ipfactor=1.0

abrflag=0
interval=30

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
    out=${i}_str.bin
    rec=${i}_rec.yuv
    cons=${i}_cons.txt
    infile="D:\\hfz\\sequences\\"$yuv

#    if [ $fps -gt 30 ];then
#        ((fps=fps/2))
#    fi

    if [ "$interval" = "" ] || [ $interval -eq 0 ];then
        interval=$fps
        if (( interval<30 )) ; then
            interval=30
        fi
        gopsize=${cfg#*gop}
        gopsize=${gopsize%%_*}
        rem=$((interval%gopsize))
        if [ $rem -ne 0 ];then
            quo=$((interval/gopsize))
            quo=$((quo+1))
            interval=$((quo*gopsize))
        fi
    fi

if [ $abrflag -eq 1 ] ;then
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
    factor=${flag[$j]}; ((j++))
    ((brate=brate*factor/10))
    ((brate*=1000))
else
    brate=0
fi

    cmd="TAppEncoder.exe -c $cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --IntraPeriod=$interval --RateControl=$abrflag --TargetBitrate=$brate --QP=$qp --QPStep=$qpstep --RateTol=$ratetol --LCURC=$lcu --Decay=$decay >$cons 2>&1"

    echo $cmd
    #echo $i"||"$width"x"$height"||"$fps"||"$brate

done
