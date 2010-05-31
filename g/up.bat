@ECHO OFF
title Hosts 更新中...
mode con: cols=50 lines=16
color 5f
set bf=%date:~0,4%年%date:~5,2%月%date:~8,2%日%time:~0,2%时备份
set down=wget -nH -N -c -q -P down
rem 判断操作系统版本
if exist %ComSpec% goto nt else goto 9x
:9x
set etc=%windir%\
set hosts=%windir%\hosts
goto menu
:nt
set etc=%windir%\system32\drivers\etc
set hosts=%windir%\system32\drivers\etc\hosts
goto menu
:menu
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
echo 关闭DNS client服务，以加快DNS解析速度;
echo 正在安装Ipv6协议,以使ipv6可用！
echo 公网可以使用“六飞”获取ipv6更多相关支持！
echo http://www.6fei.com.cn/ 
net stop "Dnscache">nul 2>nul
sc config Dnscache start= disabled>nul 2>nul
ipv6 install>nul 2>nul
rem 设置IE“不从地址栏搜索”
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v AutoSearch /t reg_dword /d 00000000 /f>nul 2>nul
rem 设置IE“支持wap网页浏览”
reg add "HKCU\Software\Classes\MIME\Database\Content Type\text/vnd.wap.wml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/vnd.wap.xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f>nul 2>nul
rem 安全模式浏览IE
rem 打开基本用户类型设置
rem Levels，其值可以为
rem 0x10000                  //增加受限的
rem 0x20000                  //增加基本用户
rem 0x30000                  //增加受限的，基本用户
rem 0x31000                  //增加受限的，基本用户，不信任的
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /v "Levels" /t REG_DWORD /d 0x00030000 /f>nul
echo Windows Registry Editor Version 5.00>%temp%\ie.reg
echo.>>%temp%\ie.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\0\Paths\{beaeacb1-c258-449b-954f-4ef750406b33}]>>%temp%\ie.reg
echo "LastModified"=hex(b):c4,fb,5e,a3,91,10,c9,01>>%temp%\ie.reg
echo "Description"="限制IE为基本用户的策略">>%temp%\ie.reg
echo "SaferFlags"=dword:00000000>>%temp%\ie.reg
echo "ItemData"="*\\iexplore.exe">>%temp%\ie.reg
echo.>>%temp%\ie.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\131072\Paths\{291b2596-e933-443f-843c-643db8cf0b8a}]>>%temp%\ie.reg
echo "LastModified"=hex(b):56,a2,ac,b8,27,b0,c8,02>>%temp%\ie.reg
echo "Description"="限制IE为基本用户的策略">>%temp%\ie.reg
echo "SaferFlags"=dword:00000000>>%temp%\ie.reg
echo "ItemData"="C:\\Program Files\\Internet Explorer\\*.exe">>%temp%\ie.reg
echo.
regedit /s %temp%\ie.reg
echo 	正在更新策略，请稍候……
gpupdate /force>nul
cls
echo.
echo 	OK! IE 已经被限制为基本用户权限，
echo 	您的 IE 浏览器已经有足够的安全性！
echo.
pause
echo 对原Hosts进行备份 ...
copy /y %hosts% %etc%\"Hosts安装_%bf%" >nul 2>nul
echo 备份完成
if exist HostsTool.bat del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
pause
cls
:update
title 正在更新Hosts数据
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget组件不存在，请重新安装本程序！)&pause&exit
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
echo 正在下载数据！&pause
if not exist down\HostsX.orzhosts goto update
copy down\HostsX.orzhosts %hosts%
title 设置Hosts文件只读权限
attrib +r +a +s %hosts%
echo Hosts文件权限设置完成！
goto last

:last
echo Hosts文件权限设置完成
echo 正在刷新dns缓存
ipconfig /flushdns>nul 2>nul
echo 安装完成，清理使用过程中的文件。。。
del /f /s /q 1.txt clxp.txt go.txt hbhosts.txt host.cab host.zip HOSTS-Optimized.txt.sig hosts.txt hostspath.txt mvps.bat zlnotes.txt zlrepeat.txt 禁止IP列表.txt 自定义.txt
del down\*.* /s/q
del backup\*.* /s/q
rd /s /q backup\
rd /s /q down\hosts\
rd /s /q down\
cls
echo 正在清理Dns缓存，IE缓存...
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f>nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f>nul 2>nul
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
cls
echo Enjoy Hosts !
pause
del %0