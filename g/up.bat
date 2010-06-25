@echo off
title HostsTool 更新中...
mode con: cols=50 lines=16
color 5f
if exist HostsTool.bat del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
echo 正在安装IPv6服务：
ipv6 install
echo 正在设置路由：
netsh interface ipv6 6to4 set state disabled
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567
netsh interface ipv6 6to4 set state enabled
netsh int ipv6 6to4 set relay 6to4.ipv6.microsoft.com
sc config iphlpsvc start= auto
net start iphlpsvc
netsh interface ipv6 6to4 set state disabled
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567
echo 正在刷新dns缓存
ipconfig /flushdns>nul 2>nul
echo 正在清理IE缓存...
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
echo        恢复IE搜索引擎
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "SearchUrl" /d "https://www.google.com/keyword/%s">nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Bar" /d "http://www.google.com/ie" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /d "no" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchURL" /v "provider" /d "gogl" /f>nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\" /f /ve /d "about:blank">nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "https://www.google.com/intl/zh-CN/">nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f>nul 2>nul
echo        修复IE工具栏广告
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
cls
title Enjoy The New Version HostsTool !
mshta vbscript:msgbox("建议使用新版在线更新一次数据！",64,"更新完成！")(window.close)
pause&call HostsTool.bat&del %0