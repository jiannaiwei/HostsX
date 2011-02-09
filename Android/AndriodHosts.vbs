function GetHttpFile(url) 
    dim m,s 
m="Microsoft.XMLHTTP" 
s="ADODB.Stream" 
    FileName=LCase(mid(url,InStrRev(url, "/")+1)) 
Set xml = CreateObject(m) 
xml.Open "GET",url,False 
xml.Send 
with CreateObject(s) 
.type=1 
.open 
.write xml.responseBody 
.savetofile ".\"&FileName,2 
end with 
set xml=Nothing 
end function
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/adb.exe")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/AdbWinApi.dll")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/AdbWinUsbApi.dll")
'------------------------------------------------------------
set fso=createobject("scripting.filesystemobject")
set file=fso.opentextfile("HostsX.orzhosts")
s=file.readall
file.close
s=replace(s,"0.0.0.0","127.0.0.1")
set file=fso.createtextfile("new.txt")
file.write s
file.close
Main
Sub Main()
    strSrcFile = ".\new.txt"
    strDestFile = ".\hosts"
    strDos = ReadFileToString(strSrcFile)
    strUnix = ConvDosToUnix(strDos)
    WriteStringToFile strDestFile, strUnix
End Sub
Function ConvDosToUnix(strInfo)
    ConvDosToUnix = Replace(strInfo, vbCrLf, vbLf)
End Function
Function ReadFileToString(strFilePath)
    Const ForReading = 1
    Set ofs = CreateObject("Scripting.FileSystemObject")
    Set ofile = ofs.OpenTextFile(strFilePath, ForReading, True)
    ReadFileToString = ofile.ReadAll
    ofile.Close
End Function
Sub WriteStringToFile(strFilePath, strInfo)
    Const ForWriting = 2
    Const isCreateNew = True
    Set ofs = CreateObject("Scripting.FileSystemObject")
    Set ofile = ofs.OpenTextFile(strFilePath, ForWriting, isCreateNew)
    ofile.Write strInfo
    ofile.Close
End Sub
'------------------------------------------------------------
Set objFSO = CreateObject("Scripting.FileSystemObject")
objFSO.DeleteFile(".\new.txt"), True
objFSO.DeleteFile(".\hostsx.orzhosts"), True
MsgBox "Hosts Data downloaded and conversion!", vbInformation, "G+ Hosts"
MsgBox "Please send your phone connected to the computer£¬and open the USB debug mode!", vbInformation, "G+ Hosts"
set fso=createobject("scripting.filesystemobject")
set ws=CreateObject("wscript.shell")
set fw=fso.createtextfile("transfer.bat",2)
fw.writeline("@echo on")
fw.writeline("color 0b")
fw.writeline("adb devices")
fw.writeline("adb remount")
fw.writeline("adb push hosts /system/etc/hosts")
fw.writeline("adb shell reboot")
fw.writeline("echo Hosts complete change!")
fw.writeline("echo Enjoy it!")
fw.writeline("taskkill  /f /T /im adb.exe")
fw.writeline("pause")
fw.writeline("del /f /q hosts adb.exe adbwinapi.dll adbwinusbapi.dll >nul 2>nul")
fw.writeline("del %0")
fw.close
ws.run "transfer.bat"