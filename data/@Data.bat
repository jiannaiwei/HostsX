@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
echo title HostsX 数据更新工具 >Version.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>Version.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>Version.txt
echo goto :eof >>Version.txt
echo.>>Version.txt
echo ;version=%time% %date%>>Version.txt
echo ;hostsxversion=0.5.2.1>>Version.txt
echo ;author=KwokTree.jason_jiang.OrzFly.Felix Hsu.linjimmy.ZephyR>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
set files=Version.txt Rd.txt 1Key.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Soft.txt Mobile.txt UnionEN.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>HostsX.orzhosts)
start hosts.vbs
ping -n 2 127.0.0.1
move /y HostsX.orzhosts "%~dp0..\"
move /y hosts "%~dp0..\"
del /f Version.txt