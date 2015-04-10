#!/bin/bash
tt=all_data.txt
[ -f $tt ] && >$tt || touch $tt
seq_list="BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQSquare_416x240_60 Flowervase_416x240_30 Keiba_416x240_30 Mobisode2_416x240_30 RaceHorses_416x240_30 HotelPassage_448x336_15 walk_640x480_30 BasketballDrill_832x480_50 BQMall_832x480_60 Flowervase_832x480_30 Keiba_832x480_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_832x480_30 ChinaSpeed_1024x768_30 dancing_1280x720_30 FourPeople_1280x720_60 gopro_1280x720_25 Johnny_1280x720_60 KristenAndSara_1280x720_60 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 car_1920x1080_22 Kimono1_1920x1080_24 LensRotation-b_1920x1080_23 panning-a_1920x1080_23 ParkScene_1920x1080_24 Tennis_1920x1080_24 PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop"

for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    cons=${i}_cons.txt
    brate=`grep "AVG" $cons|awk '{print $7}'`
    ypsnr=`grep "AVG" $cons|awk '{print $2}'`
    upsnr=`grep "AVG" $cons|awk '{print $3}'`
    vpsnr=`grep "AVG" $cons|awk '{print $4}'`

    brate=`awk -v x=$brate 'BEGIN {printf "%f",x/1000 }'`

    col1=`grep "Frames" $cons |awk '{for(i=1;i<=NF;i++) if( $i =="FPS" ){print i;break} }'`
    ((col1+=2))
    FPS=`grep "Frames" $cons|awk -v x=$col1 '{print $x}'`

   # line_no1=`grep -n "AVG" $cons |awk -F: '{print $1}'` 
   # ((line_no1--))

    frames=`grep "FrameNumber" $cons|awk '{print $3}'`
    line="$frames $brate $ypsnr $upsnr $vpsnr $FPS"

    echo "${cons%.txt} $line" >>$tt

done
    
