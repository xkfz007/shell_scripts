#!/bin/bash
tt=all_data.txt
[ -f $tt ] && >$tt || touch $tt
listNo=0
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

#seq_list="BasketballDrill_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60"
seq_list="PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 ChinaSpeed_1024x768_30 SlideEditing_1280x720_30 SlideShow_1280x720_20"

for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}
    
        cons=${i}_cons.txt

        frames=`grep "encoded" $cons|awk '{print $2}'`
        brate=`grep "encoded" $cons|awk '{print $6}'`
        mea_info=`grep "x264 \[info\]: kb/s:" $cons`
        ypsnr=`echo $mea_info|awk '{print $6}'`
        ypsnr=${ypsnr#*:}
        upsnr=`echo $mea_info|awk '{print $7}'`
        upsnr=${upsnr#*:}
        vpsnr=`echo $mea_info|awk '{print $8}'`
        vpsnr=${vpsnr#*:}
        #FPS=`grep "encoded" $cons|awk '{print $4}'`
        yssim=`echo $mea_info|awk '{print $13}'`
        yssim=${yssim#*:}
        ussim=`echo $mea_info|awk '{print $14}'`
        ussim=${ussim#*:}
        vssim=`echo $mea_info|awk '{print $15}'`
        vssim=${vssim#*:}

        line="$frames $brate $ypsnr $upsnr $vpsnr $FPS"
        line="$line $yssim $ussim $vssim"
        echo "${cons%.txt} $line" >>$tt
done
    
