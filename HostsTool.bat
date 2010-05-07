@echo off
color 0a
rem 环境变量设置
set bf=%date:~0,4%年%date:~5,2%月%date:~8,2%日%time:~0,2%时备份
set down=wget -nH -N -c -t 10 -w 2 -q -P down

rem 清理可能影响运行的文件
del /f /s /q echo host hosts>nul 2>nul
del /f /s /q down\*.*>nul 2>nul
del /f /s /q 1.txt clxp.txt go.txt hbhosts.txt HostsX.old ipv6.old hosts.txt hostspath.txt zlnotes.txt zlrepeat.txt 禁止IP列表.txt 自定义.txt>nul 2>nul

rem Wget下载组件检测
if not exist wget.exe ( start /min iexplore http://users.ugent.be/~bpuype/cgi-bin/fetch.pl?dl=wget/wget.exe)& (echo 正在下载Wget组件，请保存在当前目录！)&pause else goto sysver 

rem 判断操作系统版本，并设置系统默认Hosts文件位置的变量。
rem 如果Hosts路径判断不正确，请在主界面下输入find显示，然后替换下面的set hosts=和set etc=右面的内容。
:sysver
if exist %ComSpec% goto nt else goto 9x
:9x
set etc=%windir%\
set hosts=%windir%\hosts
goto menu
:nt
if exist %windir%\system32\cmd.exe goto winnt32
if exist %windir%\system64\cmd.exe goto winnt64
:winnt32
set etc=%windir%\system32\drivers\etc
set hosts=%windir%\system32\drivers\etc\hosts
goto menu
:winnt64
set etc=%windir%\system64\drivers\etc
set hosts=%windir%\system64\drivers\etc\hosts
goto menu
:find
rem 获取系统Hosts路径
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DataBasePath" ^|findstr /i "DataBasePath"') do (
	set "DataBasePath=%%b"
)
echo 当前系统的Hosts路径为：
echo %DataBasePath%
echo %DataBasePath%>>hostspath.txt
pause
start %windir%\notepad.exe %0
start %windir%\notepad.exe %~dp0\hostspath.txt
exit

:menu
mode con cols=71 lines=32
rem 系统文件检测
if not exist cacls.exe (echo 您的系统精简过度，运行所需系统文件缺失！程序将马上下载！)&pause&wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/cacls.exe
rem 解除Hosts只读属性，权限限制
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
title Hosts 小工具
echo ■───────────────────────────────── ■
echo.■   1.Hosts文件调整       2.Acrylic+ 调整       3.工具自动更新      ■
echo ■───────────────────────────────── ■
echo.■   4.打开Hosts文件       5.Hosts文件整理       6.自定义网站屏蔽    ■
echo ■───────────────────────────────── ■
echo.■   7.添加IE不信任网址    8.安全模式IE浏览      9.IP 安全策略       ■
echo ■-------------------------------------------------------------------■
echo.■   B.Hosts文件备份       D.顽固文件删除        F.修复Hosts文件     ■
echo ■-------------------------------------------------------------------■
echo.■   O.打开Hosts目录       P.设置Hosts权限       T.IE 证书管理       ■
echo ■-------------------------------------------------------------------■
echo           今天是:%date% 现在时间:%time%      H.帮助  
echo ■───────────────────────────────── ■
echo 当前工作位置(0)：%~dp0
echo.
set all=
set /p all=请选择相应的操作，按[回车]刷新DNS和缓存：
if /i "%all%"=="b" goto bak
if /i "%all%"=="c" goto clean
if /i "%all%"=="d" goto delwell
if /i "%all%"=="f" goto fixhosts
if /i "%all%"=="h" goto help
if /i "%all%"=="i" goto iefix
if /i "%all%"=="o" goto openhosts
if /i "%all%"=="p" goto Permissions
if /i "%all%"=="t" goto Cert
if /i "%all%"=="v" goto ver
if /i "%all%"=="w" goto find
if /i "%all%"=="1" goto choose
if /i "%all%"=="2" goto Acrylic
if /i "%all%"=="3" goto update
if /i "%all%"=="4" goto run
if /i "%all%"=="5" goto hostsorder
if /i "%all%"=="6" goto Shield
if /i "%all%"=="7" goto notrustsite
if /i "%all%"=="8" goto safeie
if /i "%all%"=="9" goto IPSec
if /i "%all%"=="0" goto opendp
if /i "%all%"=="q" goto exit
if /i "%all%"=="r" goto color

