@echo off
pushd %~dp0
del *.user.jsx
wget http://userscripts.org/scripts/source/105184.user.js
ren 105184.user.js angerOfPresident.user.jsx
wget http://userscripts.org/scripts/source/120679.user.js
ren 120679.user.js CleanPlayer.user.jsx
wget http://userscripts.org/scripts/source/64877.user.js
ren 64877.user.js Enhanced-word-highlight.user.jsx
wget http://userscripts.org/scripts/source/88932.user.js
ren 88932.user.js greasemonkey-emulation.user.jsx
wget http://xiaonei-reformer.googlecode.com/files/xiaonei_reformer.min.user.js
ren xiaonei_reformer.min.user.js xiaonei_reformer.min.user.jsx
del DBankLinker.js OnlinedownNoAds.user.js doubanfilm.user.js doubaniask.user.js doubanimdb.user.js http2https.js goglrwt.js
wget http://userscripts.org/scripts/source/103552.user.js
ren 103552.user.js doubanimdb.user.js
wget http://userscripts.org/scripts/source/116879.user.js
ren 116879.user.js DBankLinker.js
wget http://userscripts.org/scripts/source/129215.user.js
ren 129215.user.js OnlinedownNoAds.user.js
wget http://userscripts.org/scripts/source/129534.user.js
ren 129534.user.js doubanfilm.user.js
wget http://userscripts.org/scripts/source/2588.user.js
ren 2588.user.js http2https.js
wget http://userscripts.org/scripts/source/113577.user.js
ren 113577.user.js goglrwt.js
wget http://userscripts.org/scripts/source/91662.user.js
ren 91662.user.js doubaniask.user.js
msg %username% /time:3 "【UserJs数据已更新！】"
