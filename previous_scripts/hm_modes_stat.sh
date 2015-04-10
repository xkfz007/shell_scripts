#!/bin/bash
#seq_list="BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQSquare_416x240_60 Flowervase_416x240_30 Keiba_416x240_30 Mobisode2_416x240_30 RaceHorses_416x240_30 HotelPassage_448x336_15 walk_640x480_30 BasketballDrill_832x480_50 BQMall_832x480_60 BQMall2_832x480_60 Flowervase_832x480_30 Keiba_832x480_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_832x480_30 ChinaSpeed_1024x768_30 dancing_1280x720_30 FourPeople_1280x720_60 gopro_1280x720_25 Johnny_1280x720_60 KristenAndSara_1280x720_60 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 car_1920x1080_22 Kimono1_1920x1080_24 LensRotation-b_1920x1080_23 panning-a_1920x1080_23 ParkScene_1920x1080_24 Tennis_1920x1080_24 PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop"
seq_list="bowing_352x288_30 bus_352x288_25 deadline_352x288_30 news_352x288_30 paris_352x288_30 BasketballPass_416x240_50 BlowingBubbles_416x240_50 BQSquare_416x240_60 Flowervase_416x240_30 Keiba_416x240_30 Mobisode2_416x240_30 RaceHorses_416x240_30 HotelPassage_448x336_15 walk_640x480_30 BasketballDrill_832x480_50 BQMall_832x480_60 Flowervase_832x480_30 Keiba_832x480_30 Mobisode2_832x480_30 PartyScene_832x480_50 RaceHorses_832x480_30 dancing_1280x720_30 FourPeople_1280x720_60 gopro_1280x720_25 Johnny_1280x720_60 KristenAndSara_1280x720_60 vidyo1_1280x720_60 vidyo3_1280x720_60 vidyo4_1280x720_60 BasketballDrive_1920x1080_50 BQTerrace_1920x1080_60 Cactus_1920x1080_50 car_1920x1080_22 Kimono1_1920x1080_24 LensRotation-b_1920x1080_23 ParkScene_1920x1080_24 panning-a_1920x1080_23 Tennis_1920x1080_24 PeopleOnStreet_2560x1600_30_crop Traffic_2560x1600_30_crop BasketballDrillText_832x480_50 ChinaSpeed_1024x768_30 SlideEditing_1280x720_30 SlideShow_1280x720_20 "

frs=1000 #FramesToBeEncoded
qp=32

for i in $seq_list
do
    reso=${i#*_}
    width=${reso%x*}
    reso2=${reso#*x}
    height=${reso2%%_*}
    fps=${reso2#*_}
    fps=${fps%_*}

    yuv=${i}.yuv
    out=${i}_str.bin
   # rec=${i}_rec.yuv
    rec=recon.yuv
    cons=${i}_cons.txt
    infile="D:\\hfz\\sequences\\"$yuv

    cmd="TAppEncoder.exe -c encoder_lowdelay_P_main.cfg --InputFile=$infile --BitstreamFile=$out --ReconFile=$rec --FrameRate=$fps --SourceWidth=$width --SourceHeight=$height --FramesToBeEncoded=$frs --QP=%qp% >$cons 2>&1"

    echo $cmd
#    echo $i"||"$width"x"$height"||"$fps"||"$brate

done
