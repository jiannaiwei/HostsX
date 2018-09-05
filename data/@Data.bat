@echo off
ver=0.0.2.6
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f Apple.txt
call :del
call :bat
call :Version
rem call :ver
call :davidsun
rem call :360
call :smarthosts
call :Xunlei
call :SDall
set files=bat.txt Version.txt SDall.txt Apple.txt Mobile.txt Game.txt Active.txt Soft.txt Site.txt SiteCN.txt Media.txt Xunlei.txt Union.txt UnionCN.txt Hijack.txt Hijacking.txt IPBlock.txt Virus.txt Phishing.txt Porn.txt Dispute.txt Mwsl.txt Popups.txt
for %%a in (%files%) do (type "%%a">>Android.txt)
start hosts.vbs
ping -n 5 127.0.0.1
copy hosts "%~dp0..\"
md "%~dp0..\Tools\system\etc"
copy hosts "%~dp0..\Tools\system\etc"
call :del
echo 7z u Hosts_updates_unsigned.zip system\etc\hosts>"%~dp0..\Tools\7z.bat"
echo rd /s /q system>>"%~dp0..\Tools\7z.bat"
echo java -jar signapk.jar -w testkey.x509.pem testkey.pk8 Hosts_updates_unsigned.zip %~dp0..\Hosts_updates.zip>>"%~dp0..\Tools\7z.bat"
echo del %%0 >>"%~dp0..\Tools\7z.bat"
cd %~dp0..\Tools
7z.bat
exit

:360
wget http://webscan.360.cn/url -O url.txt
sed -i "1,91d" url.txt
sed -i "2143,$d" url.txt
sed -i "s/^[ \t]*//g" url.txt
sed -i "s/>/\n/g" url.txt
sed -i "s/</\n/g" url.txt
sed -i "s/.*<li><a[^>]*>//" url.txt
sed -i "/.html/d" url.txt
sed -i "/ÐÐ/d" url.txt
sed -i "/Íø/d" url.txt
sed -i "/js.ylunion.com/d" url.txt
sed -i "/www.66game.cn/d" url.txt
sed -i "/c1.qmeishi.com/d" url.txt
sed -i "/www.aiqianming.cn/d" url.txt
sed -i "//^$/d" url.txt
pause
sed -i "1i\#Malicious Sites" url.txt
del Mwsl.txt
ren url.txt Mwsl.txt
goto :eof

:davidsun
wget -c -N --no-check-certificate https://raw.github.com/davidsun/HostsFile/master/hosts -O test.txt
sed -n -e "/icloud.com/w Apple.txt" -e "/me.com/w Apple.txt"  -e "/mzstatic.com/w Apple.txt" -e "/.apple.com/w Apple.txt" test.txt
sed -i "1i\#Apple Accelerate" Apple.txt
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
goto :eof

:smarthosts
wget -c -N http://smarthosts.googlecode.com/svn/trunk/hosts
copy hosts smart.txt
sed -i "1,7d" hosts
sed -i "/Facebook Start/,$d" hosts
sed -i "/^$/d" hosts
sed -i "/^#/d" hosts
sed -i "/googlesyndication/d" hosts
sed -i "/google-analytics/d" hosts
sed -i "/googleadservices/d" hosts
sed -i "1i\#Google Services" hosts
(for /f "delims=" %%a in (hosts) do (
   if not defined "%%a" echo %%a&set ""%%a"=a"
))>Google.txt
sed -n -e "/fbcdn./w Facebook.txt" -e "/facebook./w Facebook.txt" smart.txt
sed -i "1i\#Facebook" Facebook.txt
sed -n -e "/twimg/w Twitter.txt" -e "/twitter./w Twitter.txt" -e "/.tinypic./w Twitter.txt" -e "/twitpic./w Twitter.txt" -e "/twitgoo./w Twitter.txt" smart.txt
sed -i "1i\#Twitter" Twitter.txt
sed -n -e "/yfrog./w yfrog.txt" smart.txt
sed -i "1i\#yfrog" yfrog.txt
sed -n -e "/github./w Github.txt" smart.txt
sed -i "1i\#Github" Github.txt
sed -n -e "/.yahoo./w Yahoo.txt"  -e "/yimg./w Yahoo.txt" smart.txt
sed -n -e "/.yahoo./w Yahoo.txt" test.txt
sed -i "1i\#Yahoo" Yahoo.txt
goto :eof

:SDall
set files=SD.txt Google.txt Facebook.txt Twitter.txt yfrog.txt Yahoo.txt Blshe.txt Friendfeed.txt imdb.txt Gravatar.txt Wordpress.txt Dropbox.txt Mediafire.txt Multiupload.txt Wiki.txt
for %%a in (%files%) do (type "%%a">>SDall.txt)
goto :eof

:bat
echo title HostsX BatchVersion >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
goto :eof

:del
del /f 1.txt 1hosts.txt Android.txt Applenew.txt Avira.txt Blshe.txt Dropbox.txt Facebook.txt Flashget.txt Friendfeed.txt Github.txt Google.txt Gravatar.txt Mediafire.txt Multiupload.txt Sandai.txt Twitter.txt Version.txt Wiki.txt Wordpress.txt Xunlei.txt Yahoo.txt bat.txt hbhosts.txt hosts hosts.txt imdb.txt new.txt newrd.txt out.txt qqxf.txt SDall.txt smart.txt test.txt unix.txt yfrog.txt
goto :eof

:ver
echo hosts=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>"%~dp0..\Version.txt"
echo AcrylicHosts=20130331103038>>"%~dp0..\Version.txt"
echo fixlist=20130401091927>>"%~dp0..\Version.txt"
echo servers=20130331103039>>"%~dp0..\Version.txt"
echo sources=20130402091514>>"%~dp0..\Version.txt"
goto :eof

:Version
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;author=Hosts Contributor>>Version.txt
echo ;include=kwoktree.OrzFly.jason_jiang.Felix Hsu.linjimmy.ZephyR.atmouse.Ehosts.zhqjsh.JayXon>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
goto :eof

:Xunlei
set /a str+=1
echo 0.0.0.0 %str%.biz5.sandai.net >>Xunlei.txt
echo 0.0.0.0 %str%.logic.cpm.cm.sandai.net >>Xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
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

:badcode
rem sed -n -e "/google/w Google.txt" -e "/appspot./w Google.txt" -e "/android./w Google.txt" -e "/.blogger./w Google.txt" -e "/chrome./w Google.txt" -e "/chromium./w Google.txt" -e "/.feedburner/w Google.txt" -e "/keyhole./w Google.txt" -e "/g.co/w Google.txt" -e "/goo.gl/w Google.txt" -e "/.gmail./w Google.txt" -e "/gvt0./w Google.txt" -e "/ggpht./w Google.txt" -e "/.gstatic./w Google.txt" -e "/googleusercontent./w Google.txt" -e "/googleapis./w Google.txt" -e "/googlelabs./w Google.txt" -e "/orkut./w Google.txt" -e "/.youtube./w Google.txt" -e "/youtu.be/w Google.txt" -e "/.ytimg./w Google.txt" test.txt
goto :eof