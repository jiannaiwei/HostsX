@echo off
ver=0.0.1.6
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f Android.txt out.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt hosts Xunlei.txt Google.txt
echo title HostsX BatchVersion >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
rem call :hostsfile
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;author=Hosts Contributor>>Version.txt
echo ;include=kwoktree.OrzFly.jason_jiang.Felix Hsu.linjimmy.ZephyR.atmouse.Ehosts.zhqjsh.JayXon>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
call :Xunlei
set files=bat.txt Version.txt SD.txt Apple.txt Mobile.txt Game.txt Active.txt Soft.txt Site.txt SiteCN.txt Media.txt Xunlei.txt Union.txt UnionCN.txt Hijack.txt Hijacking.txt IPBlock.txt Virus.txt Phishing.txt Porn.txt Dispute.txt Mwsl.txt Popups.txt
for %%a in (%files%) do (type "%%a">>Android.txt)
start hosts.vbs
ping -n 5 127.0.0.1
copy hosts "%~dp0..\"
call :ver
md "%~dp0..\OS\system\etc"
copy hosts "%~dp0..\OS\system\etc"
del /f 1.txt 1hosts.txt Android.txt Applenew.txt Avira.txt Blshe.txt Dropbox.txt Facebook.txt Flashget.txt Friendfeed.txt Google.txt Gravatar.txt Mediafire.txt Multiupload.txt Sandai.txt Twitter.txt Version.txt Wiki.txt Wordpress.txt Xunlei.txt Yahoo.txt bat.txt hbhosts.txt hosts hosts.txt imdb.txt new.txt newrd.txt out.txt qqxf.txt test.txt unix.txt yfrog.txt 
echo 7z u Hosts_updates_unsigned.zip system\etc\hosts>"%~dp0..\OS\7z.bat"
echo rd /s /q system>>"%~dp0..\OS\7z.bat"
echo java -jar signapk.jar -w testkey.x509.pem testkey.pk8 Hosts_updates_unsigned.zip HostsX_updates.zip>>"%~dp0..\OS\7z.bat"
echo del %%0 >>"%~dp0..\OS\7z.bat"
cd %~dp0..\OS
7z.bat
exit

:Xunlei
set /a str+=1
echo 0.0.0.0 %str%.biz5.sandai.net >>Xunlei.txt
echo 0.0.0.0 %str%.logic.cpm.cm.sandai.net >>Xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:smarhosts
wget -c -N http://smarthosts.googlecode.com/svn/trunk/hosts -O Google.txt
sed -i "1,7d" Google.txt
sed -i "/Facebook Start/,$d" Google.txt
sed -i "/^$/d" Google.txt
sed -i "/^#/d" Google.txt
sed -i "/googlesyndication/d" Google.txt
sed -i "/google-analytics/d" Google.txt
sed -i "/googleadservices/d" Google.txt
sed -i "1i\#Google Services" Google.txt
goto :eof

