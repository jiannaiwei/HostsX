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
MsgBox "HostsX Data had conversion!", vbInformation, "HostsX"
