On Error Resume Next
p=Left(WScript.ScriptFullName,Len(WScript.ScriptFullName)-Len(WScript.ScriptName))&"Custom.css"
Set WSHShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles\","","REG_SZ"
if WSHShell.RegRead("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles\Use My Stylesheet") = 0 then
WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles\Use My Stylesheet", "1", "REG_DWORD"
WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles\User Stylesheet", p, "REG_SZ"
WshShell.Run "gpupdate /force",0,true
WSHShell.SendKeys "{F5}"
else
WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles\Use My Stylesheet", "0", "REG_DWORD"
WshShell.Run "gpupdate /force",0,true
WSHShell.SendKeys "{F5}"
end if