:hostsfile
wget -c -N --no-check-certificate https://raw.github.com/davidsun/HostsFile/master/hosts
del newrd.txt Apple.txt Google.txt Facebook.txt Twitter.txt yfrog.txt Yahoo.txt Blshe.txt Friendfeed.txt imdb.txt Gravatar.txt Wordpress.txt Dropbox.txt Mediafire.txt Multiupload.txt Wiki.txt
copy hosts test.txt
sed -n -e "/icloud.com/w Apple.txt" -e "/me.com/w Apple.txt"  -e "/mzstatic.com/w Apple.txt" -e "/.apple.com/w Apple.txt" test.txt
sed -i "1i\#Apple Accelerate" Apple.txt
rem sed -n -e "/google/w Google.txt" -e "/appspot./w Google.txt" -e "/android./w Google.txt" -e "/.blogger./w Google.txt" -e "/chrome./w Google.txt" -e "/chromium./w Google.txt" -e "/.feedburner/w Google.txt" -e "/keyhole./w Google.txt" -e "/g.co/w Google.txt" -e "/goo.gl/w Google.txt" -e "/.gmail./w Google.txt" -e "/gvt0./w Google.txt" -e "/ggpht./w Google.txt" -e "/.gstatic./w Google.txt" -e "/googleusercontent./w Google.txt" -e "/googleapis./w Google.txt" -e "/googlelabs./w Google.txt" -e "/orkut./w Google.txt" -e "/.youtube./w Google.txt" -e "/youtu.be/w Google.txt" -e "/.ytimg./w Google.txt" test.txt
sed -n -e "/fbcdn./w Facebook.txt" -e "/facebook./w Facebook.txt" test.txt
sed -i "1i\#Facebook" Facebook.txt
sed -n -e "/t.co/w Twitter.txt" -e "/twimg/w Twitter.txt" -e "/twitter./w Twitter.txt" -e "/.tinypic./w Twitter.txt" -e "/twitpic./w Twitter.txt" -e "/twitgoo./w Twitter.txt" test.txt
sed -i "1i\#Twitter" Twitter.txt
sed -n -e "/yfrog./w yfrog.txt" test.txt
sed -i "1i\#yfrog" yfrog.txt
sed -n -e "/blshe./w Blshe.txt" test.txt
sed -i "1i\#Blshe" Blshe.txt
sed -n -e "/friendfeed./w Friendfeed.txt" test.txt
sed -i "1i\#Friendfeed" Friendfeed.txt
sed -n -e "/.media-imdb./w imdb.txt" test.txt
sed -i "1i\#imdb" imdb.txt
sed -n -e "/.gravatar./w Gravatar.txt" test.txt
sed -i "1i\#Gravatar" Gravatar.txt
sed -n -e "/wordpress./w Wordpress.txt" -e "/.wp./w Wordpress.txt" test.txt
sed -i "1i\#Wordpress" Wordpress.txt
sed -n -e "/dropbox./w Dropbox.txt" test.txt
sed -i "1i\#Dropbox" Dropbox.txt
sed -n -e "/mediafire./w Mediafire.txt" test.txt
sed -i "1i\#Mediafire" Mediafire.txt
sed -n -e "/.multiupload./w Multiupload.txt" test.txt
sed -i "1i\#Multiupload" Multiupload.txt
sed -n -e "/wikimedia./w Wiki.txt" -e "/wikipedia./w Wiki.txt" -e "/wiktionary./w Wiki.txt" -e "/wikisource./w Wiki.txt" -e "/wikiquote./w Wiki.txt" -e "/wikileaks./w Wiki.txt" -e "/wikibooks./w Wiki.txt" -e "/wikinews./w Wiki.txt" -e "/mediawiki./w Wiki.txt" test.txt
sed -i "1i\#Wiki" Wiki.txt
sed -n -e "/.yahoo./w Yahoo.txt"  -e "/yimg./w Yahoo.txt" -e "/.flickr./w Yahoo.txt" test.txt
sed -n -e "/.yahoo./w Yahoo.txt" test.txt
sed -i "1i\#Yahoo" Yahoo.txt
call :smarhosts
set files=Google.txt Facebook.txt Twitter.txt yfrog.txt Yahoo.txt Blshe.txt Friendfeed.txt imdb.txt Gravatar.txt Wordpress.txt Dropbox.txt Mediafire.txt Multiupload.txt Wiki.txt
for %%a in (%files%) do (type "%%a">>newrd.txt)
pause
goto :eof

:mac
rem http://sourceforge.net/projects/dos2unix/
mac2unix -ascii -n Apple.txt out.txt
unix2dos -n out.txt Applenew.txt 
set files=Version.txt Rd.txt Applenew.txt Mobile.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionJP.txt UnionCN.txt Hijack.txt IPBlock.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
sed -e "s/0.0.0.0/127.0.0.1/g" hosts.txt > hosts
move /y hosts "%~dp0..\"
goto :eof

@echo off
(for /f "delims=" %%a in ('dir /s/b/a-d "%cd%"') do (
        set a=%%a
        setlocal enabledelayedexpansion
        set/p=!a! <nul
        for /f "tokens=2 delims==." %%b in ('wmic datafile where name^="!a:\=\\!" get CreationDate/value') do echo %%b
        Endlocal
))>创建.txt


:ver
echo hosts=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>"%~dp0..\Version.txt"
echo AcrylicHosts=20130331103038>>"%~dp0..\Version.txt"
echo fixlist=20130401091927>>"%~dp0..\Version.txt"
echo servers=20130331103039>>"%~dp0..\Version.txt"
echo sources=20130402091514>>"%~dp0..\Version.txt"
goto :eof

:360
wget http://webscan.360.cn/url -O url.txt
sed -i "1,91d" url.txt
sed -i "s/</\n/g" url.txt
sed -i "s/>/\n/g" url.txt
sed -i "s/<li><a[^>]*>//" url.txt
sed -i "/a href/d" url.txt
sed -i "/script /d" url.txt
sed -i "/gaq.push/d" url.txt
sed -i "/ class/d" url.txt
sed -i "/a target/d" url.txt
sed -i "/排行/d" url.txt
sed -i "/网/d" url.txt
sed -i "/我/d" url.txt
sed -i "//^$/d" url.txt
gawk "!a[$0]++" url.txt >result.txt
pause
sed -i "/.../d" url.txt
sed -e "s/.*<li><a[^>]*>//g" -e "s/<\/a><\/li>//g" url.txt >hosts.txt
sed -e "s/<[^>]*>//gi" -e "s/^/127.0.0.1 /" url.txt >hosts.txt
goto :eof

