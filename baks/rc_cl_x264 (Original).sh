#!/bin/bash
. /cygdrive/e/workspace/as265_shell_scripts/sequence_list.seg
. /cygdrive/e/workspace/as265_shell_scripts/functions.lbr
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

frame_num_to_encode=100
nIntraPicInterval=30
ref=4
bref=0
bframes=0

nQp=33
aqmode=0
mbtree=0
lookahead_threads=1
frame_threads=1
rclookahead=10
while getopts ":L:F:" OPT; do
    case ${OPT} in
        "F") frame_threads=${OPTARG};
            ;;
        "L") lookahead_threads=${OPTARG};
            ;;
    esac
done

mbtree_cl=("--no-mbtree" "--mbtree")
cmd0="Test_Windows.exe"
cmd0="$cmd0 --b-adapt 0"
cmd0="$cmd0 --weightp 0"
cmd0="$cmd0 --no-scenecut"
cmd0="$cmd0 -v --tune psnr --psnr"
cmd0="$cmd0 --no-psy"
cmd0="$cmd0 --no-asm"
cmd0="$cmd0 ${mbtree_cl[$mbtree]}"
cmd0="$cmd0 --aq-mode $aqmode"
cmd0="$cmd0 --threads $frame_threads"
cmd0="$cmd0 --lookahead-threads $lookahead_threads"
cmd0="$cmd0 --ref $ref"
cmd0="$cmd0 --b-pyramid $bref"
cmd0="$cmd0 -b $bframes"
cmd0="$cmd0 --rc-lookahead $rclookahead"
cmd0="$cmd0 -I $nIntraPicInterval"
cmd0="$cmd0 --frames $frame_num_to_encode"
rc_methods=("CQP" "CBR" "QUALITY_RANK" "VBR" "CONFERENCE" "VBR_TWOPASS_ANALYSE" "VBR_TWOPASS_ENC" "VBR_Q" "ABR" )
eRcType=0;
for i in $seq_list
do
    reso_info=($(get_reso_info $i))
    nSrcWidth=${reso_info[0]}
    nSrcHeight=${reso_info[1]}
    fFrameRate=${reso_info[2]}

    output_filename=${i}.264
    input_filename=${i}.yuv
    dump_file_rec=${i}_rec.yuv
    cons=${i}_cons.log
    infile=E:\\hfz\\sequences\\$input_filename
    cmd="$cmd0 -o $output_filename $infile"
    cmd="$cmd --fps $fFrameRate"
    if [ ${rc_methods[$eRcType]} == "CQP" ];then
        cmd="$cmd --qp $nQp"
    else
        rc_param=($(get_bitrate_for_rc ${rc_methods[$eRcType]} $nSrcWidth $nSrcHeight))
        nBitrate=${rc_param[0]}
        nMaxBitrate=${rc_param[1]}
        vbv_buffer_size=${rc_param[2]}
        cmd="$cmd --bitrate $nBitrate"
        cmd="$cmd --vbv-maxrate $nMaxBitrate"
        cmd="$cmd --vbv-bufsize $vbv_buffer_size"
    fi
    cmd="$cmd >$cons 2>&1"

    echo $cmd
done
