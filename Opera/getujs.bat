@echo off
pushd %~dp0
del *.js
wget http://userscripts.org/scripts/source/92899.user.js
ren 92899.user.js MajorGeneralDownload.user.js
wget http://userscripts.org/scripts/source/116879.user.js
ren 116879.user.js DBankLinker.js
wget http://userscripts.org/scripts/source/126489.user.js
ren 126489.user.js FlashBlock.js
wget --no-check-certificate -N "https://raw.github.com/izml/ujs/master/ush.js"
wget --no-check-certificate -N "https://raw.github.com/izml/ujs/master/InputCtrl.js"
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
wget http://userscripts.org/scripts/source/64877.user.js
ren 64877.user.js Enhanced-word-highlight.user.js
wget http://userscripts.org/scripts/source/105153.user.js
ren 105153.user.js greasemonkey-emulation.user.js
wget http://userscripts.org/scripts/source/45836.user.js
ren 45836.user.js xiaonei_reformer.min.user.js
wget http://userscripts.org/scripts/source/121956.user.js
ren 121956.user.js LotusScent.user.js
msg %username% /time:3 "【UserJs数据已更新！】"&exit
