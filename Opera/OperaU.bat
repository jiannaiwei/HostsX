@echo off
set ver=1.0.1.6
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
rem Opera参数调用设置
if '%1'=='opis' goto:opinst
if '%1'=='opup' goto:opupdate
if '%1'=='opcl' goto:opclean

:opupdate
if not exist wget.exe goto echo 没有找到Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("请先退出Opera！!",64,"SimpleU+")(window.close)&Pause
echo 正在下载数据，请稍候... ...
del operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/fastforward.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/feedreaders.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/license.txt
wget http://hostsx.googlecode.com/svn/trunk/Opera/bookmarks.adr
wget http://hostsx.googlecode.com/svn/trunk/Opera/Bookmarklets.adr
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_speeddial.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/override.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/search.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/urlfilter.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/BBS.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/Custom.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/OperaU.css
wget http://Hostsx.googlecode.com/svn/trunk/Opera/Super_preloader.db.js
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_keyboard.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_mouse.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_menu.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_toolbar.ini
move /y license.txt locale\en
move /y bookmarks.adr locale\zh-cn
move /y Bookmarklets.adr locale\zh-cn
move /y standard_speeddial.ini locale\zh-cn
move /y Super_preloader.db.js profile\script
move /y override.ini profile
move /y search.ini profile
move /y fastforward.ini ui
move /y feedreaders.ini defaults
move /y urlfilter.ini profile
move /y standard_keyboard.ini profile\keyboard
move /y standard_menu.ini profile\menu
move /y standard_mouse.ini profile\mouse
move /y standard_toolbar.ini profile\toolbar
move /y BBS.css profile\styles\user
move /y Custom.css profile\styles\user
move /y OperaU.css profile\styles\user
cls & echo 配置文件已是最新状态！& choice /t 2 /d y /n >nul & goto exit

:opclean
del /f /q autoupdate_response.xml download.dat global_history.dat search_field_history.dat tasks.xml vlink4.dat opuntrust.dat optrust.dat optrb.dat typed_history.xml upgrade.log
rd /s /q application_cache cache dictionaries icons opcache pstorage temporary_downloads vps webserver
echo 使用痕迹清理完毕!
goto:eof

:opinst
rem 权限检测模块
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set a=%SystemRoot%\SysWOW64) Else (Set a=%SystemRoot%\system32)
Md "%a%\test_permissions" 2>nul||(echo 请使用右键-以管理员身份运行!!! & choice /t 2 /d y /n >nul &Exit)
Rd "%a%\test_permissions" >nul 2>nul
mshta vbscript:msgbox("请务必在安装使用前详细阅读服务条款中的内容和问题解答！！！",64,"SimpleU+ Opera")(window.close)
opera.exe -install /desktopshortcut 1 /quicklaunchshortcut 0 /startmenushortcut 0 /setdefaultbrowser 0 /launchopera 1
if not exist %a%\OperaJR.exe copy program\OperaJR.exe %a% >nul 2>nul
reg add "HKCR\operajr" /v "FriendlyTypeName" /d "opera" /f >nul 2>nul
reg add "HKCR\operajr" /v "URL Protocol" /d "" /f >nul 2>nul
reg add "HKCR\operajr\shell\open\command" /ve /d "\"C:\Windows\System32\OperaJR.exe\" \"%%1\"" /f >nul 2>nul
reg add "HKCR\operajr\shell\open\command" /v "Browser" /d "C:\Program Files\Internet Explorer\iexplore.exe" /f >nul 2>nul
reg add "HKCU\Software\Classes\operajr" /v "FriendlyTypeName" /d "opera" /f >nul 2>nul
reg add "HKCU\Software\Classes\operajr" /v "URL Protocol" /d "" /f >nul 2>nul
reg add "HKCU\Software\Classes\operajr\shell\open\command" /ve /d "\"C:\Windows\System32\OperaJR.exe\" \"%%1\"" /f >nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\text/vnd.wap.wml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f >nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f >nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/vnd.wap.xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f >nul 2>nul
for /f "delims=" %%i in ('dir /b /ad "%APPDATA%\Macromedia\Flash Player\#SharedObjects\"') do (
set str=%%i
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.youku.com"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\irs01.net"
rd "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com" /s/q
c:> "%APPDATA%\Macromedia\Flash Player\#SharedObjects\!str!\static.acs86.com")
goto exit
