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
esac

seq_list="BasketballDrill_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60"
#seq_list="BasketballDrive_1920x1080_50"

multiQP=0
[ $# -ge 1 ] && multiQP=$1

qp_num=1;
[ $multiQP -eq 1 ] && qp_num=6
qps=(22 27 32 37 42 47)

for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}
    
    for (( ii=0; ii<$qp_num;ii++ ))
    do
        cons=${i}_cons.txt
        if [ $multiQP -eq 1 ];then
            qp=${qps[ii]}
            cons=${i}_cons_$qp.txt
        fi
   #     tbr=`grep "TargetBitrate" $cons|awk '{print $3}'`
        frames=`grep "Total Frames:" $cons|awk '{print $3}'`
        brate=`grep "Bit rate (kbit/s)" $cons|awk '{print $8}'`
        ypsnr=`grep "Y { PSNR (dB), cSNR (dB), MSE }" $cons|awk '{print $11}'`
        ypsnr=${ypsnr%,*}
        upsnr=`grep "U { PSNR (dB), cSNR (dB), MSE }" $cons|awk '{print $11}'`
        upsnr=${upsnr%,*}
        vpsnr=`grep "V { PSNR (dB), cSNR (dB), MSE }" $cons|awk '{print $11}'`
        vpsnr=${vpsnr%,*}
        yssim=`grep "Y SSIM                            :" $cons |awk '{print $4}'`
        ussim=`grep "U SSIM                            :" $cons |awk '{print $4}'`
        vssim=`grep "V SSIM                            :" $cons |awk '{print $4}'`

        line="$frames $tbr $brate $ypsnr $upsnr $vpsnr"
        line="$line $yssim $ussim $vssim"
        echo "${cons%.txt} $line" >>$tt
    done

done
    
