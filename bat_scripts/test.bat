@echo off 
choice /C YN /M "Do you really want to start this batch?" 
if errorlevel 2 exit

:noraml program 
echo "Everything is normal!"
echo %0
echo %~d0
echo %~dp0
echo %~n0
echo %~x0
echo %~f0
echo %~nx0
pause 
