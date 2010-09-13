@echo off
set ver=1.895
rem 设置随机变换颜色
set/a xc=%random%%%5+1
set te=
for %%i in (c d e f a) do (
set /a te=!!te!+1!
if "!xc!"=="!te!" set xc=%%i)
color 0%xc%
cls
rem 环境变量设置
set bak=%date:~0,4%年%date:~5,2%月%date:~8,2%日%time:~0,2%时备份
set down=wget -nH -N -c -t 10 -w 2 -T 10 -P down
set downa=wget -nH -N -c -t 10 -w 2 -T 10 -P Acrylic
rem 清理可能影响运行或者之前运行残留的文件
del /f /q echo host hosts>nul 2>nul
del /f /q down\*.*>nul 2>nul
del /f /q 1.txt go.txt hbhosts.txt hosts.txt 自定义.txt>nul 2>nul
rd /s /q down\hosts\>nul 2>nul
rd /s /q down\>nul 2>nul
rem 判断操作系统版本，并设置系统默认Hosts文件位置的变量。
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

rem 请删除if exist %ComSpec% 至此行上面的内容，并将获取到的Hosts路径填入下方即可。
set etc=
set hosts=
goto menu

:menu
mode con cols=71 lines=33
rem 系统文件检测
if not exist %windir%\system32\cacls.exe (echo 未检测到运行所需的文件！程序将马上下载！)&pause&goto sysfile
rem 解除Hosts只读属性，权限限制
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
cls
title Hosts 小工具 %ver%   %date%
echo ■───────────────────────────────── ■
echo.■   1.Hosts文件调整       2.Acrylic+ 调整        3.在线升级         ■
echo ■───────────────────────────────── ■
echo.■   4.打开Hosts文件       5.Hosts文件整理        6.IE 证书管理      ■
echo ■───────────────────────────────── ■
echo.■   7.添加IE不信任网址    8.删除IE不信任网址     9.IP 安全策略      ■
echo ■-------------------------------------------------------------------■
echo.■   0.打开Hosts目录       B.备份Hosts文件        D.删除Hosts备份    ■
echo ■-------------------------------------------------------------------■
echo.■   F.修复Hosts文件       P.设置Hosts权限        T.G+猴子荣誉榜     ■
echo ■-------------------------------------------------------------------■
echo      G.自动1  U.自动2      X.修复IE  J.工具       H.在线帮助    
echo ■───────────────────────────────── ■
echo 当前工作目录(O)：%~dp0
echo.
set all=
set /p all=请选择相应的操作，按[回车]刷新DNS和缓存：
if /i "%all%"=="a" goto add
if /i "%all%"=="b" goto hostsbak
if /i "%all%"=="c" goto clean
if /i "%all%"=="d" goto delbak
if /i "%all%"=="e" goto delit
if /i "%all%"=="f" goto fixhosts
if /i "%all%"=="g" goto dft
if /i "%all%"=="h" goto help
if /i "%all%"=="i" goto ipv6
if /i "%all%"=="j" goto othertool
if /i "%all%"=="o" goto opdp
if /i "%all%"=="p" goto Perms
if /i "%all%"=="q" goto exit
if /i "%all%"=="r" goto rd
if /i "%all%"=="s" goto site
if /i "%all%"=="t" goto thanks
if /i "%all%"=="u" goto gdft
if /i "%all%"=="w" goto hostspath
if /i "%all%"=="x" goto fixie
if /i "%all%"=="1" goto choose
if /i "%all%"=="2" goto Acrylic
if /i "%all%"=="3" goto update
if /i "%all%"=="4" goto run
if /i "%all%"=="5" goto hostsorder
if /i "%all%"=="6" goto Cert
if /i "%all%"=="7" goto addnotrustsite
if /i "%all%"=="8" goto delnotrustsite
if /i "%all%"=="9" goto IPSec
if /i "%all%"=="0" goto openhosts

:dns
echo 正在清理Dns缓存 IE缓存...
ipconfig /flushdns>nul 2>nul
del /f /s /q "%userprofile%\local Settings\temporary Internet Files\*.*">nul 2>nul
del /f /s /q "%userprofile%\local Settings\temp\*.*">nul 2>nul
del /f /s /q "%userprofile%\recent\*.*">nul 2>nul
del /f /q %userprofile%\recent\*.*>nul 2>nul
ipconfig /flushdns>nul 2>nul
goto menu

:hostsbak
echo 对原Hosts进行备份 ...
md Bakup\
copy /y %hosts% Bakup\"Hosts_%bak%.txt" >nul 2>nul
echo 备份完成
pause
goto menu

:delbak
echo 是否删除备份的Hosts文件？
Pause
del Bakup\Hosts*_*.txt /q >nul 2>nul
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
echo 127.0.0.1       localhost> %hosts%
echo ::1             localhost>> %hosts%
echo 127.0.0.1 localhost.localdomain localhost>> %hosts%
echo 还原Hosts文件为系统默认状态。
goto run

:opdp
start explorer %~dp0
goto menu

