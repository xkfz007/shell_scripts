#!/bin/bash
tt=all_data_rc_bitrate.txt
[ -f $tt ] && >$tt || touch $tt

. /cygdrive/e/workspace/as265_shell_scripts/sequence_list.sh

#seq_list="$seq_list $classA"
#seq_list="$seq_list $classB"
seq_list="$seq_list $classC"
seq_list="$seq_list $classD"
seq_list="$seq_list $classE"
seq_list="$seq_list $classF"
#seq_list="$seq_list $othersB"
seq_list="$seq_list $othersC"
seq_list="$seq_list $othersD"
seq_list="$seq_list $othersE"
seq_list="$seq_list $othersF"
seq_list="$seq_list $othersReso"

for i in $seq_list
do
    cons=${i}_cons.log
    num=$(grep -n "****** internal params are listed as follows ******" $cons |awk -F: '{print $1}')
    ((num-=2))
    vbv_init_time=$(sed -n -e "${num}"'p' $cons|awk -F'=' '{print $2}'|tr -d [:blank:])
    ((num--))
    vbv_buffer_size=$(sed -n -e "${num}"'p' $cons|awk -F'=' '{print $2}'|tr -d [:blank:])
    ((num--))
    vbv_max_rate=$(sed -n -e "${num}"'p' $cons|awk -F'=' '{print $2}'|tr -d [:blank:])
    ((num--))
    target_bitrate=$(sed -n -e "${num}"'p' $cons|awk -F'=' '{print $2}'|tr -d [:blank:])
   # target_bitrate=$(grep "param.rc.bitrate=" $cons |awk '{print $2}')
    final_bitrate=$(grep "bitrate=.*kbps" $cons)
    final_bitrate=${final_bitrate#bitrate=}
    final_bitrate=${final_bitrate%kbps}
    
    psnr_value=$(grep "psnry=" $cons)
    psnry=$(echo $psnr_value|awk '{print $1}');psnry=${psnry#psnry=}
    psnru=$(echo $psnr_value|awk '{print $2}');psnru=${psnru#psnru=}
    psnrv=$(echo $psnr_value|awk '{print $3}');psnrv=${psnrv#psnrv=}
    psnrtotal=$(echo $psnr_value|awk '{print $4}');psnrtotal=${psnrtotal#psnrtotal=}

    ssim_value=$(grep "ssimy=" $cons)
    ssimy=$(echo $ssim_value|awk '{print $1}');ssimy=${ssimy#ssimy=}
    ssimu=$(echo $ssim_value|awk '{print $2}');ssimu=${ssimu#ssimu=}
    ssimv=$(echo $ssim_value|awk '{print $3}');ssimv=${ssimv#ssimv=}
    ssimtotal=$(echo $ssim_value|awk '{print $4}');ssimtotal=${ssimtotal#ssimtotal=}
    
    line="$target_bitrate $vbv_max_rate $vbv_buffer_size $final_bitrate $psnry $psnru $psnrv $psnrtotal $ssimy $ssimu $ssimv $ssimtotal"

    echo "${i} $line" >>$tt
    echo -n "."

done
    
