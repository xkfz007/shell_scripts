#!/bin/bash
#seq_list="ChinaSpeed_1024x768_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 SlideEditing_1280x720_30 SlideShow_1280x720_20 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop"

#seq_list=" Traffic_2560x1600_30_crop PeopleOnStreet_2560x1600_30_crop Kimono1_1920x1080_24 ParkScene_1920x1080_24 Cactus_1920x1080_50 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 RaceHorses_832x480_30 BasketballPass_416x240_50 BQSquare_416x240_60 BlowingBubbles_416x240_50 RaceHorses_416x240_30 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 SlideEditing_1280x720_30 SlideShow_1280x720_20 "
#seq_list="BasketballDrill_832x480_50 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQMall_832x480_60 BQSquare_416x240_60 Flowervase_416x240_30 Flowervase_832x480_30 FourPeople_1280x720_60 Johnny_1280x720_60 Keiba_416x240_30 Keiba_832x480_30 KristenAndSara_1280x720_60 Mobisode2_416x240_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_416x240_30 RaceHorses_832x480_30 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60"
seq_list="PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 ChinaSpeed_1024x768_30 SlideEditing_1280x720_30 SlideShow_1280x720_20"

qp=22
[ $# -ge 1 ] && qp=$1

case $qp in
"22" ) target=( 67475 31938 41823 119082  61850 13651 17938 15608 7534  11198 21916 6347  6379  5806  7293  9519  2448 947 );;
"27" ) target=( 32122 12798 13313 37278 16639 6777  7402  7216  3786  5212 11187 2377  1961  2169  3720  5550  1852  612 );;
"32" ) target=( 17130 6007  6428  10974 7386  3668  3413  3765  1914  2674 5256  1284  919   1128  1918  3160  1355  406 );;
"37" ) target=( 10026 3347  3593  4369  3879  2027  1691  2145  1037  1421 2470  780   516   679   1058  1788  1005  281 );;
esac

frs=50
rcflag=1

j=0
for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    yuv=${i}.yuv
    out=${i}.264
    rec=${i}_rec.yuv
    cons=${i}_cons.txt
#    infile=e:/sequences/$yuv
    infile=D:\\hfz\\sequences\\$yuv
    rem=$((fps%2))
    if [ $rem -eq 0 ]
    then
        interval=$fps
    else
        quo=$((fps/2))
        quo=$((quo+1))
        interval=$((quo*2))
    fi
    case $rcflag in
        "0" )
            # for CQP
            interval=30
#            cmd="./Test_Windows.exe -o $out $infile --input-res $width"x"$height --fps $fps --frames $frs --dump-yuv $rec --profile baseline --threads -1 -I $interval -v --psnr --qp $qp 2>&1| tee -a $cons"
cmd="Test_Windows.exe --frames $frs --threads -1 -I $interval -v --psnr --ssim --qp $qp --ipratio 1.0 --pbratio 1.0 --aq-mode 0 --no-scenecut --bframes 0 --b-adapt 0 --ref 5 --no-psy --no-asm -o $out $infile --input-res $width"x"$height --fps $fps >$cons 2>&1 "
#cmd="x264-2006-learning.exe -v -I 30 -b 2 --ref 5 --no-b-adapt --no-asm --psnr --ssim --qp 22 --ipratio 1.0 --pbratio 1.0 -o $out $infile $width"x"$height >$cons 2>&1"
            ;;
        "1" )
            brate=${target[$j]}
            ((j++))
            # for ABR
       #     cmd="./Test_Windows.exe -o $out $infile --input-res $width"x"$height --fps $fps --frames $frs --dump-yuv $rec --profile baseline --threads -1 -I $interval -v --psnr --bitrate $brate 2>&1| tee -a $cons"
cmd="Test_Windows.exe --frames $frs --threads -1 -I $interval --aq-mode 0 --no-mb-tree -b 0 --b-adapt 0 --ref 5 --no-scenecut -v --tune psnr --psnr --tune ssim --ssim --no-psy --no-asm -B $brate -o $out $infile --input-res $width"x"$height --fps $fps >$cons 2>&1"
            ;;
        "2" )
            brate=${target[$j]}
            ((j++))
            vmax=$brate
            #((vbuf=brate+brate/2))
            ((vbuf=2*brate))
            # for VBV-CBR
            cmd="./Test_Windows.exe -o $out $infile --input-res $width"x"$height --fps $fps --frames $frs --dump-yuv $rec --profile baseline --threads -1 -I $interval -v --psnr --bitrate $brate --vbv-maxrate $vmax --vbv-bufsize $vbuf 2>&1| tee -a $cons"
            #cmd="Test_Windows.exe -o $out $infile --input-res $width"x"$height --fps $fps --frames $frs --dump-yuv $rec --profile baseline --threads -1 -I $interval -v --psnr --bitrate $brate --vbv-maxrate $vmax --vbv-bufsize $vbuf 2>&1 >$cons"
            ;;
    esac
#    echo $cmd >$cons
echo $cmd
#    eval $cmd

done
