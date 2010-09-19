@echo off
title HostsTool 更新中...
mode con: cols=50 lines=16
color 5f
echo 正在升级相关组件
del ipseccmd.exe HostsTool.bat wget.exe
copy down\ipseccmd.exe ipseccmd.exe>nul 2>nul
copy down\wget.exe wget.exe>nul 2>nul
if exist down\HostsTool.g (copy down\HostsTool.g HostsTool.bat>nul 2>nul) else 
copy down\HostsTool.bat HostsTool.bat>nul 2>nul
echo 关闭DNS client服务，以加快DNS解析速度;
echo 正在安装Ipv6协议及相关支持,以使Ipv6可用！
echo 第一次安装Ipv6时请稍候...
net stop "Dnscache">nul 2>nul
sc config Dnscache start= disabled>nul 2>nul
ipv6 install>nul 2>nul
echo 正在刷新dns缓存
ipconfig /flushdns>nul 2>nul
echo 正在清理IE缓存...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
echo 恢复IE搜索引擎,修复IE工具栏广告
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "SearchUrl" /d "https://www.google.com/keyword/%s"
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Bar" /d "http://www.google.com/ie" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /d "no" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchURL" /v "provider" /d "gogl" /f
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "https://www.google.com/intl/zh-CN/"
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f
cls
echo 清除SOGOU搜狗的IE加载项so.dll
regsvr32 /u /s so.dll >nul 2>nul
del /f %windir%\system32\so.dll >nul 2>nul
reg delete HKCR\NetCafeHlp.AddrHelper /f
reg delete HKCR\NetCafeHlp.AddrHelper.1 /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /v {02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Stats\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072} /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{02AC20DD-5548-4CA7-ACCF-18AFE5A4A072}" /f
cls
title Enjoy The New Version HostsTool !
echo 更新完毕，建议使用新版在线更新一次数据！
call HostsTool.bat&del %0