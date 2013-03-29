@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
del /f Android.txt out.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt hosts
echo title HostsX BatchVersion >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
rem call :smarhosts
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;hostsxversion=0.6.1.7>>Version.txt
echo ;author=Hostsx Contributor>>Version.txt
echo ;include=kwoktree.OrzFly.jason_jiang.Felix Hsu.linjimmy.ZephyR.atmouse.Ehosts.zhqjsh>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
set files=bat.txt Version.txt Rd.txt 1Key.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionRU.txt UnionJP.txt UnionCN.txt Dnt.txt Hijack.txt Virus.txt Mwsl.txt Popups.txt
for %%a in (%files%) do (type "%%a">>HostsX.orzhosts)
ren HostsX.orzhosts Android.txt
start hosts.vbs
ping -n 5 127.0.0.1
copy hosts "%~dp0..\"
md "%~dp0..\OS\system\etc"
copy hosts "%~dp0..\OS\system\etc"
del /f new.txt Android.txt out.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt hosts
echo 7z u HostsX_updates.zip system\etc\hosts >"%~dp0..\OS\7z.bat"
echo rd /s/q system >>"%~dp0..\OS\7z.bat"
echo del hosts >>"%~dp0..\OS\7z.bat"
echo del %%0 >>"%~dp0..\OS\7z.bat"
cd %~dp0..\OS
7z.bat
exit

:smarhosts
wget http://smarthosts.googlecode.com/svn/trunk/hosts
ping -n 5 127.0.0.1
ren hosts 1.txt
sed -i "1,7d" 1.txt
sed -i "/Facebook End/,$d" 1.txt
sed -i "/^$/d" 1.txt
sed -i "/^#/d" 1.txt
sed -i "/googlesyndication.com/d" 1.txt
sed -i "/google-analytics.com/d" 1.txt
sed -i "/googleadservices.com/d" 1.txt
ping -n 3 127.0.0.1
sed -i "1i\#Smarthosts-Google" 1.txt
goto :eof

:mac
rem http://sourceforge.net/projects/dos2unix/
mac2unix -ascii -n Apple.txt out.txt
unix2dos -n out.txt Applenew.txt 
set files=Version.txt Rd.txt Applenew.txt 1Key.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionRU.txt UnionJP.txt UnionCN.txt Dnt.txt Hijack.txt HijackIP.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
sed -e "s/0.0.0.0/127.0.0.1/g" hosts.txt > hosts
move /y hosts "%~dp0..\"
goto :eof