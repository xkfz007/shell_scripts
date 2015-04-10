#!/bin/bash
#seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballDrive_1920x1080_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 BQTerrace_1920x1080_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 Kimono1_1920x1080_24 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 Tennis_1920x1080_24 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
#seq_list=" BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 ChinaSpeed_1024x768_30 PartyScene_832x480_50 RaceHorses_832x480_30"

#target=( 1767.78 874.04 425.07 214.99 2140.66 859.11 359.97 151.98 4587.61 1975.10 935.06 468.92 5447.01 2660.85 1292.27 625.00 9303.24 3690.41 1584.18 682.83 6054.48 2360.02 1019.12 461.96 )
#target=( 2422.5347 1289.496 636.0307 311.1733 3595.944 1491.3947 644.3213 268.928 8756.3136 3661.0144 1659.9568 792.4432 9320.5128 5276.884 2836.9728 1435.524 18363.1733 8399.3013 3699.536 1564.7813 9482.2464 4424.276 1900.4696 837.46 )
target=( 6784.12 3270.328 1569.5707 772.108 390.1253 185.1147 7004.3653 3457.8107 1685.624 845.516 431.196 205.2907 2422.5347 1289.496 636.0307 311.1733 152.3813 68.928 3595.944 1491.3947 644.3213 268.928 109.3507 42.292 8756.3136 3661.0144 1659.9568 792.4432 384.2512 179.96 4989.888 2355.3152 832.0416 325.3408 120.6992 53.1344 58087.4787 12364.34 4907.2827 2301.7333 1118.116 521.452 9320.5128 5276.884 2836.9728 1435.524 658.4624 269.7672 449.536 178.4456 78.3168 39.4872 20.7792 10.7992 2992.8352 1154.264 454.8136 199.5312 89.1056 40.0864 5925.4112 1973.7744 904.3136 466.9792 243.8688 121.1056 5191.3296 1182.1376 436.6912 215.0608 114.28 61.4464 1237.8272 659.8256 335.768 170.8224 89.2016 45.8168 4589.7192 2096.7616 1021.2256 500.5688 248.1512 120.4904 4654.4256 1422.632 600.664 301.7296 161.9168 86.0288 252.0128 127.4728 66.6968 36.96 21.1528 12.2352 956.1448 386.5128 179.1088 91.4152 49.1688 27.0016 16402.0712 6318.776 2660.5312 1151.4536 485.0616 189.5192 18363.1733 8399.3013 3699.536 1564.7813 617.1973 212.952 2196.872 1107.0888 528.3896 248.8176 119.7016 55.5568 9482.2464 4424.276 1900.4696 837.46 366.7 160.5736 1762.304 1308.5392 962.692 680.9936 438.4272 236.4504 1504.3499 967.2512 594.7237 366.5835 225.1851 129.3056 4239.9664 1391.6064 580.0544 288.8288 151.5872 79.4896 6352.992 2161.6672 856.1408 415.5392 213.1904 102.44 6383.7392 1803.92 685.9488 330.4544 172.9568 89.9856 5721.836 2769.8048 1324.6592 631.224 290.8416 119.7536)

index=0
for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    rem=$((fps%2))
    if [ $rem -eq 0 ]
    then
        interval=$fps
    else
        quo=$((fps/2))
        quo=$((quo+1))
        interval=$((quo*2))
    fi

    yuv=${i}.yuv
    infile="D:\\hfz\\sequences\\"$yuv
    #    printf "%s " $yuv 
#    bat=${i}.bat
#    >$bat
#    echo '@echo off' >>$bat
#    echo 'choice /C YN /M "Do you really want to start this batch?"' >>$bat
#    echo 'if errorlevel 2 exit'>>$bat
#    echo '@echo on' >>$bat
#    echo 'echo %~nx0'>>$bat
    

    qp=22
    brate=0  #for CQP
    interval=1 #intra only
    for (( ii=0;ii<6;ii++ ))
    do
        out=${i}_str_$qp.bin
        rec=${i}_rec_$qp.yuv
        cons=${i}_cons_$qp.txt
        #brate=${target[$index]}
        cmd="TAppEncoder.exe -c encoder_lowdelay_P_main_std_gop2_ref1_test.cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=300 --IntraPeriod=$interval --RateCtrl=1 --TargetBitrate=$brate --QP=$qp >$cons 2>&1"
        #        echo $cmd >>$bat
        echo $cmd
        #printf "%d %f\n" $qp $brate 
#        echo $brate

        ((index++))
        ((qp+=5))
    done
    
done
