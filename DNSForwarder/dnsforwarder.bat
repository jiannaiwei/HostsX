@echo.
@echo 请以 *管理员身份* 运行bat文件!
sc stop dnsforwarder 
sc delete dnsforwarder 
sc create DNSForwarder binPath= "%cd%\srvany.exe" start= auto
sc description dnsforwarder "UDP to TCP DNS Forwarder"
reg add HKLM\SYSTEM\CurrentControlSet\Services\dnsforwarder\Parameters /v Application /d "%cd%\dnsforwarder.exe" /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\dnsforwarder\Parameters /v AppDirectory /d "%cd%" /f
sc start dnsforwarder
@echo 成功了～！
@echo.
@pause
exit

!delete_dnsproxy_server.bat
sc stop dnsforwarder 
sc delete dnsforwarder 
