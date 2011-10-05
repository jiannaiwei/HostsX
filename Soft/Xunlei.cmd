@ECHO OFF
echo 正在停止服务....
net stop "XLDoctor Service"
ECHO 正在卸载服务....
sc delete "XLDoctor Service"
ECHO 已完成
pause 1>nul 2>nul