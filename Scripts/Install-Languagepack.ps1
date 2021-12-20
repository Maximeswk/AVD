################################
#    Download WVD Language    #
################################

$ErrorActionPreference = "Continue"

mkdir c:\temp -force
$LocalPath = "C:\temp\"
$URL = 'https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso'
$LangPackISO = "19041.1.191206-1406.vb_release_CLIENTLANGPACKDVD_OEM_MULTI.iso"
Write-output "Donwloading LangPackDVD ..."
$client = new-object System.Net.WebClient
$client.DownloadFile($URL,$($Localpath + $LangPackISO))

$URL = 'https://software-download.microsoft.com/download/pr/19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso'
$PackagesOEMISO = "19041.1.191206-1406.vb_release_amd64fre_FOD-PACKAGES_OEM_PT1_amd64fre_MULTI.iso"
Write-output "Donwloading PACKAGES_OEM ..."
$client = new-object System.Net.WebClient
$client.DownloadFile($URL,$($Localpath + $PackagesOEMISO))

$URL = 'https://software-download.microsoft.com/download/sg/19041.928.210407-2138.vb_release_svc_prod1_amd64fre_InboxApps.iso'
$InboxAppsISO = "19041.928.210407-2138.vb_release_svc_prod1_amd64fre_InboxApps.iso"
Write-output "Donwloading InboxApps ..."
$client = new-object System.Net.WebClient
$client.DownloadFile($URL,$($Localpath + $InboxAppsISO))


#############################
#    Install Language       #
#############################

Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"

Write-output "Mount Disks ..."
$LanguageExperiencePack = Mount-DiskImage -ImagePath $($Localpath + $LangPackISO)
$FOD = Mount-DiskImage -ImagePath $($Localpath + $PackagesOEMISO)
$InboxApps = Mount-DiskImage -ImagePath $($Localpath + $InboxAppsISO)

$LEPContent = ($LanguageExperiencePack | Get-Volume).DriveLetter + ":\LocalExperiencePack\fr-fr"
$LIPContent = ($LanguageExperiencePack | Get-Volume).DriveLetter + ":\x64\langpacks"
$FODContent = ($FOD | Get-Volume).DriveLetter + ":"

Write-output "Add packages ..."
Add-AppProvisionedPackage -Online -PackagePath $LEPContent\LanguageExperiencePack.fr-fr.Neutral.appx -LicensePath $LEPContent\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab

Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Basic-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-OCR-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-Speech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~fr-fr~.cab
Add-WindowsPackage -Online -PackagePath $FODContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~fr-FR~.cab

$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("fr-fr")
Set-WinUserLanguageList $LanguageList -force

Set-Culture fr-fr
Set-WinSystemLocale fr-fr
Set-WinHomeLocation -GeoId 84
Set-WinUserLanguageList fr-fr -force

#########################################
## Update Inbox Apps for Multi Language##
#########################################
##Set Inbox App Package Content Stores##
# [string] $AppsContent = ($InboxApps | Get-Volume).DriveLetter + ":\amd64fre\"

# ##Update installed Inbox Store Apps##
# foreach ($App in (Get-AppxProvisionedPackage -Online)) {
#     $AppPath = $AppsContent + $App.DisplayName + '_' + $App.PublisherId
#     Write-Host "Handling $AppPath"
#     $licFile = Get-Item $AppPath*.xml
#     if ($licFile.Count) {
#         $lic = $true
#         $licFilePath = $licFile.FullName
#     }
#     else {
#         $lic = $false
#     }
#     $appxFile = Get-Item $AppPath*.appx*
#     if ($appxFile.Count) {
#         $appxFilePath = $appxFile.FullName
#         if ($lic) {
#             Add-AppxProvisionedPackage -Online -PackagePath $appxFilePath -LicensePath $licFilePath 
#         }
#         else {
#             Add-AppxProvisionedPackage -Online -PackagePath $appxFilePath -skiplicense
#         }
#     }
# }