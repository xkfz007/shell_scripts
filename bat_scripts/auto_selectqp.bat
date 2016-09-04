@echo off

set a=%~dp0
echo %a%
set a=%a:~-3,2%
echo %a%
set qp=22
if "%a%"=="-a" (set qp=27)
if "%a%"=="-b" (set qp=32)
if "%a%"=="-c" (set qp=37)

echo %qp%
Test_HEVC_Encoder.exe -i e:/sequences/BQMall_832x480_60.yuv -o BQMall_832x480_60_str_20140313093748.bin -r BQMall_832x480_60_rec_20140313093748.yuv -w 832 -h 480 -f 60 -q %qp% -n 50 -t 1 -I 30
pause  