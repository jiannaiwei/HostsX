@echo off
pushd %~dp0
color 0a
path %windir%\system32
if exist %windir%\system32\mode.com mode con cols=60 lines=25
ConsExt /crv 0
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
set RegOwnr=-ot reg -actn setowner -ownr "n:everyone" -rec yes
set RegFull=-ot reg -actn ace -ace "n:Everyone;p:full;i:so,sc;m:set" -rec yes
set regfile=usbclear.reg
set logfile=usbclear.log
set txtfile=usbclear.txt
set tmpregfile=%temp%\ucreg.tmp
set tmpregkey=%temp%\uckey.tmp
set mode=disp
set force=0
set progname=USBClear v1.0.5 Beta by X
:start
title %progname% - U盘记录清理工具
cls
echo.
echo   鼠标点击【 】内选择操作
echo   =======================================================
echo.
echo            【 1.更新Hosts文件   】
echo.
echo            【 2.清理本机U盘相关注册表项   】
echo.
echo            【 3.导出U盘记录注册表备份文件 】
echo.
echo   =======================================================
echo   本工具特点： 1. 完整清理注册表内所有与U盘相关的各种记录
echo                2. 精准清理U盘相关记录，不影响其他USB设备
echo                3. 可强制清理可能与U盘相关的冗余驱动记录
echo   =======================================================
echo   警告：安全清理模式只清除所有已知U盘的驱动记录，切换至强
echo         制清理模式后，可以清理所有可能与U盘相关的冗余驱动
echo         记录，但可能有删错驱动的风险。
echo   =======================================================
echo.
if /i !force! neq 0 (echo   当前模式：强制清理模式) else (echo   当前模式：安全清理模式)
echo.
echo            【 切换模式 】     【  退  出  】
:mouse1
ConsExt /event
set /a xy=%errorlevel%
if %xy% lss 1001 goto mouse1
set /a X=%xy:~0,-3%
set /a Y=%xy%-1000*%X%
if %y% equ 4 if %x% gtr  12 if %x% lss 44 set mode=disp&&goto progress
if %y% equ 6 if %x% gtr  12 if %x% lss 44 set mode=del&&goto progress
if %y% equ 8 if %x% gtr  12 if %x% lss 44 set mode=reg&&goto progress
if %y% equ 22 if %x% gtr  12 if %x% lss 25 (
  if /i !force! neq 0 (set force=0) else (set force=1)
  goto start
)
if %y% equ 22 if %x% gtr  31 if %x% lss 44 goto :eof
goto mouse1

