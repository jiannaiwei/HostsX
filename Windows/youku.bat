@echo off
cd %homepath%\application data\macromedia\flash player\#sharedobjects >nul 2>nul
dir /ad /b >%temp%\dirname.txt >nul 2>nul
for /f %%i in (%temp%\dirname.txt) do set a=%%i >nul 2>nul
cd %a% >nul 2>nul
attrib static.youku.com -r -h -s >nul 2>nul
rd /s /q static.youku.com 2>nul
echo. >>static.youku.com >nul 2>nul
attrib +r static.youku.com >nul 2>nul
start explorer.exe %homepath%\application data\macromedia\flash player\#sharedobjects\%a% >nul 2>nul
echo ***YouKu广告屏蔽完成***
goto:eof