:dns
echo 正在清理Dns缓存 IE缓存...
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f>nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f>nul 2>nul
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
goto menu

:bak
mode con: cols=30 lines=12
echo.
echo 1,备份Hosts文件
echo.
echo 2,删除Hosts备份
echo.
SET Choice=
SET /P Choice=请选择，按[回车]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO hostsbak
IF /I '%Choice%'=='2' GOTO delbak
IF /I '%Choice%'==''  GOTO menu
:hostsbak
echo 对原Hosts进行备份 ...
copy /y %hosts% %etc%\"Hosts_%bf%" >nul 2>nul
echo 备份完成
pause
goto menu
:delbak
echo 是否删除备份的Hosts文件？
Pause
cd %etc%
del Hosts_* /q
del Hosts安装_* /q
echo 由HostsTool备份的Hosts文件已删除！
Pause
goto menu
:fixhosts
mode con: cols=50 lines=12
echo 修复HOSTS文件？（还原系统默认状态）
Pause
del %hosts% /q
goto nohosts
:nohosts
mshta vbscript:msgbox("Hosts文件找不到或被删除!！",64,"Hosts")(window.close)
pause
echo 127.0.0.1       localhost>> %hosts%
echo ::1             localhost>> %hosts%
echo 还原Hosts文件为系统默认状态。
goto run

:run
if not exist %hosts% (call :nohosts) else (start %windir%\notepad.exe %hosts%)
goto Permissions
:openhosts
start explorer %etc%\
goto menu
:opendp
start explorer %~dp0
goto menu

:Permissions
title 设置Hosts文件访问权限
mode con: cols=50 lines=15
echo 1,设为只读
echo 2,设置Hosts文件防删权限（NTFS磁盘格式有效）
echo 3,[返回]不设置任何权限
SET Choice=
SET /P Choice=请在修改完成关闭记事本后进行选择，按回车键确认：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO readonly
IF /I '%Choice%'=='2' GOTO ntfs
IF /I '%Choice%'=='3' GOTO dns
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfs
attrib +r +a +s %hosts%
echo y|cacls %hosts% /g everyone:r
goto pmfinish
:pmfinish
echo Hosts文件权限设置完成！
pause
goto dns

:help
cls
type 说明.txt|more
start http://orztech.com/softwares/hostsx/help
start http://www.uushare.com/user/vokins/file/2559115
mshta vbscript:msgbox("不建议在Hosts文件中添加过多内容！",64,"Hosts")(window.close)
pause
goto menu

:choose
mode con: cols=39 lines=13
cls
echo.
echo 1. HostsX推荐数据 （默认回车使用）
echo.
echo 2. 屏蔽恶意网站
echo.
echo 3. 使用 "冰临宸夏" 整理的IPV6数据
echo.
SET Choice=
SET /P Choice=请选择,输入[0]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO dft
IF /I '%Choice%'=='2' GOTO mwsl
IF /I '%Choice%'=='3' GOTO ipv6
IF /I '%Choice%'=='0' GOTO menu

:dft
if not exist down\HostsX.orzhosts goto update
copy down\HostsX.orzhosts %hosts%
goto finish

:mwsl
title 请选择您要使用的恶意网站数据
mode con: cols=43 lines=21
echo ======================================
echo  使用其他国外优秀的Hosts数据：
echo 1.使用     "死性不改"     整理的数据
echo 2.使用  "恶意网站实验室"  整理的数据
echo 3.使用     "Formynet"     整理的数据
echo ======================================
echo  使用其他国外优秀的Hosts数据：
echo 4,使用       "MVPS"       整理的数据
echo 5,使用  "SomeOneWhoCares" 整理的数据
echo ======================================
echo Ps.以上所有的恶意网站数据只推荐使用一个！
echo ───────────────────
echo  手动修改Hosts数据：
echo 6.屏蔽 "自定义.txt" 内的网站（请自行修改）
echo ───────────────────
echo 不建议同时重复添加使用多个！
echo 不建议在Hosts文件中添加过多内容！
SET Choice=
SET /P Choice=请选择，按[回车]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO clxp
IF /I '%Choice%'=='2' GOTO mwslcn
IF /I '%Choice%'=='3' GOTO formynet
IF /I '%Choice%'=='4' GOTO MVPShosts
IF /I '%Choice%'=='5' GOTO someonewhocares
IF /I '%Choice%'=='6' GOTO myfile
IF /I '%Choice%'==''  GOTO menu
:clxp
echo 正在下载中，请稍候... ...
%down% ftp://hosts:hosts@clxp.vicp.cc/hosts
copy down\hosts 1.txt
echo.>go.txt
echo **********Clxp恶意网站屏蔽数据（包含最新的网马利用或病毒下载地址）***********>>go.txt
echo 正在对恶意网站数据进行整理和精简......
echo 请稍候......
for /f "tokens=1,2 skip=11" %%i in (1.txt) do @echo %%i %%j>>clxp.txt
cls
echo 整理完成! 
echo 是否要使用 "死性不改" 整理的Hosts数据？
pause
copy /b go.txt+clxp.txt hbhosts.txt
copy hbhosts.txt %hosts%
goto finish

