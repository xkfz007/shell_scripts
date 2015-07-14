#!/bin/bash
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
    target_br=$(grep "as265 \[info\]: param.rc.i_bitrate=" $i|awk '{print $4}')
    name=${i%_8_*as265*}

    #echo $i
    info=$(grep "as265 \[info\]: frame I:" $i)
    info2=$(grep "as265 \[info\]: frame I:" $j)
    #echo $info
    i_num=$(echo $info|awk '{print $5}')
    i_num=${i_num%,}
    i_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    i_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    i_ssimy=$(echo $info|awk '{print $17}'|awk -F: '{print $2}')

    i_qp2=$(echo $info2|awk '{print $7}'|awk -F: '{print $2}')
    i_psnry2=$(echo $info2|awk '{print $12}'|awk -F: '{print $2}')
    i_ssimy2=$(echo $info2|awk '{print $17}'|awk -F: '{print $2}')

    info=$(grep "as265 \[info\]: frame P:" $i)
    info2=$(grep "as265 \[info\]: frame P:" $j)
    p_num=$(echo $info|awk '{print $5}')
    p_num=${p_num%,}

    p_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    p_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    p_ssimy=$(echo $info|awk '{print $17}'|awk -F: '{print $2}')
    p_qp2=$(echo $info2|awk '{print $7}'|awk -F: '{print $2}')
    p_psnry2=$(echo $info2|awk '{print $12}'|awk -F: '{print $2}')
    p_ssimy2=$(echo $info2|awk '{print $17}'|awk -F: '{print $2}')

    info=$(grep "as265 \[info\]: frame B:" $i)
    info2=$(grep "as265 \[info\]: frame B:" $j)
    b_num=$(echo $info|awk '{print $5}')
    b_num=${b_num%,}
    b_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    b_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    b_ssimy=$(echo $info|awk '{print $17}'|awk -F: '{print $2}')
    b_qp2=$(echo $info2|awk '{print $7}'|awk -F: '{print $2}')
    b_psnry2=$(echo $info2|awk '{print $12}'|awk -F: '{print $2}')
    b_ssimy2=$(echo $info2|awk '{print $17}'|awk -F: '{print $2}')

    info=$(grep "as265 \[info\]: Global :" $i)
    info2=$(grep "as265 \[info\]: Global :" $j)
    g_num=$(echo $info|awk '{print $5}')
    g_num=${g_num%,}
    g_qp=$(echo $info|awk '{print $7}'|awk -F: '{print $2}')
    g_psnry=$(echo $info|awk '{print $12}'|awk -F: '{print $2}')
    g_ssimy=$(echo $info|awk '{print $17}'|awk -F: '{print $2}')
    g_bitrate=$(echo $info|awk '{print $9}')
    g_qp2=$(echo $info2|awk '{print $7}'|awk -F: '{print $2}')
    g_psnry2=$(echo $info2|awk '{print $12}'|awk -F: '{print $2}')
    g_ssimy2=$(echo $info2|awk '{print $17}'|awk -F: '{print $2}')
    g_bitrate2=$(echo $info2|awk '{print $9}')

    
    info_str="$name $i_num/$p_num/$b_num/$g_num $target_br $g_bitrate $g_bitrate2"
    info_str=${info_str}" $i_qp $p_qp $b_qp $g_qp $i_qp2 $p_qp2 $b_qp2 $g_qp2"
    info_str=${info_str}" $i_psnry $p_psnry $b_psnry $g_psnry $i_psnry2 $p_psnry2 $b_psnry2 $g_psnry2"
    info_str=${info_str}" $i_ssimy $p_ssimy $b_ssimy $g_ssimy $i_ssimy2 $p_ssimy2 $b_ssimy2 $g_ssimy2" 

    echo $info_str >>$tt
done

