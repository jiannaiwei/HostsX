@echo off
cd %HOMEPATH%\Application Data\Macromedia\Flash Player\#SharedObjects
DIR /AD /B >%TEMP%\dirname.txt
for /f %%i in (%TEMP%\dirname.txt) do set a=%%i
cd %a%
attrib "static.youku.com" -r -h -s
if exist "static.youku.com" (rd /q /s "static.youku.com") else (del /f /s /q "static.youku.com")
@cd.>"static.youku.com"
attrib +r static.youku.com
start explorer.exe %HOMEPATH%\Application Data\Macromedia\Flash Player\#SharedObjects\%a%
del %TEMP%\dirname.txt
echo ***YouKu广告屏蔽完成***
goto:eof