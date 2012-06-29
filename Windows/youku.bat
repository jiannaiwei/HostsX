@echo off
cd "%appdata%\macromedia\flash player\#sharedobjects" >nul 2>nul
dir /ad /b >%temp%\dirname.txt >nul 2>nul
for /f %%i in (%temp%\dirname.txt) do set b=%%i >nul 2>nul
cd %b% >nul 2>nul
attrib static.youku.com -r -h -s >nul 2>nul
DEL /F /Q "static.youku.com"
RD /S /Q "static.youku.com"
echo. >>static.youku.com >nul 2>nul
attrib +r static.youku.com >nul 2>nul
start explorer.exe "%appdata%\macromedia\flash player\#sharedobjects\%b%" >nul 2>nul
echo ***YouKu广告屏蔽完成***
goto:eof