:openhosts
start explorer %etc%\
goto menu

:Perms
title 设置Hosts文件访问权限
mode con: cols=50 lines=15
echo.
echo 1,设为只读（默认回车使用）     6,不设置
echo.
echo 2,设置NTFS读取权限（防删，只读，可改名）  
echo.
echo 3,设置NTFS拒绝权限（防删，禁读，禁改名）
echo.
echo 4,取消NTFS权限控制      5,重新打开Hosts
SET Choice=
echo.
SET /P Choice=修改完成后请关闭记事本继续选择：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO readonly
IF /I '%Choice%'=='2' GOTO ntfsr
IF /I '%Choice%'=='3' GOTO ntfsno
IF /I '%Choice%'=='4' GOTO ntfsf
IF /I '%Choice%'=='5' GOTO run
IF /I '%Choice%'=='6' GOTO dns
:readonly
attrib +r +a +s %hosts%
goto pmfinish
:ntfsr
echo y| cacls %hosts% /c /t /p everyone:f >nul 2>nul
attrib +r -h +s %hosts%  >nul 2>nul
echo y| cacls %hosts% /c /t /p everyone:r >nul
goto pmfinish
:ntfsno
echo y| cacls %hosts% /c /t /p everyone:f >nul 2>nul
attrib %hosts% +r -h +s  >nul 2>nul
echo y| cacls %hosts% /D everyone >nul
goto pmfinish
:ntfsf
rem 解除Hosts只读属性，权限限制
echo y| cacls %hosts% /ci /c /t /p administrator:f >nul 2>nul
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
goto pmfinish
:pmfinish
echo.
echo Hosts文件权限设置完成！
pause
ipconfig /flushdns>nul 2>nul
goto exit

:Cert
certmgr.msc
goto menu

:help
cls
if exist Help.txt type Help.txt|more
start http://hi.baidu.com/iebb
mshta vbscript:msgbox("不建议在Hosts文件中添加过多内容！",64,"Hosts")(window.close)
goto menu

:gdft
mshta vbscript:msgbox("此模式下的数据有延迟，不推荐使用！ %b%！",64,"警告")(window.close)
if not exist down\rd.g call :datadown
cd down\ >nul 2>nul
copy /b rd.g+Site.g+Union.g+Soft.g hbhosts.txt
copy hbhosts.txt %hosts%
cd.. >nul 2>nul
goto Perms

