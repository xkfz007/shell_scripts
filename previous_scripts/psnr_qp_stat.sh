#!/bin/bash
tt=psnr_qp_data.txt
[ -f $tt ] && >$tt || touch $tt
#seq_list="BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 "
#seq_list="BQMall_832x480_60"
#seq_list="BlowingBubbles_416x240_50"
seq_list="BasketballPass_416x240_50 Flowervase_416x240_30 Flowervase_832x480_30"
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
        #  qp=${qps[ii]}
        cons=${i}_cons_22.txt
    fi
    line_no1=`grep -n "SUMMARY" $cons |awk -F: '{print $1}'` 
    ((line_no1+=2))

    frames=`sed -n -e "${line_no1}"'p' $cons |awk '{print $1}'`

    line=`sed -n -e "${line_no}"'p' $cons`

    line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`

    col1=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="QP" ){print i;break} }'`
    ((col1++))

    col2=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="[Y" ){print i;break} }'`
    ((col2++))

    col3=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="bits" ){print i;break} }'`
    ((col3--))

    col4=`grep 'POC    0' $cons |awk '{for(i=1;i<=NF;i++) if( $i =="cost2=" ){print i;break} }'`
    ((col4++))

    total_bits=(0 0 0 0 0 0)
    for (( j=0;j<$frames;j++ ))
    do
        for (( ii=0;ii<$qp_num;ii++ ))
        do
            if [ $multiQP -eq 1 ];then
                qp=${qps[ii]}
                cons=${i}_cons_$qp.txt
            fi
            qp_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col1 '{print $x}'`
            psnr_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col2 '{print $x}'`
            bits_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col3 '{print $x}'`
            ((total_bits[$ii]+=bits_tmp))
            brate=`awk -v x=${total_bits[ii]} -v y=$fps -v z=$j 'BEGIN {printf "%f", x/1000.0/((z+1)*1.0/y)}'`
            sad_tmp=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col4 '{print $x}'`
            echo -n $qp_tmp $bits_tmp $psnr_tmp $brate $sad_tmp" ">>$tt

        done
        echo >>$tt
        ((line_no+=1))
        printf "."
    done

    echo >>$tt
    echo >>$tt
    echo >>$tt

    printf "\n"

done

