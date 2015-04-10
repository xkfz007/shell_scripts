#!/bin/bash
tt=brate_qp_psnr.txt
[ -f $tt ] && >$tt || touch $tt
seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"

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

    col1=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="bits" ){print i;break} }'`
    ((col1--))

    col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="QP" ){print i;break} }'`
    ((col2++))

    col3=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="[Y" ){print i;break} }'`
    ((col3++))

    first_line=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`
    line_no=$first_line
    total_bits=0
    for (( j=0;j<$frames;j++ ))
    do
            bits_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col1 '{print $x}'`
            ((total_bits+=bits_tmp))
            brate=`awk -v x=${total_bits} -v y=$fps -v z=$j 'BEGIN {printf "%7.2f", x/1000.0/((z+1)*1.0/y)}'`
            echo -n $brate" ">>$tt
        ((line_no+=1))
        printf "."
    done
    echo >>$tt

    line_no=$first_line
    for (( j=0;j<$frames;j++ ))
    do
        qp_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col2 '{print $x}'`
        echo -n $qp_tmp" ">>$tt
        ((line_no+=1))
        printf "."
    done
    echo >>$tt

    line_no=$first_line
    for (( j=0;j<$frames;j++ ))
    do
        psnr_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col3 '{print $x}'`
        echo -n $psnr_tmp" ">>$tt
        ((line_no+=1))
        printf "."

    done

    echo >>$tt
    echo >>$tt
    echo >>$tt

    printf "\n"

done

