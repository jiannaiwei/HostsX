@echo.
@echo 请以 *管理员身份* 运行bat文件!
sc stop dnsforwarder 
sc delete dnsforwarder 
sc create DNSForwarder binPath= "%cd%\srvany.exe" start= auto
sc description dnsforwarder "UDP to TCP DNS Forwarder"
rem 权限检测模块,判断操作系统版本
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (call :lnk64) Else (call :lnk32)
reg add HKLM\SYSTEM\CurrentControlSet\Services\dnsforwarder\Parameters /v AppDirectory /d "%cd%" /f
sc start dnsforwarder
@echo 成功了～！
@echo.
@pause
exit

:lnk32
reg add HKLM\SYSTEM\CurrentControlSet\Services\dnsforwarder\Parameters /v Application /d "%cd%\dnsforwarder_32.exe" /f
goto :eof

:lnk64
reg add HKLM\SYSTEM\CurrentControlSet\Services\dnsforwarder\Parameters /v Application /d "%cd%\dnsforwarder_64.exe" /f
goto :eof

!delete_dnsproxy_server.bat
sc stop dnsforwarder 
sc delete dnsforwarder 
