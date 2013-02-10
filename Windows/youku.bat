@echo off
setlocal enabledelayedexpansion
set k=taskkill /f /t /im
start /min iexplore http://i.youku.com/u/UMzI4MTU2ODQ
del /f /q %windir%\system32\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 > %windir%\system32\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 >> %windir%\syswow64\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 >> %windir%\system32\mms.cfg >nul 2>nul
ping 127.0.0.1 -n 3 >nul
%k% iexplore.exe >nul 2>nul
ping 127.0.0.1 -n 2 >nul
for /f "delims=" %%i in ('dir /b /ad "%APPDATA%\Macromedia\Flash Player\#SharedObjects\"') do (
set str=%%i
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.pplive.cn" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.pplive.cn"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\d1.sina.com.cn" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\d1.sina.com.cn"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\www.iqiyi.com" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\www.iqiyi.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.letvcdn.com" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.letvcdn.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com")
rd "%APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\#static.youku.com" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\#static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\#irs01.net" /s/q >nul 2>nul
c:> "%APPDATA%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\#irs01.net"
ipconfig -flushdns >nul 2>nul
msg %username% /time:2 "视频播放广告已免疫！"
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
exit