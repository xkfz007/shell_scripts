input1='udp://235.1.1.1:48880?overrun_nonfatal=1&fifo_size=10000000'
input2='udp://235.1.1.1:48880?overrun_nonfatal=1&fifo_size=10000000'
input3='udp://235.1.1.1:48880?overrun_nonfatal=1&fifo_size=10000000'
input4='udp://235.1.1.1:48880?overrun_nonfatal=1&fifo_size=10000000'                                                                                                                     

#input3='rtmp://10.200.13.50:19350/live/duanliu'
#input4='rtmp://10.200.13.50:19350/live/guanggao'
#input="angry.birds.ts"                                                                                                                                                                  
#ffmpeg -i "$input4" -i "$input3" -i "$input2" -i "$input1"  -filter_complex "nullsrc=size=640x480 [base]; [0:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft]; [1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright]; [2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft]; [3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright]; [base][upperleft] overlay=shortest=0:eof_action=repeat [tmp1];[tmp1][upperright] overlay=shortest=0:eof_action=repeat:x=320 [tmp2]; [tmp2][lowerleft] overlay=shortest=0:eof_action=repeat:y=240 [tmp3]; [tmp3][lowerright] overlay=shortest=0:eof_action=repeat:x=320:y=240[out]" -map '[out]' -c:v libx264 -f mpegts udp://235.1.1.2:48880
ffmpeg -i "$input4" -i "$input3" -i "$input2" -i "$input1"  -filter_complex "nullsrc=size=640x480 [base]; [0:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft]; [1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright]; [2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft]; [3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright]; [base][upperleft] overlay=shortest=0:eof_action=repeat [tmp1];[tmp1][upperright] overlay=shortest=0:eof_action=repeat:x=320 [tmp2]; [tmp2][lowerleft] overlay=shortest=0:eof_action=repeat:y=240 [tmp3]; [tmp3][lowerright] overlay=shortest=0:eof_action=repeat:x=320:y=240[out]" -map '[out]' -c:v libx264 -f mpegts udp://235.1.1.2:48880

#input1='udp://236.114.126.42:10001?overrun_nonfatal=1&fifo_size=10000000'
#input2='udp://236.114.126.41:10001?overrun_nonfatal=1&fifo_size=10000000'
#input3='udp://236.114.126.47:10001?overrun_nonfatal=1&fifo_size=10000000'
#input4='udp://236.114.126.47:10001?overrun_nonfatal=1&fifo_size=10000000'

#ffmpeg -i "$input1" -i "$input2" -i "$input3" -i "$input4"  \
#-filter_complex "nullsrc=size=640x480 [base]; \
#[0:p:3801:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft]; \
#[1:p:3702:v] setpts=PTS-STARTPTS, scale=320x240 [upperright]; \
#[2:p:4301:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft]; \
#[3:p:4302:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright]; \
#[base][upperleft] overlay=shortest=0:eof_action=pass [tmp1];\
#[tmp1][upperright] overlay=shortest=0:eof_action=pass:x=320 [tmp2]; \
#[tmp2][lowerleft] overlay=shortest=0:eof_action=pass:y=240 [tmp3]; \
#[tmp3][lowerright] overlay=shortest=0:eof_action=pass:x=320:y=240[out]" \
#-map '[out]' -c:v libx264 -f mpegts udp://235.1.1.2:48880 #-f flv  rtmp://172.16.68.206:19350/live/multi_screen
