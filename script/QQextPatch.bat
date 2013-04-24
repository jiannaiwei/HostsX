reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\qqsafeud.exe" /v debugger /t reg_sz /d %windir%\twunk_32.exe /f
DEL /F /Q /A -R -H -S -A "%appdata%\Tencent\QQ\SafeBase\tssafeedit.dat"
Md "%appdata%\Tencent\QQ\SafeBase\tssafeedit.dat"
Md "%appdata%\Tencent\QQ\SafeBase\qqsafeud.exe"
attrib +r +s +h "%appdata%\Tencent\QQ\SafeBase\tssafeedit.dat"
echo y| cacls "%appdata%\Tencent\QQ\SafeBase\tssafeedit.dat" /D everyone
echo y| cacls "%appdata%\Tencent\QQ\SafeBase\qqsafeud.exe" /D everyone
DEL /F /Q /A -R -H -S -A "%Temp%\qqsafeud.exe"
md "%Temp%\qqsafeud.exe"
attrib +r +s +h "%Temp%\qqsafeud.exe"
echo y| cacls "%Temp%\qqsafeud.exe" /D everyone
