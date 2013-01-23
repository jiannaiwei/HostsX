@echo off
pushd %~dp0
del *.user.jsx doubaniask.user.js picViewer.js doubanimdb.user.js ush.js InputCtrl.js CrackUrlDN.js Search_engineJump.js http2https.js goglrd.js nolazyload.js Linkify.js TiebaFix.js 0AutoPagerize.SITEINFO.jsx DBankLinker.jsx FlashBlock.jsx SmoothScrollTopBottom.jsx YoukuSS.jsx
wget http://userscripts.org/scripts/source/103552.user.js
wget http://userscripts.org/scripts/source/105741.user.js
wget http://userscripts.org/scripts/source/123244.user.js
wget http://userscripts.org/scripts/source/154702.user.js
wget http://userscripts.org/scripts/source/151249.user.js
wget http://userscripts.org/scripts/source/152399.user.js
wget http://userscripts.org/scripts/source/153190.user.js
wget http://userscripts.org/scripts/source/154473.user.js
wget http://userscripts.org/scripts/source/154476.user.js
wget http://userscripts.org/scripts/source/153687.user.js
wget http://userscripts.org/scripts/source/153275.user.js
rem https://raw.github.com/izml/ujs/master/InputCtrl.js
rem wget --no-check-certificate -N "https://raw.github.com/izml/ujs/master/ush.js"
ren 103552.user.js doubanimdb.user.js
ren 105741.user.js picViewer.js
ren 123244.user.js doubaniask.user.js
ren 154702.user.js goglrd.js
ren 154476.user.js http2https.js
ren 151249.user.js nolazyload.js
ren 152399.user.js Search_engineJump.js
ren 153190.user.js CrackUrlDN.js
ren 153275.user.js InputCtrl.js
ren 154473.user.js Linkify.js
ren 153687.user.js TiebaFix.js
wget http://userscripts.org/scripts/source/156472.user.js
ren 156472.user.js chromexd.user.js
wget http://userscripts.org/scripts/source/116879.user.js
ren 116879.user.js DBankLinker.js
wget http://userscripts.org/scripts/source/126489.user.js
ren 126489.user.js FlashBlock.js
rem https://raw.bitbucket.org/zbinlin/blockpopupwindow/get/tip.zip
wget http://userscripts.org/scripts/source/154323.user.js
ren 154323.user.js SmoothScrollTopBottom.js
wget http://userscripts.org/scripts/source/84972.user.js
ren 84972.user.js YoukuSS.js
wget http://ss-o.net/userjs/0AutoPagerize.SITEINFO.js
wget http://userscripts.org/scripts/source/30096.user.js
ren 30096.user.js Anti-Disabler.user.js
wget http://userscripts.org/scripts/source/105184.user.js
ren 105184.user.js angerOfPresident.user.js
wget http://userscripts.org/scripts/source/120679.user.js
ren 120679.user.js CleanPlayer.user.js
wget http://userscripts.org/scripts/source/25105.user.js
ren 25105.user.js YtbDown.user.js
wget http://userscripts.org/scripts/source/118033.user.js
ren 118033.user.js AdSkipper.user.js
wget http://userscripts.org/scripts/source/138814.user.js
ren 138814.user.js Xunlei.Any.Player.user.js
wget http://userscripts.org/scripts/source/105153.user.js
ren 105153.user.js greasemonkey-emulation.user.js
wget http://userscripts.org/scripts/source/45836.user.js
ren 45836.user.js xiaonei_reformer.min.user.js
wget http://userscripts.org/scripts/source/121956.user.js
ren 121956.user.js LotusScent.user.js
msg %username% /time:3 "【UserJs数据已更新！】"&exit
