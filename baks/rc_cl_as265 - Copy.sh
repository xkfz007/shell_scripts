#!/bin/bash
. /cygdrive/e/workspace/as265_shell_scripts/sequence_list.sh
. /cygdrive/e/workspace/as265_shell_scripts/function_lib.sh
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

#default values

output_path="e:\\hfz\\as265_rc_test5-release\\"
input_path="e:\\hfz\\sequences\\"

printf_flag=225
trace_flag=0
measure_quality_flag=1
frame_num_to_encode=100

#cu pu tu
nMaxCUSize=64
nMaxCUDepth=4
nQuadtreeTULog2MaxSize=5
nQuadtreeTULog2MinSize=2
nQuadtreeTUMaxDepthIntra=3
nQuadtreeTUMaxDepthInter=3

#gop
nIntraPicInterval=30
nMaxForwardRefNum=4
nMaxBackwardRefNum=0
bExistRefB=0
bBRefForP=0
nUnRefB_before=0
nUnRefB_after=0
bEnableMultipleSubLayer=0
DecodingRefreshType=2

#feature
bEnableAMP=1
bEnableDBL=0
bEnableSAO=1

#rc
rc_methods=("CQP" "CBR" "QUALITY_RANK" "VBR" "CONFERENCE" "VBR_TWOPASS_ANALYSE" "VBR_TWOPASS_ENC" "VBR_Q" "ABR" )
eRcType=0
nQp=33
nBitrate=0
nMaxBitrate=0
vbv_buffer_size=0
vbv_buffer_init_time=0

#preset
preset=10

#debug parameters
first_frame=0
random_cost=0
force_tu_split=0
force_one_intra_mode=0
b_enable_cfg=1

#architecture and algorithm
architecture_id=2
algorithm_suit_id=0

frame_threads=1
wpp_threads=0
lookahead_threads=1


rps_method=1

log2_parallel_merge_level=2
slice_temporal_mvp_enabled_flag=1
constrained_intra_pred_flag=0

me_method=1
i_me_range=32
i_subpel_refine=7
b_chroma_me=1
b_enable_cu_rdo=1
rdo_cabac_level=3
i_inter_slice_intra_cu_level=0
i_opt_level=0
i_intra_cu_opt_level=0

rc_f_rate_tolerance=1.0
rc_f_rf_constant=23
rc_i_qp_min=0
rc_i_qp_max=51
rc_i_qp_step=2
rc_f_ip_factor=1.4
rc_f_pb_factor=1.3
rc_i_aq_mode=0
rc_f_aq_strength=1.0
rc_i_lookahead=20
rc_b_cutree=0
rc_i_lowres=1
rc_i_pass=1

usage(){
    echo "$0 [option]"
    echo "options:"
    echo ' -i input_path'
    echo ' -o output_path'
    echo ' -I I frame interval'
    echo ' -f frames to be encoded'
    echo ' -F frame parallelism threads'
    echo ' -W WPP threads'
    echo ' -L Lookahead threads'
    echo ' -h help'
    echo ' -q qp'
    echo ' -r ratecontrol method'
    echo ' -b bframes'
    echo ' -B bref'
    echo ' -a aq-mode'

}

while getopts ":i:o:I:f:F:W:L:hq:r:b:Ba:" OPT; do
    case ${OPT} in
        "i") input_path=${OPTARG};
#            echo "input_path=$input_path"
            ;;
        "o") output_path=${OPTARG};
#            echo "output_path=$output_path"
            ;;
        "I") nIntraPicInterval=${OPTARG};
#            echo "nIntraPicInterval=$nIntraPicInterval"
            ;;
        "f") frame_num_to_encode=${OPTARG};
#            echo "frame_num_to_encode=$frame_num_to_encode"
            ;;
        "F") frame_threads=${OPTARG};
#            echo "frame_threads=$frame_threads"
            ;;
        "W") wpp_threads=${OPTARG};
            ;;
        "L") lookahead_threads=${OPTARG};
            ;;
        "h") usage;exit ;;
        "q") nQp=${OPTARG};
#            echo "nQp=$nQp"
            ;;
        "r") eRcType=${OPTARG};
#            echo "eRcType=$eRcType"
            ;;
        "b") nUnRefB_before=${OPTARG};
            ;;
        "B") bExistRefB=1;
            ;;
        "a") rc_i_aq_mode=${OPTARG};
            ;;
    esac
done

