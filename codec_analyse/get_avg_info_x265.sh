#!/bin/bash
function get_info_ipb
{
    str=$1
    pf1=$2
    info=$(grep "$str" $pf1)
    i_num=$(echo $info|awk '{print $5}')
    i_num=${i_num%,}
    i_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    i_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    i_ssimy=$(echo $info|awk '{print $17}')

    echo "$i_num $i_qp $i_psnry $i_ssimy"
    
}
function get_info
{
    str=$1
    pf1=$2
    pf2=$3
    info1=($(get_info_ipb "$str" $pf1))
    info2=($(get_info_ipb "$str" $pf2))

    echo "${info1[0]} ${info1[1]} ${info2[1]} ${info1[2]} ${info2[2]} ${info1[3]} ${info2[3]}"
}
function get_info_global
{
    str=$1
    pf=$2

    info=$(grep "$str" $pf)
    g_num=$(echo $info|awk '{print $5}')
    g_num=${g_num%,}
    g_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    g_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    g_ssimy=$(echo $info|awk '{print $17}')
    g_bitrate=$(echo $info|awk '{print $9}')

    echo "$g_num $g_qp $g_psnry $g_ssimy $g_bitrate"
}
function get_info2
{
    str=$1
    pf1=$2
    pf2=$3
    info1=($(get_info_global "$str" $pf1))
    info2=($(get_info_global "$str" $pf2))

    echo "${info1[0]} ${info1[1]} ${info2[1]} ${info1[2]} ${info2[2]} ${info1[3]} ${info2[3]} ${info1[4]} ${info2[4]}"
}
if [ $# -gt 0 ];then
    cd $1
fi
ps=1

tt=pass${ps}_info.txt
if [ -f "$tt" ];then
    >$tt
else
    touch $tt
fi

for i in *pass1_cons.log
do
    j=${i/pass1/pass2}
    echo $j
    target_br=$(grep "x265 \[info\]: Rate Control / AQ-Strength / CUTree :" $i|awk -F: '{print $3}'|awk '{print $1}'|awk -F'-' '{print $2}')
    echo "target_br=${target_br}"
    name=${i%_8_*x265*}

    str="x265 \[info\]: frame I:"
    i_info=($(get_info "$str" "$i" "$j"))
    echo "i_info=${i_info[@]}"
    i_num=${i_info[0]}
    i_qp=${i_info[1]}
    i_qp2=${i_info[2]}
    i_psnry=${i_info[3]}
    i_psnry2=${i_info[4]}
    i_ssimy=${i_info[5]}
    i_ssimy2=${i_info[6]}

    str="x265 \[info\]: frame P:"
    p_info=($(get_info "$str" "$i" "$j"))
    p_num=${p_info[0]}
    p_qp=${p_info[1]}
    p_qp2=${p_info[2]}
    p_psnry=${p_info[3]}
    p_psnry2=${p_info[4]}
    p_ssimy=${p_info[5]}
    p_ssimy2=${p_info[6]}

    str="x265 \[info\]: frame B:"
    b_info=($(get_info "$str" "$i" "$j"))
    b_num=${b_info[0]}
    b_qp=${b_info[1]}
    b_qp2=${b_info[2]}
    b_psnry=${b_info[3]}
    b_psnry2=${b_info[4]}
    b_ssimy=${b_info[5]}
    b_ssimy2=${b_info[6]}

    str="x265 \[info\]: global :" 
    g_info=($(get_info2 "$str" "$i" "$j"))
    g_num=${g_info[0]}
    g_qp=${g_info[1]}
    g_qp2=${g_info[2]}
    g_psnry=${g_info[3]}
    g_psnry2=${g_info[4]}
    g_ssimy=${g_info[5]}
    g_ssimy2=${g_info[6]}
    g_bitrate=${g_info[7]}
    g_bitrate2=${g_info[8]}
    
    info_str="$name $i_num/$p_num/$b_num/$g_num $target_br $g_bitrate $g_bitrate2"
    info_str=${info_str}" $i_qp $p_qp $b_qp $g_qp $i_qp2 $p_qp2 $b_qp2 $g_qp2"
    info_str=${info_str}" $i_psnry $p_psnry $b_psnry $g_psnry $i_psnry2 $p_psnry2 $b_psnry2 $g_psnry2"
    info_str=${info_str}" $i_ssimy $p_ssimy $b_ssimy $g_ssimy $i_ssimy2 $p_ssimy2 $b_ssimy2 $g_ssimy2" 

    echo $info_str >>$tt
done

