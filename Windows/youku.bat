@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%i in ('dir /b /ad "%APPDATA%\Macromedia\Flash Player\#SharedObjects\"') do (
set str=%%i
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com")
msg %username% /time:2 "优酷广告已免疫！"
goto:EOF