:mwslcn
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/mwsl.txt
echo 下载完成，是否要使用 "恶意网站实验室" 整理的Hosts数据？
pause
copy down\mwsl.txt %hosts%
goto finish
:formynet
echo 正在下载中，请稍候... ...
%down% http://www.formynet.cn/web/ljwz.txt
echo 下载完成，是否要使用 "formynet" 整理的Hosts数据？
pause
copy down\ljwz.txt %hosts%
start http://www.formynet.cn/
goto finish
:MVPShosts
echo 正在下载中，请稍候... ...
%down% http://www.mvps.org/winhelp2002/hosts.txt
echo 下载完成，是否要使用 "MVPS" 整理的Hosts数据？
pause
copy down\hosts.txt %hosts%
start http://www.mvps.org/winhelp2002/hosts.htm
goto finish
:someonewhocares
echo 正在下载中，请稍候... ...
%down% http://someonewhocares.org/hosts/hosts
echo 下载完成，是否要使用 "someonewhocares" 整理的Hosts数据？
pause
copy down\hosts %hosts%
start http://someonewhocares.org/hosts/
goto finish
:myfile
echo 请如下所示： 一行一个（每行最多9个） 前面是IP地址，后面是网站域名。0.0.0.0亦可换成127.0.0.1或者>自定义.txt
echo 0.0.0.0 www.xxx.com>>自定义.txt
start %windir%\notepad.exe 自定义.txt
echo 请在修改完毕后关闭记事本，并继续下一步。
echo 请注意备份 自定义.txt 中的的数据！！！
echo 是否要使用 "自定义.txt" 的Hosts数据？
pause
set "in=>>%hosts%"
for /f "delims=" %%a in (自定义.txt) do echo 0.0.0.0%in%
goto finish

:ipv6
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/ipv6.txt
pause
copy down\ipv6.txt %hosts%
goto finish

:Acrylic
mode con: cols=39 lines=25
if not exist Acrylic\ goto :Acrylicerr
NET STOP "Acrylic DNS Proxy Service" > NUL 2> NUL
echo    ==================================
echo          Acrylic DNS Proxy 选项
echo    ==================================
echo        1. 刷新 Acrylic 缓存
echo.
echo        2. 编辑 AcrylicHosts
echo.
echo        3. 安装 Acrylic 服务
echo.
echo        4. 升级 AcrylicHosts
echo.
echo        5. 卸载 Acrylic 服务
echo.
echo        D. 删除 Acrylic（不可恢复！）
echo    ==================================
echo.
SET Choice=
SET /P Choice=请选择，输入[0]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO AcryPc
IF /I '%Choice%'=='2' GOTO openAcry
IF /I '%Choice%'=='3' GOTO AcrySts
IF /I '%Choice%'=='4' GOTO Acryup
IF /I '%Choice%'=='5' GOTO Acryustl
IF /I '%Choice%'=='d' GOTO delAcry
IF /I '%Choice%'=='0' GOTO menu
:AcryPc
cd Acrylic\ >nul 2>nul
echo    ==================================
ECHO      刷新 Acrylic 和 系统DNS 缓存...
DEL /F AcrylicCache.dat > NUL 2> NUL
IPCONFIG /FlushDNS > NUL 2> NUL
echo    ==================================
cd..
goto Acrylast
:openAcry
cd Acrylic\ >nul 2>nul
start %windir%\notepad.exe AcrylicHosts.txt
pause
echo 修改完毕后关闭记事本，按任意键继续！
pause>nul
cd..
goto AcryPc
:AcrySts
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在安装 Acrylic DNS Proxy 服务...
AcrylicService.exe /INSTALL /SILENT > NUL 2> NUL
echo    ==================================
cd..
goto Acrylast
:Acrylast
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在启动 Acrylic DNS Proxy 服务...
NET START "Acrylic DNS Proxy Service" > NUL
echo    ==================================
cd ..
goto menu
:Acryup
echo    ==================================
echo      正在更新 Acrylic Hosts 文件 ...
echo    ==================================
wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/AcrylicHosts.txt
echo AcrylicHosts数据已更新！
pause
goto AcryPc
:Acryustl
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在卸载 Acrylic DNS Proxy 服务...
AcrylicService.exe /UNINSTALL /SILENT
echo    ==================================
cd ..
goto Acrylic
:delAcry
cd Acrylic\ >nul 2>nul
echo    正在卸载 Acrylic DNS Proxy 服务...
AcrylicService.exe /UNINSTALL /SILENT
echo    正在结束进程
taskkill /F /IM AcrylicService.exe /T
taskkill /F /IM AcrylicLookup.exe /T
echo    正在删除文件
del AcrylicConfiguration.ini AcrylicHosts.txt AcrylicLookup.exe AcrylicService.exe /s/q
cd ..
del Acrylic\*.* /s/q
rd /s /q Acrylic\
echo 卸载完毕！
pause
goto menu
:Acrylicerr
echo.
echo  Acrylic文件丢失，无法继续使用该服务！
echo  请重新安装Acrylic组件！
start /min http://goo.gl/Kocp
echo  任意键返回……
pause>nul
goto menu

