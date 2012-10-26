@echo off
set ver=1.0.0.9
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
if not exist wget.exe goto echo 没有找到Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("请先退出Opera！!",64,"SimpleU+")(window.close)&Pause
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
del /f /q autoupdate_response.xml download.dat global_history.dat search_field_history.dat tasks.xml vlink4.dat opuntrust.dat optrust.dat optrb.dat typed_history.xml upgrade.log
rd /s /q application_cache cache dictionaries icons opcache pstorage temporary_downloads vps webserver
echo 使用痕迹清理完毕!
cls & echo 配置文件已是最新状态！& choice /t 2 /d y /n >nul & goto exit
