OutFile ..\AcrylicInstaller.exe
XPStyle on
Name "Acrylic DNS Proxy 0.9.17"
InstallDir "$PROGRAMFILES\Acrylic DNS Proxy"
InstallDirRegKey HKLM SYSTEM\CurrentControlSet\services\AcrylicController ImagePath
BrandingText "Mini Installer built by HostsX"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\TradChinese.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"
Page directory
Page instfiles

RequestExecutionLevel admin

Section
  SetOutPath "$INSTDIR"
  IfFileExists $INSTDIR\AcrylicService.exe 0 +2
    ExecWait '"$INSTDIR\AcrylicService.exe" /UNINSTALL /SILENT'
  File "AcrylicService.exe"

  File "AcrylicConsole.exe"
  File "AcrylicLookup.exe"
  
  IfFileExists $INSTDIR\AcrylicConfiguration.ini +2 0
    File "AcrylicConfiguration.ini"

  IfFileExists $INSTDIR\AcrylicHosts.txt +2 0
    File "AcrylicHosts.txt"

  ExecWait '"$INSTDIR\AcrylicService.exe" /INSTALL /SILENT'
  
  WriteUninstaller Uninstall.exe
SectionEnd

Section un.
  Delete "$INSTDIR\Uninstall.exe"
  
  KillProcDLL::KillProc "AcrylicConsole.exe"
  Delete "$INSTDIR\AcrylicConsole.exe"
  
  KillProcDLL::KillProc "AcrylicLookup.exe"
  Delete "$INSTDIR\AcrylicLookup.exe"
  
  ExecWait '"$INSTDIR\AcrylicService.exe" /UNINSTALL /SILENT'
  KillProcDLL::KillProc "AcrylicService.exe"
  Delete "$INSTDIR\AcrylicService.exe"
  
  MessageBox MB_YESNO|MB_DEFBUTTON1|MB_ICONQUESTION "Skip the configure file? ±£¡Ù≈‰÷√Œƒº˛£ø" /SD IDYES IDYES true IDNO false
  true:
    Goto next
  false:
    Delete "$INSTDIR\AcrylicConfiguration.ini"
    Delete "$INSTDIR\AcrylicHosts.txt"
  next:
  
  RMDir "$INSTDIR"
SectionEnd
