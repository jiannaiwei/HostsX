@echo off
set file=%windir%\system32\drivers\etc\hosts
set size=15866

rem 设置IE“不从地址栏搜索”
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v AutoSearch /t reg_dword /d 00000000 /f
copy /y hosts %windir%\system32\drivers\etc

rem dir /-c %file%

for /f "tokens=3 delims= " %%a in ('dir /-c %file% ^| find "1 个文件"') do (  
                      echo.
                      if %%a equ %size% 	(
		           pause>nul|echo  文件大小无误，屏蔽成功，任意键退出 .....
		           exit
		       )
	)
      pause>nul|echo  屏蔽失败，任意键退出 .....