@echo off
set ver=1.0.1.1
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
if not exist wget.exe goto echo 没有找到Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("请先退出Opera！!",64,"SimpleU+")(window.close)&Pause
rem 权限检测模块
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set a=%SystemRoot%\SysWOW64) Else (Set a=%SystemRoot%\system32)
Md "%a%\test_permissions" 2>nul||(echo 请使用右键-以管理员身份运行!!! & choice /t 2 /d y /n >nul &Exit)
Rd "%a%\test_permissions" >nul 2>nul
rem Opera参数调用设置
if '%1'=='opis' goto:opinst
if '%1'=='opup' goto:opupdate
if '%1'=='opcl' goto:opclean
if '%1'=='opgdi' goto:opgdi

:opupdate
echo 正在下载数据，请稍候... ...
del operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/fastforward.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/feedreaders.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/license.txt
wget http://hostsx.googlecode.com/svn/trunk/Opera/bookmarks.adr
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
exit

:opgdi
mshta vbscript:msgbox("在以GDI方式启动Opera前，请先手动关闭当前浏览器窗口！",64,"OperaU")(window.close)
mshta vbscript:msgbox("已经在桌面上创建 以GDI方式启动Opera的快捷方式！",64,"OperaU")(window.close)
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\Opera Gdi+.lnk""):b.TargetPath=""%~dp0Gdi.vbs"":b.WorkingDirectory=""%~dp0\"":b.IconLocation=""%~dp0\opera.exe"":b.Description=""以GDI+方式启动Opera"":b.Save:close")&goto menu
exit
