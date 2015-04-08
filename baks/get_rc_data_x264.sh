#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr

tt=all_data_rc_bitrate.txt
#[ -f $tt ] && >$tt || touch $tt
test_file $tt


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

    rc_info=($(obtain_rc_info $cons))
    target_bitrate=${rc_info[0]}
    vbv_max_rate=${rc_info[1]}
    vbv_buffer_size=${rc_info[2]}
    vbv_init_time=${rc_info[3]}

    final_bitrate=$(obtain_rc_final_bitrate $cons)

    psnr_info=($(obtain_psnr_info $cons))
    psnry=${psnr_info[0]}
    psnru=${psnr_info[1]}
    psnrv=${psnr_info[2]}
    psnrtotal=${psnr_info[3]}

    ssim_info=($(obtain_ssim_info $cons))
    ssimy=${ssim_info[0]}
    ssimu=${ssim_info[1]}
    ssimv=${ssim_info[2]}
    ssimtotal=${ssim_info[3]}

    line="$target_bitrate $vbv_max_rate $vbv_buffer_size $final_bitrate $psnry $psnru $psnrv $psnrtotal $ssimy $ssimu $ssimv $ssimtotal"

    echo "${i} $line" >>$tt
    echo -n "."

done
    
