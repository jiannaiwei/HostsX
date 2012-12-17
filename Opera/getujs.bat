@echo off
pushd %~dp0
del *.user.jsx
del SmoothScrollTopBottom.jsx a-lib-stacktrace.js a-lib-xmlhttp-cd.js InputCtrl.js InputCtrl.jsx CrackUrlDN.js ush.js ush.jsx nolazyload.js 0AutoPagerize.SITEINFO.jsx CleanPlayer.user.js DBankLinker.jsx FlashBlock.jsx Super_preloader.db.js YoukuSS.jsx picViewer.js doubaniask.user.js doubanimdb.user.js goglrd.js
wget --no-check-certificate -N "https://raw.github.com/izml/ujs/master/ush.js"
wget --no-check-certificate -N "https://raw.github.com/izml/ujs/master/InputCtrl.js"
ren ush.js ush.jsx
ren InputCtrl.js InputCtrl.jsx
wget http://userscripts.org/scripts/source/154323.user.js
ren 154323.user.js SmoothScrollTopBottom.jsx
wget http://my.opera.com/xErath/homes/files/a-lib-stacktrace.js
wget http://my.opera.com/xErath/homes/files/a-lib-xmlhttp-cd.js
wget http://userscripts.org/scripts/source/151249.user.js
ren 151249.user.js nolazyload.js
wget http://userscripts.org/scripts/source/153190.user.js
ren 153190.user.js CrackUrlDN.js
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
ren 103552.user.js doubanimdb.user.js
wget http://userscripts.org/scripts/source/129215.user.js
ren 129215.user.js OnlinedownNoAds.user.jsx
wget http://userscripts.org/scripts/source/123244.user.js
ren 123244.user.js doubaniask.user.js
wget http://userscripts.org/scripts/source/133534.user.js
ren 133534.user.js TianyaRead.user.jsx
wget http://userscripts.org/scripts/source/121956.user.js
ren 121956.user.js LotusScent.user.jsx
rem http://userscripts.org/scripts/source/117942.user.js
wget http://userscripts.org/scripts/source/125473.user.js
ren 125473.user.js goglrd.js
wget http://userscripts.org/scripts/source/142198.user.js
ren 142198.user.js Super_preloader.db.js
wget http://ss-o.net/userjs/0AutoPagerize.SITEINFO.js
ren 0AutoPagerize.SITEINFO.js 0AutoPagerize.SITEINFO.jsx
wget http://userscripts.org/scripts/source/84972.user.js
ren 84972.user.js YoukuSS.jsx
wget http://userscripts.org/scripts/source/105741.user.js
ren 105741.user.js picViewer.js
wget http://userscripts.org/scripts/source/126489.user.js
ren 126489.user.js FlashBlock.jsx
msg %username% /time:3 "【UserJs数据已更新！】"
