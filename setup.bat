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
echo 对原Hosts进行备份 ...
copy /y %hosts% %etc%\"Hosts安装_%bf%" >nul 2>nul
echo 备份完成
if exist down\HostsTool.bat goto new 
:new
del HostsTool.bat
copy down\HostsTool.bat HostsTool.bat
pause
cls

:dft
title 正在更新Hosts数据
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget组件不存在，请重新运行本程序！)&pause&exit
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
mshta vbscript:msgbox("正在下载数据！",64,"Hosts Tool")(window.close)
pause
copy down\HostsX.orzhosts %hosts%
goto finish

:finish
title 设置Hosts文件访问权限
mode con: cols=50 lines=15
color 0b
echo 1,设为只读
echo 2,设置Hosts文件防删权限（NTFS磁盘格式有效）
echo 3,不设置任何权限
SET Choice=
SET /P Choice=请在修改完成关闭记事本后进行选择，按回车键确认：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO readonly
IF /I '%Choice%'=='2' GOTO ntfs
IF /I '%Choice%'=='3' GOTO pmfinish
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfs
attrib +r +a +s %hosts%
echo y|cacls %hosts% /g everyone:r
goto pmfinish
:pmfinish
echo Hosts文件权限设置完成！
goto last

:openhosts
start explorer %etc%\
goto menu

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