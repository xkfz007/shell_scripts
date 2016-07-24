#常用shell脚本技巧
#1. 测试其他程序（批量测试）
#!/bin/bash
limit=10000
for(( i=0;i<100;++i))
do
    a=`echo $(($RANDOM%$limit))`
    b=`echo $(($RANDOM%$limit))`
    r1=`expr $a \* $b`
    r2=`./big_int_multiply $a $b`
    echo -ne "a=$a\tb=$b\tr1=$r1\tr2=$r2\t"
    if [ $r1 -eq $r2 ]
    then
        echo "ok"
    else
        echo "ohh,bad"
    fi
done

#3. 获取图片分辨率大小（使用identity程序）
sze=`identify $j|awk '{print $3}'`
width=${sze%x*}
height=${sze#*x}

#4. 在sed和awk中使用变量参数
sed -n "$rowS"','"$rowE"'p' mv.txt |awk -v colS1=$colS1 -v colS2=$colS2 -v colS3=$colS3 -v colS4=$colS4 '{print $colS1 $colS2 $colS3 $colS4}'
#5. 获取文件中的某一行（注意，一定要将文件转换为unix格式，采用dos2unix）
    line=`sed -n -e "${line_no}"'p' $cons`

#6. 利用grep获取满足条件的某一行
qp1=`grep "POC    0" $cons|awk '{print $22}'`
# 利用grep获取行号：
line_no=`grep -n 'POC    0' $cons |awk -F: '{print $1}'`
#使grep只输出一行中匹配正则表达式的部分，而不是一整行（使用-o选项）
 grep -o "as265_ratecontrol_.*Thread=.*order_value=.*encoderOrder=.*"

#7. 利用awk进行浮点数计算
psnr1=0
    for (( jj=0;jj<5;jj++ ))
    do
        psnr_tmp=`sed -n -e "${line_no}"'p' $cons |awk '{print $27}'`
        ((line_no+=1))
        psnr1=`awk -v x=$psnr1 -v y=$psnr_tmp 'BEGIN {printf "%f",x+y}'`
        printf "."
    done
    psnr2=$psnr1
    psnr1=`awk -v x=$psnr1  'BEGIN {printf "%f",x/5}'`
#这是用awk来计算前5帧PSNR的平均值

#8. 字符串替换，所要替换的值是由变量传入的
line=${line/a/${brate}}

#6. 利用awk获取某个字符串在一行文本中所在的列（以空格为分割符，可以使用-F选项来指定需要的分隔符）
grep "POC    0" cons.txt | awk '{for(i=1;i<=NF;i++) if( $i =="nQP" ){print i;break} }'

#7. 利用awk输出某一列
 bits=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col '{print $x}'`

#8. 删除某些列
 line=`sed -n -e "${line_no}"'p' $cons |awk -v x=$col1 -v y=$col2 '{for(i=1;i<=NF;i++)if(i<x||i>y) {print $i" "}}'`

#9. 利用sed替换一行
sed '5s/^.*$/xxxxx/'  $file

#10. 获取文件总行数
awk 'END {print NR}' $file

#11. shell数组使用变量索引
#累加数组中对应元素的值： ((total_bits[$ii]+=bits_tmp))
#awk使用数组中对应的元素为参数变量：
brate=`awk -v x=${total_bits[ii]} -v y=$fps -v z=$j 'BEGIN {printf "%f", x/1000.0/((z+1)*1.0/y)}'`

#12. shell 判断变量值是否为数字
#bash中只能通过正则匹配来判断一个变量值是否为数字，具体代码是：
[[ "$val" =~ ^[0-9]+$ ]]

#如果 $val 是数字（不含小数点）则表达式返回 0
#举例：
if [[ "$val" =~ ^[0-9]+$ ]]; then
   echo "val=$val is number"
fi

#13. 删除空行（或者带有空格）
sed /^[[:space:]]*$/d filename #删除有空格的空行
sed s/[[:space:]]//g filename #删除空格
sed /^$/d filename #删除没有空格的空行
#其他方法
grep: grep -v '^$' file
sed: sed '/^$/d' file 
#或 
sed -n '/./p' file
awk: awk '/./ {print}' file
