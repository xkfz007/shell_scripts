#!/bin/bash
tt=psnr_data.txt
[ -f $tt ] && >$tt || touch $tt
#seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
seq_list="BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 "
for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    cons=${i}_cons.txt

    line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
    ((line_no1+=2))

    frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`

    line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`
    psnr_sum=0
    echo -n $i" " >>$tt

    col=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="[Y" ){print i;break} }'`
    ((col++))

    for (( j=0;j<$frames;j++ ))
    do
        psnr=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col '{print $x}'`
        psnr_sum=`awk -v x=$psnr_sum -v y=$psnr 'BEGIN {printf "%f", x+y}'`
        psnr_mean=`awk -v x=$psnr_sum -v y=$j 'BEGIN {printf "%f",x/(y+1)}'`
        echo -n $psnr_mean" " >>$tt

        ((line_no+=1))
        printf "."
    done
    printf "\n"
    echo >>$tt

done