:update
title 正在更新HostsTool
mode con: cols=40 lines=10
if not exist wget.exe (echo Wget组件不存在，请重新运行本程序！)&pause&exit
echo 正在下载数据，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/setup.bat
%down% http://hostsx.googlecode.com/svn/trunk/HostsTool.bat
del setup.bat
copy down\setup.bat setup.bat
mshta vbscript:msgbox("正在升级中！",64,"Hosts Tool")(window.close)
call setup.bat&exit

:hostsorder
title Hosts文件整理
mode con: cols=50 lines=15
echo 1,删除域名后的#号注释
echo 2,仅删除重复内容
echo 3,删除#号注释并删除重复内容
SET Choice=
SET /P Choice=请选择：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO delnotes
IF /I '%Choice%'=='2' GOTO delrepeat
IF /I '%Choice%'=='3' GOTO delnandr
IF /I '%Choice%'==''  GOTO menu
:delnotes
copy %hosts% zlnotes.txt
echo 正在整理中，请稍等...
for /f "tokens=1,2" %%i in (zlnotes.txt) do @echo %%i %%j>>hosts.txt
goto zlfinish
:delrepeat
copy %hosts% zlrepeat.txt
echo 正在整理中，请稍等...
for /f "tokens=1,2,*" %%i in (zlrepeat.txt) do (
if not defined a%%j set "a%%j=a" &echo %%i %%j %%k>>hosts.txt)
goto zlfinish
:delnandr
copy %hosts% 1.txt
echo 正在整理中，请稍等...
for /f "tokens=1,2" %%i in (1.txt) do @echo %%i %%j>>go.txt
for /f "tokens=1,2,*" %%i in (go.txt) do (
if not defined a%%j set "a%%j=a" &echo %%i %%j %%k>>hosts.txt)
goto zlfinish
:zlfinish
copy hosts.txt %hosts%
del zlrepeat.txt zlnotes.txt hosts.txt
mshta vbscript:msgbox("Hosts文件整理完成！",64,"Hosts")(window.close)
goto dns

