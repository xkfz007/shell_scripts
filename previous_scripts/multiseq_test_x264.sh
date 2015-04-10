#!/bin/bash
seq_list="PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 Kimono1_1920x1080_24 ParkScene_1920x1080_24 Tennis_1920x1080_24 BasketballDrill_832x480_50 BQMall_832x480_60 PartyScene_832x480_50 FourPeople_1280x720_60 Johnny_1280x720_60 KristenAndSara_1280x720_60 BasketballDrillText_832x480_50 ChinaSpeed_1024x768_30 SlideEditing_1280x720_30 SlideShow_1280x720_20"

qp=22
[ $# -ge 1 ] && qp=$1

case $qp in
"22" ) target=( 67475 31938 41823 119082  61850 13651 17938 15608 7534  11198 21916 6347  6379  5806  7293  9519  2448 947 );;
"27" ) target=( 32122 12798 13313 37278 16639 6777  7402  7216  3786  5212 11187 2377  1961  2169  3720  5550  1852  612 );;
"32" ) target=( 17130 6007  6428  10974 7386  3668  3413  3765  1914  2674 5256  1284  919   1128  1918  3160  1355  406 );;
"37" ) target=( 10026 3347  3593  4369  3879  2027  1691  2145  1037  1421 2470  780   516   679   1058  1788  1005  281 );;
"-1" ) seq_list="BQMall_832x480_60"
       target=(11198)
       qp=22
       ;;
esac

frs=50
rcflag=0
exe="./x264 "

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
    log=${i}.log
    infile=~/sequences/$yuv
    rem=$((fps%2))
    if [ $rem -eq 0 ]
    then
        interval=$fps
    else
        quo=$((fps/2))
        quo=$((quo+1))
        interval=$((quo*2))
    fi
    #basic 
    cmd=$exe"-o $out $infile --input-res $width"x"$height --fps $fps -I $interval --no-scenecut -v --no-psy " 
    # Frames to be encoded
    cmd=$cmd"--frames -1 " 
    # Reference Frames
    cmd=$cmd"--ref 5 "
    # Threads
    cmd=$cmd"--threads -1 "
    # B frames
    cmd=$cmd"-b 0 --b-adapt 0 "
    # ASM
    cmd=$cmd"--no-asm "
    # PSNR and SSIM
    cmd=$cmd"--tune psnr --psnr "
    cmd=$cmd"--tune ssim --ssim "

    case $rcflag in
        "0" )
            # for CQP
            interval=30
#cmd="./x264 --frames -1 --threads -1 -I $interval -b 0 --b-adapt 0 --ref 5 --aq-mode 0 --tune psnr  --psnr --no-scenecut -v --no-psy --no-asm -q $qp -o $out $infile $width"x"$height --fps $fps >$log 2>&1"
cmd=$cmd"-q $qp "
            ;;
        "1" )
            # for ABR
            interval=30
            brate=${target[$j]}
            ((j++))
#cmd="./x264 --frames -1 --threads 4 -I $interval -b 0 --b-adapt 0 --ref 5 --aq-mode 0 --tune psnr  --psnr --no-scenecut -v --no-psy --no-asm -B $brate -o $out $infile $width"x"$height --fps $fps >$log 2>&1"
cmd=$cmd"-B $brate "
            ;;
        "2" )
            # for VBV-CBR
            brate=${target[$j]}
            ((j++))
            vmax=$brate
            #((vbuf=brate+brate/2))
            ((vbuf=2*brate))
#cmd="./x264 -o $out $infile $width"x"$height --fps $fps --frames $frs --dump-yuv $rec --profile baseline --threads -1 -I $interval -v --psnr --bitrate $brate --vbv-maxrate $vmax --vbv-bufsize $vbuf >$log 2>&1"
cmd=$cmd"-B $brte --vbv-maxrate $vmax --vbv-bufsize $vbuf "
            ;;
    esac
    #OUTPUT
    cmd=$cmd" >$log 2>&1 "
    echo $PWD
    echo $cmd 
    eval $cmd
    echo $cmd >>$log

done