:progress
cls
title %progname% - 搜索中...
if exist %tmpregkey% del %tmpregkey% /s /q>nul
echo.>%tmpregkey%
if /i !mode! equ reg (
  if exist %regfile% del %regfile% /s /q>nul
  echo Windows Registry Editor Version 5.00>%regfile%
  echo 正在导出本机U盘相关注册表备份文件%regfile%,请稍后...
)
if /i !mode! equ disp (
  if exist %txtfile% del %txtfile% /s /q>nul
  echo 正在生成U盘相关注册表项文件%txtfile%,请稍后...
  echo 本机U盘相关的注册表项为：>%txtfile%
)
if /i !mode! equ del (
  if exist %logfile% del %logfile% /s /q>nul
  echo ;日志时间：%DATE% %TIME%>%logfile%
  if exist %windir%\setupapi.log del %windir%\setupapi.log /s /q>nul
  echo 即将清理注册表内的U盘相关项，请确认所有U盘都已经拔出USB口！
  echo.
  echo 任意位置点击鼠标继续...
  ConsExt /event
  cls
  echo 正在清理，请稍后...
)
echo 当前进度：
for /f "eol=! tokens=*" %%z in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM" 2^>nul ^|find /i "HKEY_LOCAL_MACHINE\SYSTEM\Controlset" 2^>nul') do (
  set syspf=%%z
  echo + 配置:!syspf!：
  rem USB大容量存储设备“usbstor”驱动痕迹
  echo  - USB大容量存储设备“usbstor”驱动痕迹
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\USB"  2^>nul ^|find /i "!syspf!\Enum\USB\VID" 2^>nul') do (
    set udevid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udevid!" /s 2^>nul ^|find /i "Service" 2^>nul') do (
      set sname=%%b
      if /i !sname! equ Service (
        set stype=%%c
        if /i !stype! equ USBSTOR (
          for /f "eol=! tokens=1,3" %%d in ('reg query "!udevid!" /s  2^>nul ^|find /i "Driver" 2^>nul') do (
            set dname=%%d
            if /i !dname! equ Driver call :regkeymode "!syspf!\Control\Class\%%e"
          )
          call :regkeymode "%%a"
        )
      )
    )
  )
  if /i !force! neq 0 (
    rem 冗余USB大容量存储设备“usbstor”驱动痕迹
    echo  - 冗余USB大容量存储设备“usbstor”驱动痕迹
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}"  2^>nul ^|find /i "!syspf!\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\USB" /s 2>nul|find /i /c "{36FC9E60-C465-11CF-8056-444553540000}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\PCI" /s 2>nul|find /i /c "{36FC9E60-C465-11CF-8056-444553540000}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem USB磁盘“disk”驱动痕迹
  echo  - USB磁盘“disk”驱动痕迹
  for /f "eol=! tokens=1,3" %%a in ('reg query "!syspf!\Enum\USBSTOR" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
    set usbdname=%%a
    if /i !usbdname! equ Driver call :regkeymode "!syspf!\Control\Class\%%b"
  )
  if /i !force! neq 0 (
    rem 冗余USB磁盘“disk”驱动痕迹
    echo  - 冗余USB磁盘“disk”驱动痕迹
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{4D36E967-E325-11CE-BFC1-08002BE10318}"  2^>nul ^|find /i "!syspf!\Control\Class\{4D36E967-E325-11CE-BFC1-08002BE10318}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\IDE" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\SCSI" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\USBSTOR" /s 2>nul|find /i /c "{4D36E967-E325-11CE-BFC1-08002BE10318}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem USBSTOR设备痕迹
  echo  - USBSTOR设备痕迹
  call :regkeymode "!syspf!\Enum\USBSTOR"

  rem USB通用卷“volume”驱动痕迹
  echo  - USB通用卷“volume”驱动痕迹
  for /f "eol=! tokens=1,3" %%a in ('reg query "!syspf!\Enum\STORAGE\RemovableMedia" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
    set usbvname=%%a
    if /i !usbvname! equ Driver call :regkeymode "!syspf!\Control\Class\%%b"
  )
  if /i !force! neq 0 (
    rem 冗余USB通用卷“volume”驱动痕迹
    echo  - 冗余USB通用卷“volume”驱动痕迹
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{71A27CDD-812A-11D0-BEC7-08002BE2092F}"  2^>nul ^|find /i "!syspf!\Control\Class\{71A27CDD-812A-11D0-BEC7-08002BE2092F}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\STORAGE\RemovableMedia" /s 2>nul |find /i /c "{71A27CDD-812A-11D0-BEC7-08002BE2092F}\!last4!" >nul 2>nul && set usedflag=1
        reg query "!syspf!\Enum\STORAGE\Volume" /s 2>nul |find /i /c "{71A27CDD-812A-11D0-BEC7-08002BE2092F}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  rem RemovableMedia设备痕迹
  echo  - RemovableMedia设备痕迹
  call :regkeymode "!syspf!\Enum\STORAGE\RemovableMedia"

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\STORAGE\Volume" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    set volid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!volid!" /s 2^>nul ^|find /i "Driver" 2^>nul') do (
      set usbdname=%%b
      if /i !usbdname! equ Driver call :regkeymode "!syspf!\Control\Class\%%c"
    )
    call :regkeymode "%%a"
  )
  rem Deviceclasses设备痕迹
  echo  - Deviceclasses设备痕迹
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f56307-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f56308-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630a-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    call :regkeymode "%%a"
  )

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630a-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "STORAGE#RemovableMedia#" 2^>nul') do (
    call :regkeymode "%%a"
  )
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}" 2^>nul ^|find /i "STORAGE#RemovableMedia#" 2^>nul') do (
    call :regkeymode "%%a"
  )

  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\DeviceClasses\{a5dcbf10-6530-11d2-901f-00c04fb951ed}" 2^>nul ^|find /i "USB#" 2^>nul') do (
    set udcid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udcid!" /s 2^>nul ^|find /i "DeviceInstance" 2^>nul') do (
      set diname=%%b
      if /i diname equ DeviceInstance (
        set udenum=!syspf!\Enum\%%c
        for /f "eol=! tokens=1,3" %%d in ('reg query "!udenum!" /s  2^>nul ^|find /i "Service" 2^>nul') do (
          set sname=%%d
          if /i !sname! equ Service (
            set stype=%%e
            if /i !stype! equ USBSTOR call :regkeymode "%%a"
          )
        )
      )
    )
  )
  rem UMB设备与痕迹
  echo  - UMB设备与痕迹
  for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Enum\WpdBusEnumRoot\UMB" 2^>nul ^|find /i "USBSTOR#" 2^>nul') do (
    set udevid=%%a
    for /f "eol=! tokens=1,3" %%b in ('reg query "!udevid!" /s  2^>nul ^|find /i "Driver" 2^>nul') do (
      set dname=%%b
      if /i !dname! equ Driver call :regkeymode "!syspf!\Control\Class\%%c"
    )
    call :regkeymode "%%a"
  )
  if /i !force! neq 0 (
    rem 冗余UMB设备与驱动痕迹
    echo  - 冗余UMB设备与驱动痕迹
    for /f "eol=! tokens=*" %%a in ('reg query "!syspf!\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}"  2^>nul ^|find /i "!syspf!\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}\" 2^>nul') do (
      set usbdrvid=%%a
      set last4=!usbdrvid:~-4!
      set spsym=!usbdrvid:~-5,1!
      set usedflag=0
      if /i !spsym! equ \ (
        reg query "!syspf!\Enum\WpdBusEnumRoot\UMB" /s 2>nul |find /i /c "{EEC5AD98-8080-425F-922A-DABF3DE3F69A}\!last4!" >nul 2>nul && set usedflag=1
        if /i !usedflag! equ 0 call :regkeymode "%%a"
      )
    )
  )
  
  rem USBSTOR服务痕迹
  echo  - USBSTOR服务痕迹
  call :regkeymode "!syspf!\Services\USBSTOR\Enum"
  rem UsbFlags痕迹
  echo  - UsbFlags痕迹
  call :regkeymode "!syspf!\Control\UsbFlags"
)
echo + 所有用户：
rem 挂载点“MountPoints”痕迹
echo  - 挂载点“MountPoints”痕迹
for /f "eol=! tokens=1,3" %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices" 2^>nul') do (
  set findf=0
  set mnreg=%%b
  set first8=!mnreg:~0,8!
  set first64=!mnreg:~0,64!
  if /i !first64! equ 5C003F003F005C00530054004F0052004100470045002300520065006D006F00 set findf=1
  if /i !first64! equ 5C003F003F005C00550053004200530054004F00520023004300640052006F00 set findf=1
  if /i !first8! equ 5f003f00 set findf=1
  if /i !findf! equ 1 (
    set udmn=%%a
    if /i !udmn:~-1! equ : (
      set udmn=!udmn:~-2,1!
    ) else (
      set udmn=!udmn:~-38!
    )
    call :regvalmode "HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices" "%%a"
    for /f "eol=! tokens=*" %%c in ('reg query "HKEY_USERS" 2^>nul ^|find /i /v "_Classes" 2^>nul') do (
      call :regkeymode "%%c\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\!udmn!"
    )
  )
)
:done
title %progname% - 完成
if /i !mode! equ reg (
  echo 导出%regfile%完毕！
  echo TIPS：你可以使用记事本的另存为功能将其保存到其他位置
  start notepad %regfile%
)
if /i !mode! equ disp (
  echo 生成%txtfile%完毕！
  echo TIPS：你可以使用记事本的另存为功能将其保存到其他位置
  start notepad %txtfile%
)
if /i !mode! equ del (
  echo 清理完毕！
  echo 打开清理日志...
  start notepad %logfile%
) 
echo 任意位置点击鼠标返回主菜单...
ConsExt /event
goto start
goto :eof

