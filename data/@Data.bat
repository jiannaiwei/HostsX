@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
del /f Android.txt out.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt
rem http://sourceforge.net/projects/dos2unix/
mac2unix -ascii -n Apple.txt out.txt
unix2dos -n out.txt Applenew.txt 
echo title HostsX 数据更新工具 >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
wget http://smarthosts.googlecode.com/svn/trunk/hosts
ping -n 5 127.0.0.1
ren hosts 1.txt
sed -i "1,7d" 1.txt
sed -i "/Facebook End/,$d" 1.txt
sed -i "/^$/d" 1.txt
sed -i "/^#/d" 1.txt
ping -n 3 127.0.0.1
sed -i "1i\#Smarthosts-Google" 1.txt
echo.>Version.txt
echo ;version=%time% %date%>>Version.txt
echo ;hostsxversion=0.5.2.1>>Version.txt
echo ;author=KwokTree.jason_jiang.OrzFly.Felix Hsu.linjimmy.ZephyR>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
set files=bat.txt Version.txt Rd.txt 1.txt 1Key.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt 360url.txt Popups.txt
for %%a in (%files%) do (type "%%a">>HostsX.orzhosts)
move /y HostsX.orzhosts "%~dp0..\"
set files=Version.txt Rd.txt Applenew.txt 1Key.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
sed -e "s/0.0.0.0/127.0.0.1/g" hosts.txt > hosts
move /y hosts "%~dp0..\"
set files=Version.txt Rd.txt 1Key.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>Android.txt)
start hosts.vbs
ping -n 2 127.0.0.1
del /f Android.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt
md "%~dp0..\Android\system\etc"
copy hosts "%~dp0..\Android\system\etc"
move /y hosts "%~dp0..\Android"
echo 7z u HostsX_updates.zip system\etc\hosts >"%~dp0..\Android\7z.bat"
echo rd /s/q system >>"%~dp0..\Android\7z.bat"
echo del %%0 >>"%~dp0..\Android\7z.bat"
cd %~dp0..\Android
7z.bat
exit