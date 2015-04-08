encoder=$1

case ${encoder} in
    "as265") 
        executor="ashevc.exe"
        absolute_path="/cygdrive/d/workspace/arcsoft_codes/HEVC_Codec/bin/Win32/Release/" 
        ;;
    "x265") 
        executor="x265.exe"
        absolute_path="/cygdrive/d/workspace/src.x265/multicoreware-x265-hfz/build/vc10-x86/Release/"
        ;;
    "x264") 
        executor="x264.exe"
        absolute_path="/cygdrive/d/workspace/src.x264/x264_latest/bin/Release/"
        ;;
    "x264_2012") 
        executor="x264_2012.exe"
        absolute_path="/cygdrive/d/workspace/src.x264/x264-snapshot-20121028-2245-win-hfz/Test_Project/Test_Windows/Release/"
        ;;
    "hm") 
        executor="TAppEncoder.exe"
        absolute_path="/cygdrive/d/workspace/src.hm/svn_HEVCSoftware/bin/vc10/Win32/Release/"
        ;;
esac
declare -A encoder_executors
encoder_executors["as265"]="ashevc.exe"
encoder_executors["x265"]="x265.exe"
encoder_executors["x264"]="x264.exe"

#echo ${executors[*]}
#echo ${executors["x264"]}


