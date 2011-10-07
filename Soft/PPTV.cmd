@echo off&Title PPtv去广告程序 By 【BatHome】-Hello123World
Rem 原理：http://jl453625978.blog.163.com/blog/static/86041705201162434258723/
Set /p a=输入你的系统（7 or xp）：
Goto %a%
Exit
:7
For /r "C:\ProgramData\PPLive\PPTV\xml" %%i in (*.xml) do (
        echo\ >"%%i"
        Attrib +r "%%i"
        )
For /r "C:\ProgramData\PPLive\PPTV\Cache\pluginad" %%i in (*.xml *.ini) do (
        Echo\ >"%%i"
        Attrib +r "%%i"
        )
Echo 已成功去除pptv广告
Pause>nul&exit
:xp
For /r "C:\Documents and Settings\All Users\Application Data\PPLive\PPTV\xml" %%i in (*.xml) do (
        echo\ >"%%i"
        Attrib +r "%%i"
        )
For /r "C:\Documents and Settings\All Users\Application Data\PPLive\PPTV\cache\pluginad" %%i in (*.xml *.ini) do (
        Echo\ >"%%i"
        Attrib +r "%%i"
        )
Echo 已成功去除pptv广告
pause>nul