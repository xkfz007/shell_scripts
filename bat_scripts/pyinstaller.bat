@ECHO off
IF [%1]==[] GOTO END
python C:\extendedprogs\pyinstaller-2.0\pyinstaller.py --console --onefile -o   %1
PAUSE
:END
ECHO "pyinstaller.bat a.py"
