@echo off
setlocal enabledelayedexpansion
set k=taskkill /f /t /im
start /min iexplore http://i.youku.com/u/UMzI4MTU2ODQ
del /f /q %windir%\system32\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 > %windir%\system32\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 >> %windir%\syswow64\Macromed\Flash\mms.cfg >nul 2>nul
echo RTMFPP2PDisable=1 >> %windir%\system32\mms.cfg >nul 2>nul
ping 127.0.0.1 -n 5 >nul
for /f "delims=" %%i in ('dir /b /ad "%APPDATA%\Macromedia\Flash Player\#SharedObjects\"') do (
set str=%%i
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.pplive.cn" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\player.pplive.cn"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\www.iqiyi.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\www.iqiyi.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com")
%k% iexplore.exe >nul 2>nul
ipconfig -flushdns >nul 2>nul
msg %username% /time:2 "视频播放广告已免疫！"
exit
rd "%APPDATA%\Tencent\QQ\Misc\com.tencent.advertisement" /s/q
c:> "%APPDATA%\Tencent\QQ\Misc\com.tencent.advertisement"
rd "%APPDATA%\Tencent\QQ\SafeBase" /s/q
c:> "%APPDATA%\Tencent\QQ\SafeBase"
rd "%APPDATA%\Tencent\QQDoctor" /s/q
c:> "%APPDATA%\Tencent\QQDoctor"
rd "%APPDATA%\Tencent\QQ\Temp\gm" /s/q
c:> "%APPDATA%\Tencent\QQ\Temp\gm"
rd "%APPDATA%\Tencent\QQ\Misc\GMF" /s/q
c:> "%APPDATA%\Tencent\QQ\Misc\GMF"
rd "%APPDATA%\Tencent\IM" /s/q
c:> "%APPDATA%\Tencent\IM"
rd "%APPDATA%\Tencent\QQ\Misc\GTB_Icons" /s/q
c:> "%APPDATA%\Tencent\QQ\Misc\GTB_Icons"
rd "%APPDATA%\Tencent\QQ\Misc\GroupAlbumSnapshot" /s/q
c:> "%APPDATA%\Tencent\QQ\Misc\GroupAlbumSnapshot"
rd "%AllUsersProfile%\Application Data\Tencent\QQPCMgr" /s/q
c:> "%AllUsersProfile%\Application Data\Tencent\QQPCMgr"
msg %username% /time:2 "QQ广告已免疫！"
rd "%AllUsersProfile%\Application Data\Windows Genuine Advantage" /s/q
c:> "%AllUsersProfile%\Application Data\Windows Genuine Advantage"
rd "%APPDATA%\PPLive\PPTV\Cache\pluginad" /s/q
c:> "%APPDATA%\PPLive\PPTV\Cache\pluginad"
rd "%AppData%\PPStream\adsys" /s/q
c:> "%AppData%\PPStream\adsys"
rd "%AppData%\PPStream\banner" /s/q
c:> "%AppData%\PPStream\banner"
rd "%AppData%\PPStream\Gmad" /s/q
c:> "%AppData%\PPStream\Gmad"
rd "%AppData%\PPStream\notice" /s/q
c:> "%AppData%\PPStream\notice"
rd "%AppData%\PPStream\TipXmls" /s/q
c:> "%AppData%\PPStream\TipXmls"
DEL /F /Q /A -R -H -S -A "%AllUsersProfile%\Application Data\Thunder Network\cid_store.dat"
DEL /F /Q /A -R -H -S -A "%AllUsersProfile%\Application Data\Thunder Network\DownloadLib\pub_store.dat"
Md "%AllUsersProfile%\Application Data\Thunder Network\cid_store.dat"
Md "%AllUsersProfile%\Application Data\Thunder Network\emule_upload_list.dat"
Md "%AllUsersProfile%\Application Data\Thunder Network\DownloadLib\pub_store.dat"
attrib +r +s +h "%AllUsersProfile%\Application Data\Thunder Network\cid_store.dat"
attrib +r +s +h "%AllUsersProfile%\Application Data\Thunder Network\emule_upload_list.dat"
attrib +r +s +h "%AllUsersProfile%\Application Data\Thunder Network\DownloadLib\pub_store.dat"
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
exit