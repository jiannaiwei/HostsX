@echo off
cd %HOMEPATH%\Application Data\Macromedia\Flash Player\#SharedObjects
DIR /AD /B >%TEMP%\dirname.txt
for /f %%i in (%TEMP%\dirname.txt) do set b=%%i
cd %b%
attrib static.youku.com -r -h -s
del static.youku.com
echo. >>static.youku.com
attrib +r static.youku.com
start explorer.exe %HOMEPATH%\Application Data\Macromedia\Flash Player\#SharedObjects\%b%
del %TEMP%\dirname.txt
echo ***YouKu广告屏蔽完成***
goto:eof