:regkeymode
setlocal
set regkeymode=%1
rem type %tmpregkey% | find /i !regkeymode! >nul 2>nul
rem if /i !errorlevel! neq 0 (
  reg query !regkeymode! >nul 2>nul
  if /i !errorlevel! equ 0 (
    if /i !mode! equ disp echo !regkeymode!项>>%txtfile%
    if /i !mode! equ del (
      SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
      SetACL -on !regkeymode! %RegFull% >nul 2>nul
      reg delete !regkeymode! /f >nul 2>nul
      if /i !errorlevel! neq 0 (
        for /f "eol=! tokens=*" %%t in ('reg query !regkeymode!  2^>nul ^|find /i "\" 2^>nul') do (
          if /i "%%t" neq !regkeymode! call :regkeymode "%%t"
        )
        SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
        SetACL -on !regkeymode! %RegFull% >nul 2>nul
        reg delete !regkeymode! /f >nul 2>nul
        if /i !errorlevel! neq 0 (
          echo 清理!regkeymode!项失败！请在注册表中手动清理！
          echo 失败：!regkeymode!>>%logfile%
        ) else (echo 成功：!regkeymode!>>%logfile%)
      ) else (echo 成功：!regkeymode!>>%logfile%)
    )
    if /i !mode! equ reg (
      SetACL -on !regkeymode! %RegOwnr% >nul 2>nul
      SetACL -on !regkeymode! %RegFull% >nul 2>nul
      if exist %tmpregfile% del %tmpregfile% /s /q >nul 2>nul
      reg export !regkeymode! %tmpregfile% >nul 2>nul && type %tmpregfile% 2>nul |find /i /v "Windows Registry Editor Version 5.00" >>%regfile% 2>nul
    )
rem     echo !regkeymode!>>%tmpregkey%
  )
rem )
endlocal
goto :eof

