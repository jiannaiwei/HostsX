@echo off
cd %APPDATA%\Macromedia\Flash Player\#SharedObjects
DIR /AD /B >%TEMP%\dirname.txt
for /f %%i in (%TEMP%\dirname.txt) do set a=%%i
cd %a%
attrib "static.youku.com" -r -h -s
if exist "static.youku.com" (rd /q /s "static.youku.com") else (del /f /s /q "static.youku.com")
@cd.>"static.youku.com"
attrib +r "static.youku.com"
attrib "irs01.net" -r -h -s
if exist "irs01.net" (rd /q /s "irs01.net") else (del /f /s /q "irs01.net")
@cd.>"irs01.net"
attrib +r "irs01.net"
start explorer.exe %APPDATA%\Macromedia\Flash Player\#SharedObjects\%a%
del %TEMP%\dirname.txt
echo ***YouKu广告屏蔽完成***
goto:eof