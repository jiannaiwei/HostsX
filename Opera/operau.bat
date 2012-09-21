@echo off
set ver=1.05
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
pushd %~dp0
if not exist wget.exe goto echo 没有找到Wget.exe& choice /t 2 /d y /n >nul & goto exit
Tasklist|Find /i "opera.exe">nul&mshta vbscript:msgbox("请先退出Opera！!",64,"SimpleU+")(window.close)&Pause
echo 正在下载数据，请稍候... ...
del /f /q operaprefs_default.ini
wget http://hostsx.googlecode.com/svn/trunk/Opera/operaprefs_default.ini
echo 默认配置已更新！
cd profile\script
del *.user.jsx
del CleanPlayer.user.js Super_preloader.db.js DBankLinker.jsx doubanfilm.user.js doubaniask.user.js doubanimdb.user.js TianyaRead.user.js goglrwt.js
wget http://userscripts.org/scripts/source/105184.user.js
ren 105184.user.js angerOfPresident.user.jsx
wget http://userscripts.org/scripts/source/120679.user.js
ren 120679.user.js CleanPlayer.user.jsx
wget http://userscripts.org/scripts/source/116879.user.js
ren 116879.user.js DBankLinker.jsx
wget http://userscripts.org/scripts/source/25105.user.js
ren 25105.user.js YtbDown.user.jsx
wget http://userscripts.org/scripts/source/118033.user.js
ren 118033.user.js AdSkipper.user.jsx
wget http://userscripts.org/scripts/source/138814.user.js
ren 138814.user.js Xunlei.Any.Player.user.jsx
wget http://userscripts.org/scripts/source/64877.user.js
ren 64877.user.js Enhanced-word-highlight.user.jsx
wget http://userscripts.org/scripts/source/88932.user.js
ren 88932.user.js greasemonkey-emulation.user.jsx
wget http://userscripts.org/scripts/source/45836.user.js
ren 45836.user.js xiaonei_reformer.min.user.jsx
wget http://userscripts.org/scripts/source/103552.user.js
ren 103552.user.js doubanimdb.user.jsx
wget http://userscripts.org/scripts/source/129215.user.js
ren 129215.user.js OnlinedownNoAds.user.jsx
wget http://userscripts.org/scripts/source/129534.user.js
ren 129534.user.js doubanfilm.user.jsx
wget http://userscripts.org/scripts/source/113577.user.js
ren 113577.user.js goglrwt.js
wget http://userscripts.org/scripts/source/123244.user.js
ren 123244.user.js doubaniask.user.js
wget http://userscripts.org/scripts/source/133534.user.js
ren 133534.user.js TianyaRead.user.js
wget http://userscripts.org/scripts/source/121956.user.js
ren 121956.user.js LotusScent.user.jsx
wget http://Hostsx.googlecode.com/svn/trunk/Opera/Super_preloader.db.js
echo UserJs数据已更新！
cd ..
del /f /q autoupdate_response.xml download.dat global_history.dat opthumb.dat search_field_history.dat tasks.xml vlink4.dat opuntrust.dat optrust.dat optrb.dat typed_history.xml upgrade.log
rd application_cache /s /q
rd cache /s /q
rd dictionaries" /s /q
rd icons /s /q
rd opcache /s /q
rd pstorage /s /q
rd temporary_downloads /s /q
rd vps /s /q
rd webserver /s /q
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
mshta vbscript:msgbox("配置文件已是最新状态！",64,"SimpleU+")(window.close)
start /min iexplore http://weibo.com/vokins & choice /t 2 /d y /n >nul & goto exit