:Shield
mode con: cols=62 lines=26
title 自定义网站屏蔽
cls
echo ..............................................................
echo                1.添加要屏蔽的网站
echo.
echo                2.删除已屏蔽的网站
echo.
echo                3.加速网站访问
echo.
echo                4.屏蔽 "自定义.txt" 内的网站（请自行修改）               
echo. 
echo ..............................................................
SET Choice=
SET /P Choice=请选择，按[回车]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO add
IF /I '%Choice%'=='2' GOTO clear
IF /I '%Choice%'=='3' GOTO accelerate
IF /I '%Choice%'=='4' GOTO myfile
IF /I '%Choice%'==''  GOTO menu
:add
echo 如 要屏蔽百度，则输入：www.baidu.com
set /p a=请输入要屏蔽的网站:
echo 0.0.0.0 %a%>>%hosts%
mshta vbscript:msgbox("%a% 已经被屏蔽！",64,"Hosts")(window.close)
goto dns
:clear
echo 如 要取消屏蔽百度，则输入：www.baidu.com
set /p b=请输入要取消屏蔽的网站:
findstr /i "\<%b%\>"<%hosts%||(cls&echo/&echo ***没有找到您输入的网站地址***&pause&goto Shield)
findstr /vi "\<%b%\>"<%hosts% >host
del %hosts%
copy host %hosts%
mshta vbscript:msgbox("已经取消屏蔽 %b%！",64,"Hosts")(window.close)
goto dns
:accelerate
set/p c=输入要加速访问的主机IP地址 (如：192.11.10.69 )
set/p cc= 输入要加速访问的主机域名 (如：www.baidu.com)
echo %c% %cc%>>%hosts%
mshta vbscript:msgbox("%cc% 加速访问设置完成！",64,"Hosts")(window.close)
goto dns

:IPSec
mode con: cols=55 lines=18
echo IP 安全策略 由死性不改发布，现在已经停止更新！是否继续？
pause
sc create PolicyAgent binpath= "C:\WINDOWS\system32\lsass.exe" type= share start= auto displayname= "IPSEC Services" depend= RPCSS/IPSec
sc description PolicyAgent "提供 TCP/IP 网络上客户端和服务器之间端对端的安全。如果此服务被停用，网络上客户端和服务器之间的 TCP/IP 安全将不稳定。如果此服务被禁用，任何依赖它的服务将无法启动。"
if not exist ipseccmd.exe (echo 您的系统精简过度，运行所需系统文件缺失！程序将马上下载！)&pause&wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/ipseccmd.exe
echo 正在下载中，请稍候... ...
wget -nH -N -c ftp://hosts:hosts@clxp.vicp.cc/禁止IP列表.txt
echo 是否要使用 "死性不改" 整理的IP安全策略？
pause
ipseccmd -w reg -p ipsce -y
FOR /f "skip=1 delims= " %%i IN (禁止IP列表.txt) DO call set list=%%list%% %%i
ipseccmd -w reg -p ipsec:1 -r filterlist -f %list% -n BLOCK -x >nul
ipseccmd  -w REG -p "ipsec" -x >nul
gpupdate >nul
pause
goto menu

:safeie
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
echo.
regedit /s %temp%\ie.reg
echo 	正在更新策略，请稍候……
gpupdate /force>nul
cls
echo.
echo.
echo 	OK! IE 已经被限制为基本用户权限，
echo 	您的 IE 浏览器已经有足够的安全性！
echo.
echo 	任意键退出……
pause>nul
goto menu

:notrustsite
mode con: cols=45 lines=17
echo      ==================================
echo             1. 添加IE不信任网址
echo.
echo.
echo             2. 删除IE不信任网址
echo.    
echo      ==================================
SET Choice=
SET /P Choice=请选择，按[回车]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO addnotrustsite
IF /I '%Choice%'=='2' GOTO delnotrustsite
IF /I '%Choice%'==''  GOTO menu

:addnotrustsite
echo 请如下所示： 一行一个网站域名。>自定义.txt
echo www.forexample.com>>自定义.txt
echo example.com>>自定义.txt
start %windir%\notepad.exe 自定义.txt
echo 请在修改完毕后关闭记事本，并继续下一步。
echo 请注意备份 自定义.txt 中的的数据！！！
echo 确定要使用自定义的IE不信任网址数据？
pause
echo       正在添加恶意网址到浏览器非安全区域。
echo       这个过程需要几分钟，请稍候……
set DMAIN=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet 
Settings\ZoneMap\Domains
for /F %%a in (自定义.txt) do reg add "%DMAIN%\%%a" /v * /t REG_DWORD /d 0x00000004 /f >nul
echo       添加完毕……
pause
goto menu
:delnotrustsite
echo  是否要清理IE浏览器非安全区域的所有网址！
pause
reg delete "hkcu\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains" 
/f>nul 2>nul
goto menu

:finish
echo 安装完成，清理使用过程中的文件。。。
del /f /s /q 1.txt clxp.txt go.txt hbhosts.txt host.cab host.zip HOSTS-Optimized.txt.sig 
hosts.txt hostspath.txt mvps.bat zlnotes.txt zlrepeat.txt 禁止IP列表.txt 自定义.txt
del down\*.* /s/q
del backup\*.* /s/q
rd /s /q backup\
rd /s /q down\hosts\
rd /s /q down\
cls
echo 清理完毕，进入Hosts文件权限设置！
pause
goto Permissions

