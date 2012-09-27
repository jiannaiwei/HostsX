@echo off
set ver=0.2
SETLOCAL EnableExtensions
SetLocal EnableDelayedExpansion
mode con cols=30 lines=10
title U+ Hosts
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set a=%SystemRoot%\SysWOW64) Else (Set a=%SystemRoot%\system32)
Md "%a%\test_permissions" 2>nul||(echo 请使用右键-以管理员身份运行!!! & choice /t 2 /d y /n >nul &Exit)
Rd "%a%\test_permissions" >nul 2>nul
cls
set bak=%date:~0,4%年%date:~5,2%月%date:~8,2%日%time:~0,2%时备份
set str=%date:~0,4%%date:~5,2%00
if exist %ComSpec% (set etc=%windir%\system32\drivers\etc&set hosts=%windir%\system32\drivers\etc\hosts) Else (set etc=%windir%\&set hosts=%windir%\hosts)
ipv6 install >nul 2>nul
net stop "Dnscache" >nul 2>nul
sc stop "DNSCache" >nul 2>nul
sc config Dnscache start= disabled >nul 2>nul
sc config iphlpsvc start= AUTO > nul 2>nul
sc config HTTPFilter start= AUTO >nul 2>nul
sc config 6to4 start= auto >nul 2>nul
net start 6to4 >nul 2>nul
netsh interface ipv6 isatap set router isatap.sjtu.edu.cn >nul 2>nul
netsh interface ipv6 isatap set state enabled >nul 2>nul
if not exist %etc%\Bakup\ md %etc%\Bakup\ >nul
call :unlock
copy /y %hosts% %etc%\Bakup\"Hosts_%bak%.txt" >nul 2>nul
echo Backup completed!

:dftvbs
ping /n 2 hostsx.googlecode.com >nul||goto dftlocal
call :upcore
cscript //NoLogo /e:vbscript %temp%/Updates.vbs "http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts">>%temp%\HostsX.orzhosts
rem copy /b %temp%\HostsX.orzhosts+smarthosts.txt hbhosts.txt
copy %temp%\HostsX.orzhosts %hosts%
call :temp&call :dns&msg %username% /time:1 "U+ Hosts data has been Updated！"&Exit

:dns
notepad %hosts%
echo FlushDns...
%k% iexplore.exe >nul 2>nul
ipconfig -flushdns >nul 2>nul
del %SystemRoot%\system32\df.ini >nul 2>nul
del %SystemRoot%\system32\error.dd >nul 2>nul
del %SystemRoot%\system32\Macromed\Flash\mms.cfg >nul 2>nul
DEL /F /Q /A "%CommonProgramFiles%\Adobe\Adobe PCD\cache\cache.db">nul 2>nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files">nul 2>nul
del /f /s /q "%userprofile%\Local Settings\Temp">nul 2>nul
del /f /s /q "%userprofile%\cookies">nul 2>nul
del /f /s /q "%userprofile%\recent">nul 2>nul
ipconfig -flushdns >nul 2>nul
ipconfig -registerdns >nul 2>nul
ipconfig -renew >nul 2>nul
call :youku
goto:eof

:chkupdate
color 0d
Title 在线更新
cls
echo.
echo      正在更新
echo.
echo    ...请稍候...
call :upcore
cscript //NoLogo /e:vbscript %temp%/Updates.vbs "http://hostsx.googlecode.com/svn/trunk/Windows/HostsTool.Src">%cd%\HostsTool.bat
start %cd%\HostsTool.bat& del %0
exit

:upcore
echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) >%temp%/Updates.vbs
echo do until oDOM.readyState = "complete" >>%temp%/Updates.vbs
echo WScript.sleep 200 >>%temp%/Updates.vbs
echo loop >>%temp%/Updates.vbs
echo WScript.echo oDOM.documentElement.outerText >>%temp%/Updates.vbs
goto:eof

:youku
for /f "delims=" %%i in ('dir /b /ad "%APPDATA%\Macromedia\Flash Player\#SharedObjects\"') do (
set str=%%i
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com")
mshta vbscript:msgbox("优酷广告已免疫！",64,"SimpleU+")(window.close)
goto:EOF

:Xunlei
set /a str+=1
echo 0.0.0.0 %str%.biz5.sandai.net >>%hosts%
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
echo 0.0.0.0 %date:~0,4%%date:~5,2%%date:~8,2%.biz5.sandai.net >>%hosts%
goto:eof

:unlock
echo y| cacls %hosts% /c /t /p everyone:f >nul 2>nul
attrib %hosts% -r -h -s >nul 2>nul
goto:eof

:temp
rem call :BeijingIP
call :Xunlei
del %etc%\HostsX.orzhosts & copy %temp%\HostsX.orzhosts %etc%\HostsX.orzhosts
goto:eof

:dftlocal
echo 无法连接服务器！& choice /t 2 /d y /n >nul
echo 或将使用本地缓存Hosts数据！& choice /t 2 /d y /n >nul
if not exist %etc%\HostsX.orzhosts (echo 未找到本地缓存Hosts数据! & choice /t 2 /d y /n >nul&exit) else (copy %etc%\HostsX.orzhosts %hosts% &echo 已更换至本地缓存Hosts数据！)
goto dns
