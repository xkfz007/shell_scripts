#!/bin/bash
#This script is used to output the test command lines for BAT files. The names of sequences must be normalized, in order to analyze the corresponding information of the sequences.
#Defferent from file "rc_test.sh", the target bitrates in this file are the real bitrates, which are collected from the corresponding tests.
seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
target=(6784 3270 1570 772 390 185 7004 3458 1686 846 431 205 2423 1289 636 311 152 69 3596 1491 644 269 109 42 8756 3661 1660 792 384 180 4990 2355 832 325 121 53 58087 12364 4907 2302 1118 521 9321 5277 2837 1436 658 270 450 178 78 39 21 11 2993 1154 455 200 89 40 5925 1974 904 467 244 121 5191 1182 437 215 114 61 1238 660 336 171 89 46 4590 2097 1021 501 248 120 4654 1423 601 302 162 86 252 127 67 37 21 12 956 387 179 91 49 27 16402 6319 2661 1151 485 190 18363 8399 3700 1565 617 213 2197 1107 528 249 120 56 9482 4424 1900 837 367 161 1762 1309 963 681 438 236 1504 967 595 367 225 129 4240 1392 580 289 152 79 6353 2162 856 416 213 102 6384 1804 686 330 173 90 5722 2770 1325 631 291 120)
index=3 #index0:qp=22, index=1:qp=27, index=2:qp=32 
        #index3:qp=37, index=4:qp=42, index=5:qp=47
if [ $# -gt 0 ] && [ $1 -lt 6 ]
then
    index=$1
fi
#echo $index
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

    brate=${target[$index]}
    ((index+=6))

    frs=300 #FramesToBeEncoded
    #((frs=fps*10))

    qp=32
#    ((vmrate=brate))
#    ((vbuf=brate+brate/2))
    vmrate=0
    vbuf=0
    qpstep=1
    ratetol=0.1
    lcu=0
    decay=0.5

#    ((brate*=1000))
    cmd="TAppEncoder.exe -c encoder_lowdelay_P_main_std_gop2_ref1_test2.cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --IntraPeriod=$interval --RateControl=1 --TargetBitrate=$brate --VBV-MaxRate=$vmrate --VBV-BufSize=$vbuf --QP=$qp --QPStep=$qpstep --RateTol=$ratetol --LCURC=$lcu --Decay=$decay >$cons 2>&1"
#    cmd="TAppEncoder.exe -c encoder_lowdelay_P_main_std_gop2_ref1_test2.cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --IntraPeriod=$interval --RateControl=1 --TargetBitrate=$brate --VBV-MaxRate=$vmrate --VBV-BufSize=$vbuf --QP=$qp --QPStep=$qpstep --RateTol=$ratetol --LCURC=$lcu >$cons 2>&1"

    echo $cmd
    #echo $fps $interval
done
