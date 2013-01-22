;-------------------------------------------------------------------------------
;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         DemoJameson <DemoJameson@gmail.com>
;
;-------------------------------------------------------------------------------

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

;-------------------------------------------------------------------------------
Gui, Add, Text, x6 y6 w180 h20 , Manager your search engines	;文字标签
Gui, Add, ListBox, x6 y26 w160 h250 vSearchList +AltSubmit	;搜索引擎列表框
Gui, Add, Button, x176 y26 w80 h30 , Top						;上移到顶部按钮
Gui, Add, Button, x176 y66 w80 h30 , Up						;下移按钮
Gui, Add, Button, x176 y106 w80 h30 , Down					;上移按钮
Gui, Add, Button, x176 y146 w80 h30 , Bottom					;下移到底部按钮
Gui, Add, Button, x176 y276 w80 h30 , Save					;保存按钮
Gui, Add, CheckBox, x6 y276 w120 h30 vShowIcon, Show Icon	;显示图标复选框
Gui, +Delimiter`n												;设置 ListBox 的分行符为 `n 即换行符。
; Generated using SmartGUI Creator 4.0



;~ 选择要修改的 Search.ini 文件
FileSelectFile, SearchFile, , , choose your search.ini, search.ini (*.ini)

If ( SearchFile = "" )
{
    ExitApp
}

ClipSaved := Clipboard

;~ 读取搜索引擎名字
Loop
{
	IniRead, S_Name%A_Index%, %SearchFile%, % "Search Engine "A_Index, Name
	IniRead, S_Deleted%A_Index%, %SearchFile%, % "Search Engine "A_Index, Deleted

	If ( S_Name%A_Index% = "ERROR" )
	{
		Break
	}

	If ( S_Name%A_Index% = "" )
	{
		S_Name%A_Index% = Blank
	}

	If ( S_Deleted%A_Index% = 1 )
	{
		S_Name%A_Index% := S_Name%A_Index% " : Deleted"
	}

;~ 	消除搜索引擎名称里的 | 字符，以免和下面 List 的分行符冲突。
;~ 	StringReplace, S_Name%A_Index%, S_Name%A_Index%, `| [, ReplaceText, ReplaceAll?]

	Transform, Clipboard, Unicode, % S_Name%A_Index%
	S_Name%A_Index% := Clipboard
	S_Name_Bak%A_Index% := Clipboard
	S_NameList .= "`n" S_Name%A_Index%
	SearchCount := A_Index
}

Clipboard := ClipSaved

GuiControl,, SearchList, %S_NameList%
;~ 录入列表框
GuiControl, Choose, SearchList, 1

Gui, Show, x495 y331 h315 w260, Manager your search engines
Return

GuiEscape:
GuiClose:
ExitApp

;~ 上移选中的搜索引擎到顶部
ButtonTop:
	GuiControlGet, Selected,, SearchList
	If ( Selected > 1 )
	{
;~ 		交换上下两个变量
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name1
		S_Name1 := Temp
		S_NameList =

;~ 		重新组合
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		刷新列表框
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, 1
	}
Return

;~ 上移选中的搜索引擎
ButtonUp:
	GuiControlGet, Selected,, SearchList
	If ( Selected > 1 )
	{
;~ 		交换上下两个变量
		TempSelected := Selected - 1
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%TempSelected%
		S_Name%TempSelected% := Temp
		S_NameList =

;~ 		重新组合
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		刷新列表框
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, % Selected - 1
	}
Return

;~ 下移选中的搜索引擎
ButtonDown:
	GuiControlGet, Selected,, SearchList

	If ( Selected < SearchCount )
	{
;~ 		交换下上两个变量
		TempSelected := Selected + 1
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%TempSelected%
		S_Name%TempSelected% := Temp
		S_NameList =

;~ 		重新组合
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		刷新列表框
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, % Selected + 1
	}
Return

;~ 下移选中的搜索引擎到底部
ButtonBottom:
	GuiControlGet, Selected,, SearchList

	If ( Selected < SearchCount )
	{
;~ 		交换下上两个变量
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%SearchCount%
		S_Name%SearchCount% := Temp
		S_NameList =

;~ 		重新组合
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		刷新列表框
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, %SearchCount%
	}
Return

;~ 保存修改
ButtonSave:
	FileRead, SearchContent, %SearchFile%

	Loop, %SearchCount%
	{
		i := A_Index

		Loop, %SearchCount%
		{
			If ( S_Name%i% = S_Name_Bak%A_Index% )
			{
;~ 				改变两个搜索引擎的序号
				StringReplace, SearchContent, SearchContent, Search Engine %i%, Search Engine T
				StringReplace, SearchContent, SearchContent, Search Engine %A_Index%, Search Engine %i%
				StringReplace, SearchContent, SearchContent, Search Engine T, Search Engine %A_Index%
				Temp := S_Name_Bak%i%
				S_Name_Bak%i% := S_Name_Bak%A_Index%
				S_Name_Bak%A_Index% := Temp
				Break
			}
		}
	}

	FileDelete, %SearchFile%
	FileAppend, %SearchContent%, %SearchFile%

	If ( !ErrorLevel )
	{
		MsgBox, OK
	}

;~ 	修改图标是否显示
	GuiControlGet, isShowIcon,, ShowIcon

	If ( isShowIcon )
	{
		Loop, %SearchCount%
		{
			IniRead, S_URL, %SearchFile%, % "Search Engine "A_Index, URL

			If ( S_URL = "" )
			{
				IniDelete, %SearchFile%, % "Search Engine "A_Index, Icon
				Continue
			}

			SplitPath, S_URL,,,,, faviconAddress
			If ( faviconAddress != "" )
			{
				faviconAddress = %faviconAddress%/favicon.ico
				IniWrite, %faviconAddress%, %SearchFile%, % "Search Engine "A_Index, Icon
			}
		}
	}
	Else
	{
		Loop, %SearchCount%
		{
			IniWrite, NotShowIcon, %SearchFile%, % "Search Engine "A_Index, Icon
		}
	}
Return

;-------------------------------------------------------------------------------