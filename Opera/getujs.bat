@echo off
pushd %~dp0
del *.user.jsx
del CleanPlayer.user.js Super_preloader.db.js DBankLinker.jsx doubanfilm.user.js doubaniask.user.js doubanimdb.user.js TianyaRead.user.js goglrwt.js
wget http://userscripts.org/scripts/source/30096.user.js
ren 30096.user.js Anti-Disabler.user.jsx
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
wget http://userscripts.org/scripts/source/105153.user.js
ren 105153.user.js greasemonkey-emulation.user.jsx
wget http://userscripts.org/scripts/source/45836.user.js
ren 45836.user.js xiaonei_reformer.min.user.jsx
wget http://userscripts.org/scripts/source/103552.user.js
ren 103552.user.js doubanimdb.user.jsx
wget http://userscripts.org/scripts/source/129215.user.js
ren 129215.user.js OnlinedownNoAds.user.jsx
wget http://userscripts.org/scripts/source/129534.user.js
ren 129534.user.js doubanfilm.user.jsx
wget http://userscripts.org/scripts/source/123244.user.js
ren 123244.user.js doubaniask.user.js
wget http://userscripts.org/scripts/source/133534.user.js
ren 133534.user.js TianyaRead.user.js
wget http://userscripts.org/scripts/source/121956.user.js
ren 121956.user.js LotusScent.user.jsx
wget http://userscripts.org/scripts/source/142198.user.js
ren 142198.user.js Super_preloader.db.js
msg %username% /time:3 "【UserJs数据已更新！】"
