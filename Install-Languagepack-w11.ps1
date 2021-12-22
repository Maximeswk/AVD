$ErrorActionPreference = 'silentlycontinue'

Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\MUI\" -TaskName "LPRemove"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\LanguageComponentsInstaller" -TaskName "Uninstallation"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Control Panel\International" /v "BlockCleanupOfUnusedPreinstalledLangPacks" /t REG_DWORD /d 1 /f

Write-output "Get and mount ISO ..."
mkdir c:\temp -force
$LocalPath = "C:\temp\"
$URL = 'https://software-download.microsoft.com/download/sg/22000.1.210604-1628.co_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso'
$LangPackISO = "CLIENT_LOF_PACKAGES_OEM.iso"
Write-output "Donwloading LangPackDVD ..."
$client = new-object System.Net.WebClient
$client.DownloadFile($URL,$($Localpath + $LangPackISO))
$LanguageExperiencePack = Mount-DiskImage -ImagePath $($Localpath + $LangPackISO)
$FODContent = ($LanguageExperiencePack | Get-Volume).DriveLetter + ":\LanguagesAndOptionalFeatures"


Write-output "Add packages ..."
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Basic-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-OCR-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Speech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~wow64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab 
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~wow64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Notepad-System-FoD-Package~31bf3856ad364e35~wow64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~wow64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-SnippingTool-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~wow64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab

Write-output "Set language to FR ..."
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("fr-fr")
Set-WinUserLanguageList $LanguageList -force

Set-Culture fr-fr
Set-WinSystemLocale fr-fr
Set-WinHomeLocation -GeoId 84
Set-WinUserLanguageList fr-fr -force
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language" /v "InstallLanguage" /t REG_SZ /d 040C /f
