@echo off
set ver=1.05
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
if not exist wget.exe goto echo 没有找到Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("请先退出Opera！!",64,"SimpleU+")(window.close)&Pause
echo 正在下载数据，请稍候... ...
del operaprefs_default.ini locale\en\license.txt locale\zh-cn\bookmarks.adr locale\zh-cn\standard_speeddial.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/license.txt
wget http://hostsx.googlecode.com/svn/trunk/Opera/bookmarks.adr
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_speeddial.ini
move license.txt locale\en
move bookmarks.adr locale\zh-cn
move standard_speeddial.ini locale\zh-cn
echo 默认配置已更新！
cd profile\script
del Super_preloader.db
wget http://Hostsx.googlecode.com/svn/trunk/Opera/Super_preloader.db.js
echo UserJs数据已更新！
cd ..
del /f /q autoupdate_response.xml download.dat global_history.dat opthumb.dat search_field_history.dat tasks.xml vlink4.dat opuntrust.dat optrust.dat optrb.dat typed_history.xml upgrade.log
rd /s /q application_cache cache dictionaries icons opcache pstorage temporary_downloads vps webserver
echo 使用痕迹清理完毕!
del override.ini search.ini urlfilter.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/override.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/search.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/urlfilter.ini
del keyboard\standard_keyboard.ini mouse\standard_mouse.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_keyboard.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_mouse.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_menu.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/standard_toolbar.ini
md mouse keyboard menu toolbar
move standard_keyboard.ini keyboard\
move standard_menu.ini menu\
move standard_mouse.ini mouse\
move standard_toolbar.ini toolbar\
cd ..
echo Profiles数据已更新!
cd profile\styles\user
del BBS.css Custom.css OperaU.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/BBS.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/Custom.css
wget http://hostsx.googlecode.com/svn/trunk/Opera/OperaU.css
echo CSS数据已更新!
mshta vbscript:msgbox("配置文件已是最新状态！",64,"SimpleU+")(window.close) & goto exit
