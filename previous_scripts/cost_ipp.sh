#!/bin/bash
tt=cost.txt
[ -f $tt ] && >$tt || touch $tt
seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
seq_list_added=" news_352x288_30 paris_352x288_30 walk_640x480_30 gopro_1280x720_25 LensRotation-b_1920x1080_23 panning-a_1920x1080_23 car_1920x1080_22 HotelPassage_448x336_15"

seq_list=${seq_list}" "$seq_list_added
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
    ((frame_end=frames-1))

    col1=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost2=" ){print i;break} }'`
    ((col1++))

    first_line=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`

        line_no=$first_line
        col_tmp=$col1
        for (( j=0;j<$frames;j++ ))
        do
            tmp_val=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col_tmp '{print $x}'`
            if [ $j -lt $frame_end ]
            then
                tmp_val=$tmp_val","
            fi
            echo -n $tmp_val >>$tt
            ((line_no++))
            printf "."
        done
        echo >>$tt
        printf "\n"

    echo >>$tt
    echo >>$tt
    echo >>$tt
done

