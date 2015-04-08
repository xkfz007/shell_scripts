#!/bin/bash
#./rc_cl_encoder.sh -o e://hfz//as265_rc_test10-lt1// -r 0 -F 1 -L 1 >/cygdrive/f/as265_rc_tests/as265_rc_test10-lt1/rc_test1.bat
#./rc_cl_x264.sh -L 1 >/cygdrive/f/as265_rc_tests/as265_rc_test11-lt1/rc_test1.bat
ipath="e:/hfz/sequences/"
idx="as265_rc_test20"
opath="e:/hfz/"${idx}
bat_path="/cygdrive/f/as265_rc_tests/"${idx}
bat_name="rc_test1.bat"

#./rc_cl_encoder.sh -e "x265" -i $ipath -o ${opath}"-l/" -f 500 -F 4 -W 1 -r 1 -t >${bat_path}"-l/rc_test1.bat"
#./rc_cl_encoder.sh -e "x264" -i $ipath -o ${opath}"-m/" -f 500 -F 4 -W 1 -r 1 -t >${bat_path}"-m/rc_test1.bat"
num="-a/"
./rc_cl_encoder.sh -e "as265" -i $ipath -o ${opath}${num} -f 2000 -F 1 -W 0 -r 0 -t >${bat_path}${num}${bat_name}