:regvalmode
setlocal
set regvalmodekey=%1
set regvalmode=%2
reg query !regvalmodekey! /v !regvalmode! >nul 2>nul
if /i !errorlevel! equ 0 (
  if /i !mode! equ disp echo !regvalmodekey!项下的!regvalmode!键值>>%txtfile%
  if /i !mode! equ del (
    SetACL -on !regvalmodekey! %RegOwnr% >nul 2>nul
    SetACL -on !regvalmodekey! %RegFull% >nul 2>nul
    reg delete !regvalmodekey! /v !regvalmode! /f >nul 2>nul
    if /i !errorlevel! neq 0 (
      echo 清理!regvalmodekey!项下的!regvalmode!键值失败！请在注册表中手动清理！
      echo 失败：!regvalmodekey!项下的!regvalmode!键值>>%logfile%
    ) else (echo 成功：!regvalmodekey!项下的!regvalmode!键值>>%logfile%)
  )
  if /i !mode! equ reg (
    type %tmpregkey% | find /i !regvalmodekey! >nul 2>nul
    if /i !errorlevel! neq 0 (
      SetACL -on !regvalmodekey! %RegOwnr% >nul 2>nul
      SetACL -on !regvalmodekey! %RegFull% >nul 2>nul
      if exist %tmpregfile% del %tmpregfile% /s /q >nul 2>nul
      reg export !regvalmodekey! %tmpregfile% >nul 2>nul && type %tmpregfile% 2>nul |find /i /v "Windows Registry Editor Version 5.00" >>%regfile% 2>nul
      echo !regvalmodekey!>>%tmpregkey%
    )
  )
)
endlocal
goto :eof