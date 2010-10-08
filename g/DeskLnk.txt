Set objShell = CreateObject("Wscript.Shell")
strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile)
strPath = strFolder '获取文件所驻留的文件夹的完整路径

set WshShell = Wscript.CreateObject("Wscript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
set oShellLink = WshShell.CreateShortcut(strDesktop & "\极佳猴子.lnk")
oShellLink.TargetPath = strPath & "\HostsTool.bat" '创建一个快捷方式对象
oShellLink.Windowstyle = 1
oShellLink.Hotkey = "" '设置快捷方式的快捷键
oShellLink.IconLocation = strPath & "\g.ico,0" '设置快捷方式的图标路径
oShellLink.Description = "小巧，安全，快速的Hosts文件管理工具" '设置快捷方式的描述
oShellLink.WorkingDirectory = strPath
oShellLink.Save