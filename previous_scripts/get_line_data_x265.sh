#!/bin/bash
tt=all_data.txt
[ -f $tt ] && >$tt || touch $tt
listNo=3
case $listNo in
    "1" )
        seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
        ;;
    "2" )
        seq_list="ChinaSpeed_1024x768_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 SlideEditing_1280x720_30 SlideShow_1280x720_20 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop "
        ;;
    "3" )
seq_list=" Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop Kimono1_1920x1080_24 ParkScene_1920x1080_24 Cactus_1920x1080_50 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 RaceHorses_832x480_30 BasketballPass_416x240_50 BQSquare_416x240_60 BlowingBubbles_416x240_50 RaceHorses_416x240_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 SlideEditing_1280x720_30 SlideShow_1280x720_20 "
;;
esac

for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    cons=${i}_cons.txt
    info=`grep "x265 \[info\]: global :" $cons`

    frames=`echo $info|awk '{print $5}'`
    brate=`echo $info|awk '{print $9}'`
    ypsnr=`echo $info|awk '{print $12}'`
    ypsnr=${ypsnr#*:}
    upsnr=`echo $info|awk '{print $13}'`
    upsnr=${upsnr#*:}
    vpsnr=`echo $info|awk '{print $14}'`
    vpsnr=${vpsnr#*:}

 #   frames=`grep "encoded" $cons|awk '{print $2}'`
 #   brate=`grep "encoded" $cons|awk '{print $8}'`
 #   ypsnr=`grep "x265 \[info\]: global :" $cons|awk '{print $12}'`
 #   ypsnr=${ypsnr#*:}
 #   upsnr=`grep "x265 \[info\]: global :" $cons|awk '{print $13}'`
 #   upsnr=${upsnr#*:}
 #   vpsnr=`grep "x265 \[info\]: global :" $cons|awk '{print $14}'`
 #   vpsnr=${vpsnr#*:}
    FPS=`grep "encoded" $cons|awk '{print $6}'`
    FPS=${FPS#*(}

    line="$frames $brate $ypsnr $upsnr $vpsnr $FPS"
    echo "${cons%.txt} $line" >>$tt

done
    
