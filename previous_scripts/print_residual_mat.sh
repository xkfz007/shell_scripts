#!/bin/bash
#afile="/cygdrive/c/Users/hfz2597.ARCSOFT-SH/Desktop/chroma=0_after.txt"
afile="/cygdrive/e/arcsoft_codes/arc_hevc_svn_test/Makefile/HEVC_Lib/Debug/chroma=1_rdoq.txt"
bfile="/cygdrive/e/arcsoft_codes/arc_hevc_svn_test/Makefile/HEVC_Lib/Debug/chroma=1_normal.txt"
data_line=`awk 'END{print}' $afile`
#echo $data_line
line_count=`echo $data_line |awk 'END{print NF}' `
((line_count--))
#echo $line_count

if [ $line_count -ge 1024 ];then
    col=32
elif [ $line_count -ge 256 ];then
    col=16
elif [ $line_count -ge 64 ];then
    col=8
elif [ $line_count -ge 16 ];then
    col=4
fi
echo $data_line|awk '{printf "%s\n", $1}' 

echo $data_line|awk -v y=$col '{for(i=2;i<=NF;i++){printf "%2d ",$i;if((i-1)%y==0) printf "\n"}}' |tee c.txt
echo 
data_line2=`awk 'END{print}' $bfile`
echo $data_line2|awk -v y=$col '{for(i=2;i<=NF;i++){printf "%2d ",$i;if((i-1)%y==0) printf "\n"}}' |tee d.txt
#echo
#awk -v x=$line_count -v y=$col '{printf "%2d ",$1;if(NR%y==0) printf "\n"}' $bfile |tee d.txt

