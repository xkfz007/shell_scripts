#!/bin/bash
. /cygdrive/d/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/d/workspace/as265_shell_scripts/functions.lbr
. /cygdrive/d/workspace/as265_shell_scripts/set_encoder_default_params.seg

tt=all_data_rc_bitrate.txt
#[ -f $tt ] && >$tt || touch $tt
test_file $tt

encoder_id="as265"

. /cygdrive/d/workspace/as265_shell_scripts/parse_cl.seg

for i in $seq_list
do
    cons=${i}_cons.log

    test ! -f $cons && continue

    rc_info=($(${rc_info_list[$encoder_id]} $cons))
    target_bitrate=${rc_info[0]}
    vbv_max_rate=${rc_info[1]}
    vbv_buffer_size=${rc_info[2]}
    #vbv_init=${rc_info[3]}

    final_bitrate=$(${final_bitrate_list[$encoder_id]} $cons)
    frame_num=$(${frame_num_list[$encoder_id]} $cons)

    #psnr_info=($(${psnr_info_list[$encoder_id]} $cons))
    #psnry=${psnr_info[0]}
    #psnru=${psnr_info[1]}
    #psnrv=${psnr_info[2]}
    #psnrtotal=${psnr_info[3]}

    #ssim_info=($(${ssim_info_list[$encoder_id]} $cons))
    #ssimy=${ssim_info[0]}
    #ssimu=${ssim_info[1]}
    #ssimv=${ssim_info[2]}
    #ssimtotal=${ssim_info[3]}

    line="$frame_num $target_bitrate $vbv_max_rate $vbv_buffer_size $final_bitrate $psnry $psnru $psnrv $ssimy $ssimu $ssimv "

    echo "${i} $line" >>$tt
    echo -n "."

done
    