for i in $seq_list
do
    reso_info=($(get_reso_info $i))
    nSrcWidth=${reso_info[0]}
    nSrcHeight=${reso_info[1]}
    fFrameRate=${reso_info[2]}

    output_filename=${i}_str.bin
    input_filename=${i}.yuv
    trace_file_cabac=${i}_cabac.log
    trace_file_general=${i}_general.log
    dump_file_rec=${i}_rec.yuv
    trace_file_prd_y=${i}_prdy.log
    trace_file_prd_uv=${i}_prduv.log
    cons=${i}_cons.log

    rc_param=($(get_bitrate_for_rc ${rc_methods[$eRcType]} $nSrcWidth $nSrcHeight))
    nBitrate=${rc_param[0]}
    nMaxBitrate=${rc_param[1]}
    vbv_buffer_size=${rc_param[2]}

    cmd="ashevc.exe"
    cmd="$cmd $output_path"
    cmd="$cmd $output_filename"
    cmd="$cmd $input_path"
    cmd="$cmd $input_filename"

    cmd="$cmd $trace_file_cabac"
    cmd="$cmd $trace_file_general"
    cmd="$cmd $dump_file_rec"
    cmd="$cmd $trace_file_prd_y"
    cmd="$cmd $trace_file_prd_uv"

    cmd="$cmd $printf_flag"
    cmd="$cmd $trace_flag"
    cmd="$cmd $measure_quality_flag"
    cmd="$cmd $nSrcWidth"
    cmd="$cmd $nSrcHeight"
    cmd="$cmd $fFrameRate"
    cmd="$cmd $frame_num_to_encode"

    # cu pu tu 
    cmd="$cmd $nMaxCUSize"
    cmd="$cmd $nMaxCUDepth"
    cmd="$cmd $nQuadtreeTULog2MaxSize"
    cmd="$cmd $nQuadtreeTULog2MinSize"
    cmd="$cmd $nQuadtreeTUMaxDepthIntra"
    cmd="$cmd $nQuadtreeTUMaxDepthInter"

    # gop 
    cmd="$cmd $nIntraPicInterval"
    cmd="$cmd $nMaxForwardRefNum"
    cmd="$cmd $nMaxBackwardRefNum"
    cmd="$cmd $bExistRefB"
    cmd="$cmd $bBRefForP"
    cmd="$cmd $nUnRefB_before"
    cmd="$cmd $nUnRefB_after"
    cmd="$cmd $bEnableMultipleSubLayer"
    cmd="$cmd $DecodingRefreshType"

    # feature
    cmd="$cmd $bEnableAMP"
    cmd="$cmd $bEnableDBL"
    cmd="$cmd $bEnableSAO"

    # rc 
    cmd="$cmd $eRcType"
    cmd="$cmd $nQp"
    cmd="$cmd $nBitrate"
    cmd="$cmd $nMaxBitrate"
    cmd="$cmd $vbv_buffer_size"
    cmd="$cmd $vbv_buffer_init_time"

    #preset
    cmd="$cmd $preset"

    # debug ters 
    cmd="$cmd $first_frame"
    cmd="$cmd $random_cost"
    cmd="$cmd $force_tu_split"
    cmd="$cmd $force_one_intra_mode"

    cmd="$cmd $b_enable_cfg"

    # architecture and algorithm 
    cmd="$cmd $architecture_id"
    cmd="$cmd $algorithm_suit_id"

    # threading 
    cmd="$cmd $frame_threads"
    cmd="$cmd $wpp_threads"
    #cmd="$cmd $lookahead_threads"

    # rps 
    cmd="$cmd $rps_method"

    # pred 
    cmd="$cmd $log2_parallel_merge_level"
    cmd="$cmd $slice_temporal_mvp_enabled_flag"
    cmd="$cmd $constrained_intra_pred_flag"

    # analyze 
    cmd="$cmd $me_method"
    cmd="$cmd $i_me_range"
    cmd="$cmd $i_subpel_refine"
    cmd="$cmd $b_chroma_me"
    cmd="$cmd $b_enable_cu_rdo"
    cmd="$cmd $rdo_cabac_level"

    cmd="$cmd $i_inter_slice_intra_cu_level"
    cmd="$cmd $i_opt_level"
    cmd="$cmd $i_intra_cu_opt_level"

    # rc 
    cmd="$cmd $rc_f_rate_tolerance"
    cmd="$cmd $rc_f_rf_constant"
    cmd="$cmd $rc_i_qp_min"
    cmd="$cmd $rc_i_qp_max"
    cmd="$cmd $rc_i_qp_step"
    cmd="$cmd $rc_f_ip_factor"
    cmd="$cmd $rc_f_pb_factor"
    cmd="$cmd $rc_i_aq_mode"
    cmd="$cmd $rc_f_aq_strength"
    cmd="$cmd $rc_i_lookahead"
    cmd="$cmd $rc_b_cutree"
    cmd="$cmd $rc_i_lowres"
    cmd="$cmd $rc_i_pass"

    cmd="$cmd >$cons 2>&1"

    echo $cmd

done
