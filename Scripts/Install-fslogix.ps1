write-output "Installing fslogix"
$client = New-Object System.Net.WebClient
$url = "https://aka.ms/fslogix_download"
$client.DownloadFile($url, "$PSScriptRoot\fslogix.zip")

Expand-Archive -LiteralPath "$PSScriptRoot\fslogix.zip" -DestinationPath $PSScriptRoot\fslogix

Start-Process -FilePath "$PSScriptRoot\fslogix\x64\Release\FSLogixAppsSetup.exe" -ArgumentList ("/install /quiet /norestart") -Wait

REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /V AccessNetworkAsComputerObject /T REG_DWORD /D 1 /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /V Enabled /T REG_DWORD /D 1 /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /v DeleteLocalProfileWhenVHDShouldApply /T REG_DWORD /D 1 /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /v FlipFlopProfileDirectoryName /T REG_DWORD /D 1 /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /v IsDynamic /T REG_DWORD /D 1 /f
REG ADD "HKLM\SOFTWARE\FSlogix\Profiles" /v VolumeType /T REG_SZ /D "vhdx" /f

# Add startup script
$psscriptsmachine = @"
 
[ScriptsConfig]
StartExecutePSFirst=false
[Startup]
0CmdLine=start.ps1
0Parameters=

"@

mkdir "C:\Windows\System32\GroupPolicy\Machine\Scripts" -force
$psscriptsmachine | Out-file C:\Windows\System32\GroupPolicy\Machine\Scripts\psscripts.ini -Force

$gpt = @"
[General]
gPCMachineExtensionNames=[{35378EAC-683F-11D2-A89A-00C04FBBCFA2}{D02B1F72-3407-48AE-BA88-E8213C6761F1}][{42B5FAAE-6536-11D2-AE5A-0000F87571E3}{40B6664F-4972-11D1-A7CA-0000F87571E3}]
Version=65546
gPCUserExtensionNames=[{35378EAC-683F-11D2-A89A-00C04FBBCFA2}{D02B1F73-3407-48AE-BA88-E8213C6761F1}]

"@ 

$gpt | Out-file C:\Windows\System32\GroupPolicy\GPT.INI -Force
