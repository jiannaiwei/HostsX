@ECHO OFF
del "C:\Program Files\Thunder\Program\MiniXmpInstall.exe"
rd  "C:\Program Files\Thunder\BBInside" /s /q
echo 正在停止服务....
net stop "XLDoctor Service"
sc stop XLServicePlatform
ECHO 正在卸载服务....
sc delete "XLDoctor Service"
sc delete XLServicePlatform
ECHO 已完成
pause 1>nul 2>nul