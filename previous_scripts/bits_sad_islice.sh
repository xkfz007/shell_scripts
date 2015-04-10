#!/bin/bash
tt=bits_sad_data.txt
[ -f $tt ] && > $tt || touch $tt
#seq_list="BasketballDrill_832x480_50 BasketballDrillText_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Cactus_1920x1080_50 ChinaSpeed_1024x768_30 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 ParkScene_1920x1080_24 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 mergeout_832x480_30"
seq_list="BQMall_832x480_60"

multiQP=0
[ $# -ge 1 ] && multiQP=$1

qp_num=1
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

    cons=${i}_cons.txt
    if [ $multiQP -eq 1 ];then
#        qp=${qps[0]}
        cons=${i}_cons_22.txt
    fi

    col=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="bits" ){print i;break} }'`
    ((col--))
    col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost=" ){print i;break} }'`
    ((col2++))

    nums=(`grep -n "I-SLICE," $cons |awk -F: '{print $1}'`)
    len=`echo ${#nums[@]}`

    for ((ii=0;ii<$len-1;ii++))
    do
        for (( jj=0;jj<$qp_num;jj++ ))
        do
            if [ $multiQP -eq 1 ];then
                qp=${qps[jj]}
                cons=${i}_cons_$qp.txt
            fi
            linum=${nums[ii]}
            bits=`sed -n -e "$linum"'p' $cons |awk -v x=$col '{print $x}'`
            ((linum++))
            sad=`sed -n -e "$linum"'p' $cons |awk -v x=$col2 '{print $x}'`
            echo -n $sad" "$bits" " >>$tt
        done
        echo >>$tt
        printf "."
    done
    printf "\n"
done

