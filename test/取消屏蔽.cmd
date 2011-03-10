@echo off
set file=%windir%\system32\drivers\etc\hosts
set size=732

copy /Y old\hosts %windir%\system32\drivers\etc

for /f "tokens=3 delims= " %%a in ('dir /-c %file% ^| find "1 个文件"') do (  
                      echo.
                      if %%a equ %size% 	(
		           pause>nul|echo  已取消屏蔽，任意键退出 .....
		           exit
		       )
	)
      pause>nul|echo  无法取消屏蔽，任意键退出 .....