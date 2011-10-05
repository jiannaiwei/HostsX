@ECHO OFF

ECHO 请关闭正在运行的QQ或TM，按任意键继续
PAUSE 1>NUL 2>NUL
taskkill /im qq.exe
taskkill /im tm.exe

ECHO 正在写入HOSTS文件……如果杀毒软件报警，请允许写入
ECHO 0.0.0.0	fodder.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	adshmct.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	hm.l.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS
ECHO 0.0.0.0	adshmmsg.qq.com >>%SYSTEMROOT%\SYSTEM32\DRIVERS\ETC\HOSTS

ECHO 正在删除本地缓存……
cd "%AppData%\Tencent\QQ\Misc"
for /d %%i in (com.tencent.advertisement*) do rd "%%i" /s /q
cd "%AppData%\Tencent\Users\"
del misc.db /s /q

ECHO.
ECHO 已经搞定了！ o(∩_∩)o
ECHO by 木鱼(2011.05.25)
PAUSE 1>NUL 2>NUL
