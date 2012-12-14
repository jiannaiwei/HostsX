@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
title Hosts数据合并更新工具
echo.>Version.txt
echo ;version=%time% %date%>>Version.txt
echo ;hostsxversion=0.5.2.1>>Version.txt
echo ;author=KwokTree.jason_jiang.OrzFly.Felix Hsu.linjimmy.ZephyR>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
set files=Version.txt Rd.txt 1Key.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Soft.txt Mobile.txt UnionEN.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>HostsX.orzhosts)
start hosts.vbs
pause
move /y HostsX.orzhosts "%~dp0..\"
move /y hosts "%~dp0..\"
del /f Version.txt