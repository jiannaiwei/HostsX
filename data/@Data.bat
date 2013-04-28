@echo off
ver=0.0.0.7
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f Android.txt out.txt Version.txt bat.txt hbhosts.txt 1.txt hosts.txt Applenew.txt 1hosts.txt unix.txt out.txt hosts Xunlei.txt SD.txt
echo title HostsX BatchVersion >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
call :hostsfile
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;author=Hosts Contributor>>Version.txt
echo ;include=kwoktree.OrzFly.jason_jiang.Felix Hsu.linjimmy.ZephyR.atmouse.Ehosts.zhqjsh.JayXon>>Version.txt
echo ;description=Clean Safe and Useful Hosts file.Thanks EveryOne.>>Version.txt
call :Xunlei
set files=bat.txt Version.txt RD.txt newrd.txt SA.txt Mobile.txt Game.txt Active.txt Soft.txt SiteEN.txt SiteJP.txt SiteTW.txt SiteCN.txt Media.txt Xunlei.txt UnionEN.txt UnionRU.txt UnionJP.txt UnionCN.txt Dnt.txt Hijack.txt Hijacking.txt Virus.txt Phishing.txt Porn.txt Dispute.txt Mwsl.txt Popups.txt
for %%a in (%files%) do (type "%%a">>Android.txt)
start hosts.vbs
ping -n 5 127.0.0.1
copy hosts "%~dp0..\"
rem ver
md "%~dp0..\OS\system\etc"
copy hosts "%~dp0..\OS\system\etc"
del /f 1.txt 1hosts.txt Android.txt Applenew.txt Avira.txt Blshe.txt Dropbox.txt Facebook.txt Flashget.txt Friendfeed.txt Google.txt Gravatar.txt Mediafire.txt Multiupload.txt Sandai.txt Twitter.txt Version.txt Wiki.txt Wordpress.txt Xunlei.txt Yahoo.txt bat.txt hbhosts.txt hosts hosts.txt imdb.txt new.txt newrd.txt out.txt qqxf.txt test.txt unix.txt yfrog.txt 
echo 7z u HostsX_updates.zip system\etc\hosts >"%~dp0..\OS\7z.bat"
echo rd /s/q system >>"%~dp0..\OS\7z.bat"
echo del hosts >>"%~dp0..\OS\7z.bat"
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

:hostsfile
wget -c -N --no-check-certificate https://raw.github.com/davidsun/HostsFile/master/hosts
del SA.txt newrd.txt Apple.txt Avira.txt Flashget.txt Sandai.txt qqxf.txt Google.txt Facebook.txt Twitter.txt yfrog.txt Yahoo.txt Blshe.txt Friendfeed.txt imdb.txt Gravatar.txt Wordpress.txt Dropbox.txt Mediafire.txt Multiupload.txt Wiki.txt SD.txt
copy hosts test.txt
echo #QQXF Accelerate >qqxf.txt
echo 124.115.11.175 cloudplayer.xf.qq.com >>qqxf.txt
echo 182.140.134.36 xflx.store.cd.qq.com >>qqxf.txt
echo 121.14.107.184 fs-hello.qq.com >>qqxf.txt
echo 113.108.70.165 fs-conn.qq.com >>qqxf.txt
sed -n -e "/icloud.com/w Apple.txt" -e "/me.com/w Apple.txt"  -e "/mzstatic.com/w Apple.txt" -e "/.apple.com/w Apple.txt" test.txt
sed -i "1i\#Apple Accelerate" Apple.txt
sed -n -e "/avira-update./w Avira.txt" test.txt
sed -i "1i\#Avira Accelerate" Avira.txt
sed -n -e "/.flashget.com/w Flashget.txt" test.txt
sed -i "1i\#FlashGet Accelerate" Flashget.txt
sed -n -e "/.sandai./w Sandai.txt" test.txt
sed -i "1i\#Xunlei Accelerate" Sandai.txt
set files=Apple.txt Avira.txt Flashget.txt Sandai.txt qqxf.txt
for %%a in (%files%) do (type "%%a">>SA.txt)
sed -i "1i\@SmartAccelerate" SA.txt
sed -n -e "/google/w Google.txt" -e "/appspot./w Google.txt" -e "/android./w Google.txt" -e "/.blogger./w Google.txt" -e "/chrome./w Google.txt" -e "/chromium./w Google.txt" -e "/.feedburner/w Google.txt" -e "/keyhole./w Google.txt" -e "/g.co/w Google.txt" -e "/goo.gl/w Google.txt" -e "/.gmail./w Google.txt" -e "/gvt0./w Google.txt" -e "/ggpht./w Google.txt" -e "/.gstatic./w Google.txt" -e "/googleusercontent./w Google.txt" -e "/googleapis./w Google.txt" -e "/googlelabs./w Google.txt" -e "/orkut./w Google.txt" -e "/.youtube./w Google.txt" -e "/youtu.be/w Google.txt" -e "/.ytimg./w Google.txt" test.txt
sed -i "1i\#Google Services" Google.txt
sed -i "/googlesyndication.com/d" Google.txt
sed -i "/google-analytics.com/d" Google.txt
sed -i "/googleadservices.com/d" Google.txt
sed -i "/www.google.com/d" Google.txt
sed -n -e "/fbcdn./w Facebook.txt" -e "/facebook./w Facebook.txt" test.txt
sed -i "1i\#Facebook" Facebook.txt
sed -n -e "/t.co/w Twitter.txt" -e "/.twimg./w Twitter.txt" -e "/twitter./w Twitter.txt" -e "/.tinypic./w Twitter.txt" -e "/twitpic./w Twitter.txt" -e "/twitgoo./w Twitter.txt" test.txt
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
rem sed -n -e "/.yahoo./w Yahoo.txt" -e "/.flickr./w Yahoo.txt" test.txt
sed -n -e "/.yahoo./w Yahoo.txt" test.txt
sed -i "1i\#Yahoo" Yahoo.txt
set files=Google.txt Facebook.txt Twitter.txt yfrog.txt Yahoo.txt Blshe.txt Friendfeed.txt imdb.txt Gravatar.txt Wordpress.txt Dropbox.txt Mediafire.txt Multiupload.txt Wiki.txt
for %%a in (%files%) do (type "%%a">>newrd.txt)
goto :eof

:mac
rem http://sourceforge.net/projects/dos2unix/
mac2unix -ascii -n Apple.txt out.txt
unix2dos -n out.txt Applenew.txt 
set files=Version.txt Rd.txt Applenew.txt Mobile.txt SiteEN.txt SiteCN.txt Media.txt Active.txt Game.txt Soft.txt UnionEN.txt UnionRU.txt UnionJP.txt UnionCN.txt Dnt.txt Hijack.txt IPBlock.txt Virus.txt Popups.txt
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
))>´´½¨.txt


:ver
echo hosts=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>"%~dp0..\Version.txt"
echo AcrylicHosts=20130331103038>>"%~dp0..\Version.txt"
echo fixlist=20130401091927>>"%~dp0..\Version.txt"
echo servers=20130331103039>>"%~dp0..\Version.txt"
echo sources=20130402091514>>"%~dp0..\Version.txt"
goto :eof
