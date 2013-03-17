SUI:
	webvideo:=Object() 
	IniRead, K, pathad.ini
	loop,Parse, K ,`n
	{
		if (A_LoopField =  "webvideo")
		{
			IniRead, K, pathad.ini, webvideo
			loop,Parse, K ,`n
			webvideo.Insert(A_LoopField)
		}
		else if (A_LoopField =  "IFEO")
		{
			IniRead, K, pathad.ini, IFEO
			loop,Parse, K ,`n
				Regwrite, REG_SZ, HKEY_LOCAL_MACHINE,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%A_LoopField%, Debugger, %A_WinDir%\twunk_32.exe
		}
		else if (A_LoopField =  "ZoneMap")
		{
			IniRead, K, pathad.ini, ZoneMap
			loop,Parse, K ,`n
				Regwrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\%A_LoopField%, *, 00000004
		} 
		else if (A_LoopField =  "ZoneMapW")
		{
			IniRead, K, pathad.ini, ZoneMapW
			loop,Parse, K ,`n
			{
				Regwrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\%A_LoopField%, http, 00000002
				Regwrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\%A_LoopField%, https, 00000002
			}
		} 
		else Read(A_LoopField)
	}

	if A_OSVersion in WIN_2000,WIN_XP
		SUI(A_AppData "\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects")
	else				
		SUI(EnvGet("USERPROFILE") "\AppData\Local\Google\Chrome\User Data\Default\Pepper Data\Shockwave Flash\WritableRoot\#SharedObjects")
		
	SUI(A_AppData "\Macromedia\Flash Player\#SharedObjects")
return


Read(Z){
	IniRead, M, pathad.ini, %Z%
	loop,Parse, M ,`n
	{
			if A_LoopField =  
			continue
			CZ(((J:=EnvGet(Z)) ? J  "\" : "") A_LoopField)
	}
	}

SUI(Z){
	global webvideo
	Loop, %Z%\*,1   
		if (StrLen(A_LoopFileName) = 8)
			R = %R%%A_LoopFileTimeModified%`t%A_LoopFileName%`n	

	Sort, R, R
	Loop, parse, R, `n
	{
		if !A_LoopField
			continue
		StringSplit, FileItem, A_LoopField, %A_Tab%  
		K:=FileItem2
		break
	}

	IF !K	
		FileCreateDir, % K:=Z "\hostsxpt"
	else
		K=%Z%\%K%

	IfInString,K, :
		for index, V in webvideo
			CZ(K "\" V)
}

CZ(A){
	if V:=FileExist(A)
	{
		if InStr(V, "D")
		{
			FileSetAttrib, -R, %A%
			FileRemoveDir, %A%, 1
			FileAppend, , %A%
			FileSetAttrib, +R, %A%
		} 
		else IF (FileGetSize(A) > 0)
		{

			FileSetAttrib, -R, %A%
			FileDelete, %A%
			FileAppend, , %A%
			FileSetAttrib, +R, %A%
		} 
		
	}
	else IfInString,A, :
	{
		SplitPath, A , , U
		if NOT FileExist(U)
			FileCreateDir, %U% 
		FileAppend, , %A%
		FileSetAttrib, +R, %A%
	}
	
}

EnvGet(V){
	EnvGet, J, %V%
	Return J
	}

FileGetSize(A){
	FileGetSize, V, %A%
	Return V
	}