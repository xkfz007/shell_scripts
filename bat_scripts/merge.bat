@echo off
if exist filelist.txt (
	del "filelist.txt"
) else (
    echo file not exist
)

setlocal enabledelayedexpansion
for /l %%i in (1000,1,1023) do (
    for /l %%j in (1000,1,1059) do (
    	set x=%%i
    	set y=%%j
    	if exist %1/!x:~-2!/!y:~-2!.avi (
    		echo file %1/!x:~-2!/!y:~-2!.avi >> filelist.txt
        ) else (
        	echo %1/!x:~-2!/!y:~-2!.avi file not exist
        )        
    )
)
echo "文件合并中..."
ffmpeg.exe -y -f concat -i filelist.txt -c copy "%1".avi 2>merge.log
echo "文件合并完成"