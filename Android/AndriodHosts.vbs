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
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/hosts")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/SDCard.zip")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/adb.exe")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/AdbWinApi.dll")
GetHttpFile("http://hostsx.googlecode.com/svn/trunk/Android/AdbWinUsbApi.dll")
MsgBox "Hosts Data downloaded and conversion!", vbInformation, "HostsX"
MsgBox "Please send your phone connected to the computer£¬and open the USB debug mode!", vbInformation, "HostsX"
set fso=createobject("scripting.filesystemobject")
set ws=CreateObject("wscript.shell")
set fw=fso.createtextfile("transfer.bat",2)
fw.writeline("@echo on")
fw.writeline("color 0b")
fw.writeline("adb devices")
fw.writeline("adb root")
fw.writeline("adb remount")
fw.writeline("adb push hosts /etc/hosts")
fw.writeline("adb shell chmod 644 /etc/hosts")
fw.writeline("adb shell reboot")
fw.writeline("echo Hosts complete Update!")
fw.writeline("echo Enjoy it!")
fw.writeline("taskkill  /f /T /im adb.exe")
fw.writeline("pause")
fw.writeline("del /f /q hosts adb.exe adbwinapi.dll adbwinusbapi.dll >nul 2>nul")
fw.writeline("del %0")
fw.close
ws.run "transfer.bat"