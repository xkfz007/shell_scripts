#!/bin/bash
seq_list="ChinaSpeed_1024x768_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 SlideEditing_1280x720_30 SlideShow_1280x720_20 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop "

frameNum=( 300 300 300 300 300 300 300 300 300 240 240 240 150 150 )

qp=22
if [ $# -ge 1 ]
then
    qp=$1
fi
case $qp in
    "22" )
        target=( 7597 3880 3023 2979 1698 1307 28280 64861 32566 7263 11693 7700 20567 47288 ) 
        ;;
    "27" )
        target=( 4269 1546 887 1091 1264 825 9770 13282 8915 3339 4918 3738 7837 22645 )
        ;;
    "32" )
        target=( 2262 759 367 505 935 511 4498 3759 3901 1639 2175 1878 3458 12002 )
        ;;
    "37" )
        target=( 1144 404 188 264 656 322 2285 1360 1902 824 969 978 1678 6773 )
        ;;
    "42" )
        target=( 537 215 103 145 419 198 1189 546 944 401 416 518 833 3837 )
        ;;
    "47" )
        target=( 227 106 56 78 224 113 569 226 436 176 163 260 386 2016 )
        ;;
esac

rcflag=1
lcu=0

brate=0

qpstep=2
ratetol=0.1
decay=0.5
ipfactor=1.4

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

    rem=$((fps%2))
    if [ $rem -eq 0 ]
    then
        interval=$fps
    else
        quo=$((fps/2))
        quo=$((quo+1))
        interval=$((quo*2))
    fi
    frs=${frameNum[$j]} #FramesToBeEncoded
    brate=${target[$j]}
    ((j++))

#    ((index+=6))
#    ((brate*=1000))
    cmd="TAppEncoder.exe -c encoder_lowdelay_P_main_std_gop2_ref1_test2.cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --IntraPeriod=$interval --RateControl=$rcflag --LCULevelRateControl=$lcu --TargetBitrate=$brate --QP=$qp --QPStep=$qpstep --RateTol=$ratetol --LCURC=$lcu --Decay=$decay --IPFactor=$ipfactor >$cons 2>&1"
    echo $cmd
done