:choose
mode con: cols=63 lines=32
del /f /s /q down\*.*>nul 2>nul
rem Wget下载组件检测
if not exist wget.exe (start /min iexplore http://users.ugent.be/~bpuype/cgi-bin/fetch.pl?dl=wget/wget.exe)& (echo 正在下载Wget组件，请保存在当前目录！)&pause&goto opdp
cls
title Hosts 数据调整
echo.
echo ○Main Data:                                               
echo.     1.推荐数据        2.IPV6数据        3.智能转向                 
echo.   
echo ☆Single Data:                                             
echo.     4.广告联盟        5.站点过滤        6.软件屏蔽        
echo.    
echo ◎Mwsl Data:                                              
echo. Cn：7.MWSL实验室             
echo.
echo. En：8.MVPS            9.SomeOneWhoCares                       
echo.   
echo ☆User Data:                                              
echo.     A.添加屏蔽/加速访问 网站            B.屏蔽自定义数据        
echo.
echo.     C.删除屏蔽网站                 
echo.       
echo   -------------------------------------------------------- 
echo  ！不建议同时重复添加使用多个！不建议在Hosts中添加过多内容！
echo   --------------------------------------------------------
echo 当前工作位置(0)：%~dp0
echo.
set all=
set /p all=请选择相应的操作，按[回车]刷新DNS和缓存：
if /i "%all%"=="1" goto dft
if /i "%all%"=="2" goto ipv6
if /i "%all%"=="3" goto rd
if /i "%all%"=="4" goto union
if /i "%all%"=="5" goto site
if /i "%all%"=="6" goto soft
if /i "%all%"=="7" goto mwslcn
if /i "%all%"=="8" goto MVPShosts
if /i "%all%"=="9" goto someonewhocares
if /i "%all%"=="a" goto add
if /i "%all%"=="b" goto myfile
if /i "%all%"=="c" goto clearadd

:dft
echo 正在连接升级服务器，请稍侯…
ping hostsx.googlecode.com>nul 2>nul&&goto :dftok
cls
echo 无法连接升级服务器！
echo.
echo 请检查网络连接或稍后再试！&pause>nul&goto menu
:dftok
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
pause&cls
copy down\HostsX.orzhosts %hosts%
goto Perms

:datadown
echo 正在下载基础数据中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/g/rd.g
%down% http://hostsx.googlecode.com/svn/trunk/g/Union.g
%down% http://hostsx.googlecode.com/svn/trunk/g/Site.g
%down% http://hostsx.googlecode.com/svn/trunk/g/Soft.g
cls&mshta vbscript:msgbox("数据下载完成，请返回重新选择",64,"Hosts")(window.close)
goto menu

:ipv6
echo 第一次安装Ipv6时请稍候...
ipv6 install>nul 2>nul
echo 正在下载基础数据中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/ipv6.txt
copy down\ipv6.txt %hosts%
goto Perms

:rd
if not exist down\rd.g call :datadown
copy down\rd.g %hosts%
goto Perms

:union
if not exist down\Union.g call :datadown
copy down\Union.g %hosts%
goto Perms

:site
if not exist down\Site.g call :datadown
copy down\Site.g %hosts%
goto Perms

:soft
if not exist down\Soft.g call :datadown
copy down\Soft.g %hosts%
call :wmpclean
goto Perms

:wmpclean
reg delete "hkcu\Software\Microsoft\MediaPlayer\Services\FaroLatino_CN" /f>nul 2>nul
reg delete "hkcu\Software\Microsoft\MediaPlayer\Subscriptions" /f>nul 2>nul
reg delete "hklm\SOFTWARE\Microsoft\MediaPlayer\services\FaroLatino_CN" /f>nul 2>nul

:mwslcn
echo 正在下载中，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/mwsl.txt
echo 下载完成，是否要使用 "恶意网站实验室" 整理的Hosts数据？
pause
copy down\mwsl.txt %hosts%
goto Perms

:MVPShosts
echo 正在下载中，请稍候... ...
%down% http://www.mvps.org/winhelp2002/hosts.txt
echo 下载完成，是否要使用 "MVPS" 整理的Hosts数据？
pause
copy down\hosts.txt %hosts%
start http://www.mvps.org/winhelp2002/hosts.htm
goto Perms

:someonewhocares
echo 正在下载中，请稍候... ...
%down% http://someonewhocares.org/hosts/hosts
echo 下载完成，是否要使用 "someonewhocares" 整理的Hosts数据？
pause
copy down\hosts %hosts%
start http://someonewhocares.org/hosts/
goto Perms

:add
set/p c=请输入主机IP地址 (如：192.11.10.69 ) 屏蔽可使用0.0.0.0或127.0.0.1
set/p cc= 请输入主机域名 (如：www.baidu.com)
echo %c% %cc%>>%hosts%
mshta vbscript:msgbox("%cc% 设置完成！",64,"Hosts")(window.close)
goto dns

:clearadd
echo 如 要取消屏蔽百度，则输入：www.baidu.com
set /p b=请输入要取消屏蔽的网站:
findstr /i "\<%b%\>"<%hosts%||(cls&echo/&echo ***没有找到您输入的网站地址***&pause&goto choose)
findstr /vi "\<%b%\>"<%hosts% >host
del %hosts%
copy host %hosts%
mshta vbscript:msgbox("已经取消屏蔽 %b%！",64,"Hosts")(window.close)
goto dns

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
goto Perms

:Acrylic
mode con: cols=39 lines=25
if not exist Acrylic\ goto :Alcerr
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
IF /I '%Choice%'=='1' GOTO Alcflush
IF /I '%Choice%'=='2' GOTO Alcedit
IF /I '%Choice%'=='3' GOTO AlcStup
IF /I '%Choice%'=='4' GOTO Alcup
IF /I '%Choice%'=='5' GOTO Alcunist
IF /I '%Choice%'=='d' GOTO Alcdel
IF /I '%Choice%'=='0' GOTO menu
:Alcflush
cd Acrylic\ >nul 2>nul
echo    ==================================
ECHO      刷新 Acrylic 和 系统DNS 缓存...
DEL /F AcrylicCache.dat > NUL 2> NUL
IPCONFIG /FlushDNS > NUL 2> NUL
echo    ==================================
cd..
goto Alcs
:AlcStup
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在安装 Acrylic DNS Proxy 服务...
AcrylicService.exe /INSTALL /SILENT > NUL 2> NUL
echo    ==================================
pause
ipconfig /all >1.txt
start %windir%\notepad.exe %~dp0\1.txt
start %windir%\notepad.exe %~dp0\AcrylicConfiguration.ini
echo 把DNS Servers 后面的那个 IP地址填到 PrimaryServerAddress=后面；
echo 修改你的本地连接里面的 DNS 地址为：127.0.0.1；
pause
cd..
goto Alcs
:Alcedit
cd Acrylic\ >nul 2>nul
start %windir%\notepad.exe AcrylicHosts.txt
pause
echo 修改完毕后关闭记事本，按任意键继续！
pause>nul
cd..
goto Alcflush
:Alcup
echo    ==================================
echo      正在更新 Acrylic Hosts 文件 ...
echo    ==================================
del Acrylic\*.txt >nul
%downa% http://hostsx.googlecode.com/svn/trunk/AcrylicHosts.txt
echo AcrylicHosts数据已更新！
pause
goto Alcflush
:Alcunist
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在卸载 Acrylic DNS Proxy 服务...
AcrylicService.exe /UNINSTALL /SILENT
echo    ==================================
cd ..
goto Acrylic
:Alcdel
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
echo Acrylic卸载完毕！
pause
goto menu
:Alcs
cd Acrylic\ >nul 2>nul
echo    ==================================
echo    正在启动 Acrylic DNS Proxy 服务...
NET START "Acrylic DNS Proxy Service" > NUL
echo    ==================================
cd ..
goto menu
:Alcerr
echo.
echo  Acrylic文件丢失，无法继续使用该服务！
echo  请重新安装Acrylic组件！
echo  按任意键重新下载……
pause>nul
goto Alcfile
:Alcfile
%downa% http://hostsx.googlecode.com/svn/trunk/lib/AcrylicLookup.exe
%downa% http://hostsx.googlecode.com/svn/trunk/lib/AcrylicService.exe
%downa% http://hostsx.googlecode.com/svn/trunk/lib/AcrylicConfiguration.ini
echo 正在下载组件，请稍候... ...
pause
if exist Acrylic\AcrylicService.exe goto menu

:update
mode con: cols=40 lines=10
title HostsTool更新程序
echo 正在连接升级服务器，请稍侯…
ping hostsx.googlecode.com>nul 2>nul&&goto :updateok
cls
echo 无法连接升级服务器！
echo.
echo 请检查网络连接或稍后再试！&pause>nul&goto menu
:updateok
if not exist wget.exe (echo Wget组件不存在，请重新运行本程序！)&pause&exit
echo 正在下载数据，请稍候... ...
%down% http://hostsx.googlecode.com/svn/trunk/lib/ipseccmd.exe
%down% http://hostsx.googlecode.com/svn/trunk/lib/wget.exe
%down% http://hostsx.googlecode.com/svn/trunk/g/up.bat
%down% http://hostsx.googlecode.com/svn/trunk/g/HostsTool.bat
call down\up.bat&exit

:run
rem 解除Hosts只读属性，权限限制
echo y|cacls %hosts% /g everyone:f >nul
attrib -r -a -s -h %hosts%
if not exist %hosts% (call :nohosts) else (start %windir%\notepad.exe %hosts%)
goto Perms

:hostsorder
title Hosts文件整理
mode con: cols=50 lines=15
echo 1,删除域名后的#号注释
echo 2,仅删除重复内容
echo 3,删除#号注释并删除重复内容
echo 此功能可能会有些问题。不推荐使用！
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

:thanks
%down% http://hostsx.googlecode.com/svn/trunk/g/Thanks.txt
type down\Thanks.txt|more
pause
goto menu

:addnotrustsite
echo 以下数据，供您参考：
echo 11.mydrivers.com>1.txt
echo adcontrol.tudou.com>>1.txt
echo gimg.iqilu.com>>1.txt
echo images.sohu.com>>1.txt
echo pro.letv.com>>1.txt
echo *.atm.youku.com>>1.txt
echo *.mediav.com>>1.txt
echo *.sandai.net>>1.txt
start %windir%\notepad.exe 1.txt
mshta vbscript:msgbox("请如下所示： 一行一个网站域名！",64,"Hosts")(window.close)
echo 请在修改完毕后关闭记事本，并继续下一步。
echo 请注意备份 自定义.txt 中的的数据！！！
echo 确定要使用自定义的IE不信任网址数据？
pause
echo       正在添加恶意网址到浏览器非安全区域。
echo       这个过程需要几分钟，请稍候……
set DMAIN=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains
for /F %%a in (1.txt) do reg add "%DMAIN%\%%a" /v * /t REG_DWORD /d 0x00000004 /f >nul
echo       添加完毕……
pause
goto menu

:delnotrustsite
echo  是否要清理IE浏览器非安全区域的所有网址！
pause
reg delete "hkcu\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains" /f >nul 2>nul
goto menu

:IPSec
mode con: cols=55 lines=18
echo IP 安全策略（可以用来封IP和端口！）
pause
sc create PolicyAgent binpath= "C:\WINDOWS\system32\lsass.exe" type= share start= auto displayname= "IPSEC Services" depend= RPCSS/IPSec
sc description PolicyAgent "提供 TCP/IP 网络上客户端和服务器之间端对端的安全。如果此服务被停用，网络上客户端和服务器之间的 TCP/IP 安全将不稳定。如果此服务被禁用，任何依赖它的服务将无法启动。"
if not exist ipseccmd.exe (echo 您的系统精简过度，运行所需系统文件缺失！程序将马上下载！)&pause&wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/lib/ipseccmd.exe
echo 正在下载中，请稍候... ...
wget -nH -N -c http://hostsx.googlecode.com/svn/trunk/g/ipblock.txt
echo 你可以手动编辑，然后按提示继续&start %windir%\notepad.exe ipblock.txt&echo 是否要使用IP安全策略？&pause
ipseccmd -w reg -p ipsce -y
FOR /f "skip=1 delims= " %%i IN (ipblock.txt) DO call set list=%%list%% %%i
ipseccmd -w reg -p ipsec:1 -r filterlist -f %list% -n BLOCK -x >nul
ipseccmd  -w REG -p "ipsec" -x >nul
gpupdate >nul
pause
goto menu

:sysfile
wget -nH -N -c -t 10 -w 2 -q http://hostsx.googlecode.com/svn/trunk/lib/cacls.exe
if not exist cacls.exe goto sysfile&pause&goto menu

:hostspath
echo 如果HostsTool未能正确获取路径，请切换到程序所在目录。
echo 正在获取系统Hosts路径
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DataBasePath" ^|findstr /i "DataBasePath"') do (set "DataBasePath=%%b")
echo 当前系统的Hosts路径为：>hostspath.txt
echo %DataBasePath%>>hostspath.txt
echo 替换下面的set hosts=右面的内容。>>hostspath.txt
pause
start %windir%\notepad.exe %0
start %windir%\notepad.exe %~dp0\hostspath.txt
exit

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
echo. 清理腾讯产生的垃圾文件。
del /f /s /q "%userprofile%\Application Data\QQMusicUpdate\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\DeskUpdate\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\File\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\IM\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\Logs\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\MMInstallCache\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\AuTemp\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\DR\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\SafeBase\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\STemp\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQ\Temp\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQDownload\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQMusic\Cache\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\QQMusic\Temp\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\TM\SafeBase\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\TM\Temp\*.*"
del /f /s /q "%userprofile%\Application Data\Tencent\TXSSO\*.*"
del /f /s /q "%userprofile%\Local Settings\Application Data\Tencent\*.*"
rd /s /q "%userprofile%\Application Data\QQMusicUpdate"
rd /s /q "%userprofile%\Application Data\Tencent\DeskUpdate"
rd /s /q "%userprofile%\Application Data\Tencent\File"
rd /s /q "%userprofile%\Application Data\Tencent\IM"
rd /s /q "%userprofile%\Application Data\Tencent\Logs"
rd /s /q "%userprofile%\Application Data\Tencent\MMInstallCache"
rd /s /q "%userprofile%\Application Data\Tencent\QQ"
rd /s /q "%userprofile%\Application Data\Tencent\QQ\AuTemp"
rd /s /q "%userprofile%\Application Data\Tencent\QQ\DR"
rd /s /q "%userprofile%\Application Data\Tencent\QQ\SafeBase"
rd /s /q "%userprofile%\Application Data\Tencent\QQ\STemp"
rd /s /q "%userprofile%\Application Data\Tencent\QQ\Temp"
rd /s /q "%userprofile%\Application Data\Tencent\QQDownload"
rd /s /q "%userprofile%\Application Data\Tencent\QQMusic\Cache"
rd /s /q "%userprofile%\Application Data\Tencent\QQMusic\Temp"
rd /s /q "%userprofile%\Application Data\Tencent\TM\SafeBase"
rd /s /q "%userprofile%\Application Data\Tencent\TM\Temp"
rd /s /q "%userprofile%\Application Data\Tencent\TXSSO"
rd /s /q "%userprofile%\Local Settings\Application Data\Tencent"
del /f /s /q "D:\QQVideo.Cache\*.*"
del /f /s /q "e:\QQVideo.Cache\*.*"
echo. 清理用户使用产的垃圾文件。
del /f /s /q "%AllUsersProfile%\Application Data\360safe\*.*"
del /f /s /q "%AllUsersProfile%\Application Data\keniuTools\*.*"
del /f /s /q "%AllUsersProfile%\Application Data\Windows Genuine Advantage\*.*"
del /f /s /q "%ProgramFiles%\Kingsoft\*.*"
del /f /s /q "%userprofile%\Application Data\$Inst$\*.*"
del /f /s /q "%userprofile%\Application Data\360Safe\*.*"
del /f /s /q "%userprofile%\Application Data\Adobe\Flash Player\*.*"
del /f /s /q "%userprofile%\Application Data\AppData\*.*"
del /f /s /q "%userprofile%\Application Data\BITS\*.*"
del /f /s /q "%userprofile%\Application Data\data\*.*"
del /f /s /q "%userprofile%\Application Data\fix.reg"
del /f /s /q "%userprofile%\Application Data\Foxit Software\*.*"
del /f /s /q "%userprofile%\Application Data\Help\*.*"
del /f /s /q "%userprofile%\Application Data\IDMComp\*.*"
del /f /s /q "%userprofile%\Application Data\Internet Cleaner\*.*"
del /f /s /q "%userprofile%\Application Data\kplugeng.dll"
del /f /s /q "%userprofile%\Application Data\kplugext.dll"
del /f /s /q "%userprofile%\Application Data\Macromedia\*.*"
del /f /s /q "%userprofile%\Application Data\Maxthon3\Temp\*.*"
del /f /s /q "%userprofile%\Application Data\Media Player Classic\*.*"
del /f /s /q "%userprofile%\Application Data\U3\*.*"
del /f /s /q "%userprofile%\Application Data\udconf.ini"
del /f /s /q "%userprofile%\Application Data\umcfg.ini"
del /f /s /q "%userprofile%\Local Settings\Application Data\Help\*.*"
del /f /s /q "%userprofile%\Local Settings\Application Data\Xequte\*.*"
rd /s /q "%AllUsersProfile%\Application Data\360safe"
rd /s /q "%AllUsersProfile%\Application Data\keniuTools"
rd /s /q "%AllUsersProfile%\Application Data\Kingsoft"
rd /s /q "%AllUsersProfile%\Application Data\Windows Genuine Advantage"
rd /s /q "%ProgramFiles%\Kingsoft\"
rd /s /q "%userprofile%\Application Data\$Inst$"
rd /s /q "%userprofile%\Application Data\360Safe"
rd /s /q "%userprofile%\Application Data\ACD Systems"
rd /s /q "%userprofile%\Application Data\Adobe\Flash Player"
rd /s /q "%userprofile%\Application Data\AppData"
rd /s /q "%userprofile%\Application Data\BITS"
rd /s /q "%userprofile%\Application Data\data"
rd /s /q "%userprofile%\Application Data\Foxit Software"
rd /s /q "%userprofile%\Application Data\Help"
rd /s /q "%userprofile%\Application Data\IDMComp"
rd /s /q "%userprofile%\Application Data\Internet Cleaner"
rd /s /q "%userprofile%\Application Data\Macromedia"
rd /s /q "%userprofile%\Application Data\Maxthon3\Temp"
rd /s /q "%userprofile%\Application Data\Media Player Classic"
rd /s /q "%userprofile%\Application Data\U3"
rd /s /q "%userprofile%\Local Settings\Application Data\Help"
rd /s /q "%userprofile%\Local Settings\Application Data\Xequte"
cls
goto menu

:delit
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
goto delit

:fixie
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
mode con cols=72 lines=32
title IE常规修复
echo.
echo     修复前，请关闭所有浏览器及其他应用程序窗口！
pause
taskkill /F /IM iexplore.exe /T>nul 2>nul
echo        开始修复 IE 及相关的系统设置项目……
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableRegistryTools /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableRegistryTools /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\CLASSES\.reg" /f /ve /d regfile>nul 2>nul
echo        恢复EXE文件打开方式
reg add "HKCR\exefile\shell\open\command" /f /ve /t REG_SZ /d ""%1" %*">nul 2>nul
echo        删除地址栏下拉菜单内的网址
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\TypedURLs">nul 2>nul
echo        还原桌面,我的电脑里面的右键菜单
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoViewContextMenu /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoViewContextMenu /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复被隐藏的桌面图标
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDesktop>nul 2>nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDesktop>nul 2>nul
echo        恢复被隐藏的控制面板
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetFolders>nul 2>nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetFolders>nul 2>nul
echo        恢复IE工具栏的链接名称
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /f /v LinksFolderName /d "链接">nul 2>nul
echo        恢复internet选项安全页面自定义按钮
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v SecChangeSettings /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复IE浏览器缺省主页的设置锁定状态
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v Settings /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v Links /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v SecAddSites /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v homepage /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复被隐藏的分区
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDrives /t REG_DWORD /d 00000000>nul 2>nul
echo        删除分级审查密码
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ratings" /f>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Ratings">nul 2>nul
echo        允许下载
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /f /v 1803 /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /f /v NoSelectDownloadDir /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Restrictions" /f /v NoSelectDownloadDir /t REG_DWORD /d 00000000>nul 2>nul
echo        修复文件属性里面的广告
reg add "HKCU\Control Panel\International" /f /v sLongDate /d "yyyy'年'M'月'd'日">nul 2>nul
echo        恢复internet选项
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\restrictions" /f /v NoBrowserOptions /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoFolderOptions /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v GeneralTab /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v SecurityTab /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v ContentTab /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v ConnectionsTab /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v ProgramsTab /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v AdvancedTab /t REG_DWORD /d 00000000>nul 2>nul
echo        修复IE察看源文件按钮
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /f /v NoViewSource /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Restrictions" /f /v NoViewSource /t REG_DWORD /d 00000000>nul 2>nul
echo        修复网页中右键菜单的广告
reg delete "HKCU\Software\Microsoft\Internet Explorer\MenuExt" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\MenuExt" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Internet Explorer\MenuExt2" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\MenuExt2" /f>nul 2>nul
echo        修复开始菜单的运行等项目
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoRun /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoRun /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoClose /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoClose /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDrives /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoLogOff /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoLogOff /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDesktop /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoDesktop /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetFolders /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetFolders /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetTaskBar /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoSetTaskBar /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoFileMenu /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoFileMenu /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\WinOldApp" /f /v NoRealMode /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WinOldApp" /f /v NoRealMode /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\WinOldApp" /f /v Disabled /t REG_DWORD /d 00000000>nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WinOldApp" /f /v Disabled /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复一系列文件名
reg add "HKCR\CLSID\{BDEADF00-C265-11d0-BCED-00A0C90AB50F}" /f /ve /d "Web 文件夹">nul 2>nul
reg add "HKCR\CLSID\{BDEADF00-C265-11d0-BCED-00A0C90AB50F}" /f /v InfoTip /d "您可以创建快捷方式，使它们指向您公司 Intranet 或万维网上的 Web 文件夹。要将文档发布到 Web 文件夹中或要管理文件夹中的文件，请单击该文件夹的快捷方式。">nul 2>nul
reg add "HKCR\CLSID\{992CFFA0-F557-101A-88EC-00DD010CCC48}" /f /ve /d "拨号网络">nul 2>nul
reg add "HKCR\CLSID\{992CFFA0-F557-101A-88EC-00DD010CCC48}" /f /v InfoTip /d "即使计算机不在网络上,仍可以使用拨号网络来访问另一计算机上的共享信息。要使用共享资源，拨入的计算机必须设为网络服务器。">nul 2>nul
reg add "HKCR\CLSID\{2227A280-3AEA-1069-A2DE-08002B30309D}" /f /ve /d "打印机">nul 2>nul
reg add "HKCR\CLSID\{2227A280-3AEA-1069-A2DE-08002B30309D}" /f /v InfoTip /d "使用打印机文件夹添加并安装本地或网络打印机，或更改现有打印机的设置。">nul 2>nul
reg add "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /f /ve /d "回收站">nul 2>nul
reg add "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /f /v InfoTip /d "包含可以恢复或永久删除的已删除项目。">nul 2>nul
reg add "HKCR\CLSID\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}" /f /ve /d "计划任务">nul 2>nul
reg add "HKCR\CLSID\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}" /f /v InfoTip /d "使用“任务计划”安排重复的任务，如磁盘碎片整理或例程报告等在您最方便的时候运行。“任务计划”每次在启动 Windows 时启动并在后台运行，因此例程任务不会影响您的工作。">nul 2>nul
reg add "HKCR\CLSID\{21EC2020-3AEA-1069-A2DD-08002B30309D}" /f /ve /d "控制面版">nul 2>nul
reg add "HKCR\CLSID\{21EC2020-3AEA-1069-A2DD-08002B30309D}" /f /v InfoTip /d "使用“控制面板”个性化您的计算机。例如，您可以指定桌面的显示(“显示”图标)、事件的声音(“声音”图标)、音频音量的大小(“多媒体”图标)和其它内容。">nul 2>nul
reg add "HKCR\CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}" /f /ve /d "Internet Explorer">nul 2>nul
reg add "HKCR\CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}" /f /v InfoTip /d "显示 WWW 或您所在公司 Intranet 上的网页，或者将您连接到 Internet。">nul 2>nul
echo        恢复网页右键菜单
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /f /v NoBrowserContextMenu /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复OE标题栏广告
reg add "HKCU\Software\Microsoft\Outlook Express" /f /v WindowTitle /t REG_DWORD /d 00000000>nul 2>nul
echo        恢复时间显示样式
reg add "HKEY_CURRENT_USER\Control Panel\International" /f /v sLongDate /d "yyyy'年'M'月'd'日'">nul 2>nul
reg add "HKEY_CURRENT_USER\Control Panel\International" /f /v sLongDate16 /d "dddd', 'MMMM' 'dd', 'yyyy">nul 2>nul
reg add "HKEY_CURRENT_USER\Control Panel\International" /f /v s1159 /d "上午">nul 2>nul
reg add "HKEY_CURRENT_USER\Control Panel\International" /f /v s2359 /d "下午">nul 2>nul
reg add "HKEY_CURRENT_USER\Control Panel\International" /f /v sShortDate /d "yyyy-M-d">nul 2>nul
echo        恢复IE标题栏
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Window Title" /d "Microsoft Internet Explorer">nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "Window Title" /d "Microsoft Internet Explorer">nul 2>nul
echo        恢复主页修改
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /f /v homepage /t REG_DWORD /d 00000000>nul 2>nul
echo        取消开机对话框
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Winlogon" /f /v LegalNoticeCaption /d "">nul 2>nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Winlogon" /f /v LegalNoticeText /d "">nul 2>nul
echo        解开注册表
echo        修复IE的默认页面和起始为空白页
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "Default_Page_URL" /d "about:blank">nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "Start Page" /d "about:blank">nul 2>nul
echo        恢复IE搜索引擎
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /f /v "SearchUrl" /d "https://www.google.com/keyword/%s">nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Bar" /d "http://www.google.com/ie" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /d "no" /f>nul 2>nul
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchURL" /v "provider" /d "gogl" /f>nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\" /f /ve /d "about:blank">nul 2>nul
reg add "HKLM\Software\Microsoft\Internet Explorer\Main" /f /v "Search Page" /d "http://www.google.com/intl/zh-CN/">nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /v "SearchAssistant" /d "https://www.google.com/ie" /f>nul 2>nul
echo        修复IE工具栏广告
reg delete "HKLM\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
reg delete "HKCU\Software\Microsoft\Internet Explorer\Extensions" /f>nul 2>nul
echo        修复开始菜单广告
reg delete "HKCR\CLSID\{2559a1f6-21d7-11d4-bdaf-00c04f60b9f0}\Instance\InitPropertyBag" /f>nul 2>nul
echo        修复XP系统验证码显示异常
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Security" /f /v BlockXBM /t REG_DWORD /d 00000000>nul 2>nul
echo        修复完毕！
cls       
goto menu

:othertool
mode con: cols=39 lines=25
echo    ==================================
echo            其他相关工具选项
echo    ==================================
echo        1. 安装Ipv6协议支持
echo.
echo        2. 禁用DNS client服务
echo.
echo        3. 设置IPv6相关支持
echo.
echo        4. 卸载Ipv6协议
echo.
echo        5. DNS client服务改为手动
echo.
echo        6. 安装Simple-adblock IE插件
echo.
echo        7. 卸载Simple-adblock IE插件
echo.
echo        D. 替换shdoclc.dll文件
echo    ==================================
echo.
SET Choice=
SET /P Choice=请选择，输入[0]返回：
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%
IF /I '%Choice%'=='1' GOTO setupipv6
IF /I '%Choice%'=='2' GOTO dnscachedis
IF /I '%Choice%'=='3' GOTO ipv6srv
IF /I '%Choice%'=='4' GOTO ipv6un
IF /I '%Choice%'=='5' GOTO dnscachede
IF /I '%Choice%'=='6' GOTO setsadblock
IF /I '%Choice%'=='7' GOTO uniadblock
IF /I '%Choice%'=='d' GOTO thshdoclc
IF /I '%Choice%'=='0' GOTO menu

:setupipv6
echo 安装Ipv6协议支持,以使Ipv6可用！
ping teredo.remlab.net >nul 2>nul && goto ipv6install &echo 第一次安装Ipv6时请稍候... || echo. & echo 网络环境也许不能安装，但你可以安装试试 & echo. & SET /P installyn=  是否继续安装，如果继续安装按y回车继续，如果不安装按n回车返回主菜单:
if /I "%i6%"=="y" goto ipv6install
if /I "%i6%"=="n" goto othertool

:dnscachedis
echo 关闭DNS client服务，以加快DNS解析速度;
net stop DNSCache
sc stop DNSCache
sc config Dnscache start= disabled
goto othertool

:ipv6srv
netsh interface ipv6 6to4 set state disabled
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 34567
goto othertool

:ipv6un
ipv6 uninstall
goto othertool

:dnscachede
sc config DNSCache start= demand
sc stop DNSCache

:thshdoclc
taskkill /F /IM iexplore.exe /T>nul 2>nul
taskkill /f /im Explorer.exe
cd /d .\
if exist "shdoclc.dll" goto shdoclc
Echo "没有找到当前目录下的 shdoclc.dll，无法替换！"
echo 正在在线下载...
wget -nH -N -c -t 10 -w 2 -q http://hostsx.googlecode.com/svn/trunk/lib/shdoclc.dll
if not exist shdoclc.dll &pause&goto othertool
:shdoclc
Echo ****************************************
Echo  替换系统文件为当前目录下的shdoclc.dll
Echo ****************************************
Echo 要退出请直接关闭本窗口！
pause
if NOT exist "%SystemRoot%\shdoclc.dll" Echo "没有找到系统文件！"&pause
Echo 找到系统文件，备份到 BackUp 子文件夹中！
if NOT exist ".\BackUp\" md ".\BackUp\"
if exist ".\BackUp\shdoclc.dll" echo 备份文件已经存在 BackUp 中，是否替换？
xcopy "%SystemRoot%\shdoclc.dll" ".\BackUp\"
goto begincopy
:begincopy
if NOT exist "%SystemRoot%\shdoclc.dll" goto SystemRoot
echo 确认替换文件：
:SystemRoot
xcopy shdoclc.dll "%SystemRoot%\system32\"
xcopy shdoclc.dll "%SystemRoot%\system32\dllcache\"
Echo 替换完成！
pause
start Explorer.exe
goto othertool

:setsadblock
if not exist Adblock.dll (echo 未找到Adblock.dll，按任意键下载安装！)&pause
wget -nH -N -c -t 10 -w 2 -q http://hostsx.googlecode.com/svn/trunk/lib/Adblock.dll
wget -nH -N -c -t 10 -w 2 -q http://hostsx.googlecode.com/svn/trunk/lib/AdblockSet.exe
AdblockSet.exe
regsvr32 /s Adblock.dll
del /q AdblockSet.exe
mshta vbscript:msgbox("安装成功！",64,"Simple-adblock")(window.close)
goto othertool

:uniadblock
del /q "%UserProfile%\Application Data\Simple Adblock\*.*"
rd "%UserProfile%\Application Data\Simple Adblock\" /S /Q
regsvr32 /u /s Adblock.dll
mshta vbscript:msgbox("卸载成功！",64,"Simple-adblock")(window.close)
goto othertool