:iefix
mode con cols=38 lines=23
title 对IE组件修复，优化（解决一些网络一时无法访问的问题）
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo    正在对 IE 组件修复，注册，优化
echo.
echo    请等待几秒钟......   
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
regsvr32 /s actxprxy.dll
echo 完成百分之 10
regsvr32 /s shdocvw.dll
echo 完成百分之 15
regsvr32 /s oleaut32.dll
echo 完成百分之 20
Regsvr32 /s URLMON.DLL
echo 完成百分之 25
Regsvr32 /s mshtml.dll
echo 完成百分之 30
Regsvr32 /s msjava.dll
echo 完成百分之 35
Regsvr32 /s browseui.dll
echo 完成百分之 40
Regsvr32 /s softpub.dll
echo 完成百分之 45
Regsvr32 /s wintrust.dll
echo 完成百分之 50 (优化,请等待)
Regsvr32 /s initpki.dll
echo 完成百分之 55
Regsvr32 /s dssenh.dll
echo 完成百分之 60
Regsvr32 /s rsaenh.dl
echo 完成百分之 65
Regsvr32 /s gpkcsp.dll
echo 完成百分之 70
Regsvr32 /s sccbase.dll
echo 完成百分之 75
Regsvr32 /s slbcsp.dll
echo 完成百分之 85
Regsvr32 /s cryptdlg.dll
echo 完成百分之 90
sfc /purgecache
echo 完成百分之 100
echo .对IE组件修复，优化完毕。
Pause.
goto menu

:clean 
title 系统垃圾清除
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo  正在清除系统垃圾文件，请稍等......
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
sfc /purgecache
sfc /purgecache
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\*.log
del /f /s /q %windir%\*.tmp
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
rd /s /q %temp% & md %temp%
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"
echo .系统垃圾清除完毕。
cls
goto menu

:delwell
mode con cols=60 lines=20
echo.
echo 		  【 顽固文件/目录删除器 】
echo 	           -----------------------
echo.
echo  专门快速删除那种不能打开、不能进入、不能删除的顽固目录。
echo.
echo 	注意：删除目录将同时删除其子目录中所有数据！
echo.
echo.
set Choice=
echo 	请将要删除的顽固目录直接拖入本窗口，然后回车:
echo.
set /p Choice=
if ""%Choice%"" == "" goto menu
echo y|Cacls ""%Choice%"" /c /t /p Everyone:f
DEL /F /A /Q \\?\""%Choice%""
RD /S /Q \\?\""%Choice%"" 
echo.
echo 	删除完成! 任意键返回……
goto menu

:Cert
certmgr.msc
goto menu

:color
mode con cols=40 lines=18                                
echo      ---------------------------
echo       A.黑底绿字   B.黑底湖蓝字
echo       C.黑底白字   D.红底亮白字
echo       E.紫底白字   F.亮白底黑字
echo       G.绿底白字   H.自定义
echo      ---------------------------
echo.                                     
echo  小提示：
echo ------------------------------------  
echo   0.黑色1.蓝色2.绿色3.浅绿色4.红色
echo ------------------------------------
echo   5.紫色6.黄色7.白色8.灰色9.浅蓝色
echo ------------------------------------
echo A.浅绿B.浅蓝C.浅红D.淡紫E.浅黄F.亮白
echo ------------------------------------
set input=s
set /p input=请选择，按[0]返回:
if %input%==a (
set ok=1
color 02
 )else (
if /i %input%==b color 03
if /i %input%==c color 07
if /i %input%==d color 4f
if /i %input%==e color 5f
if /i %input%==f color f0
if /i %input%==g color 2f
if /i %input%==h GOTO colormy
if /i %input%==0 GOTO menu
)
goto color
:colormy
set /p a=请输入背景的颜色代码:
set /p b=请输入文字的颜色代码:
color %a%%b%
pause&goto menu

:ver
mode con cols=45 lines=15
title Thx All Friends Help
echo Version:    1.530 Freeware Version
echo Date:       2010.05.07
echo Purpose:    Hosts相关的P处理工具
echo COPYRIGHT:  OrzTech, Inc. BY Jockwok
mshta vbscript:createobject("sapi.spvoice").speak("Enjoy it!")(window.close)
pause
goto menu