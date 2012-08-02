@echo off
pushd %~dp0
del *.user.jsx
del CleanPlayer.user.js Super_preloader.db.js DBankLinker.js doubanfilm.user.js doubaniask.user.js doubanimdb.user.js TianyaRead.user.js goglrwt.js
wget http://userscripts.org/scripts/source/105184.user.js
ren 105184.user.js angerOfPresident.user.jsx
wget http://userscripts.org/scripts/source/120679.user.js
ren 120679.user.js CleanPlayer.user.js
wget http://userscripts.org/scripts/source/138814.user.js
ren 138814.user.js Xunlei.Any.Player.user.jsx
wget http://userscripts.org/scripts/source/64877.user.js
ren 64877.user.js Enhanced-word-highlight.user.jsx
wget http://userscripts.org/scripts/source/88932.user.js
ren 88932.user.js greasemonkey-emulation.user.jsx
wget http://userscripts.org/scripts/source/45836.user.js
ren 45836.user.js xiaonei_reformer.min.user.jsx
wget http://userscripts.org/scripts/source/103552.user.js
ren 103552.user.js doubanimdb.user.js
wget http://userscripts.org/scripts/source/116879.user.js
ren 116879.user.js DBankLinker.js
wget http://userscripts.org/scripts/source/129215.user.js
ren 129215.user.js OnlinedownNoAds.user.jsx
wget http://userscripts.org/scripts/source/129534.user.js
ren 129534.user.js doubanfilm.user.js
wget http://userscripts.org/scripts/source/113577.user.js
ren 113577.user.js goglrwt.js
wget http://userscripts.org/scripts/source/91662.user.js
ren 91662.user.js doubaniask.user.js
wget http://userscripts.org/scripts/source/128239.user.js
ren 128239.user.js TianyaRead.user.js
wget http://Hostsx.googlecode.com/svn/trunk/Opera/Super_preloader.db.js
msg %username% /time:3 "【UserJs数据已更新！】"
