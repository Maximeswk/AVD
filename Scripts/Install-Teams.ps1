write-output "Installing Teams"
$client = New-Object System.Net.WebClient
$url = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
$client.DownloadFile($url, "C:\temp\Teams.msi")

REG ADD "HKLM\SOFTWARE\Microsoft\Teams" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Teams" /v "IsWVDEnvironment" /t REG_DWORD /d 1 /f

msiexec /i "C:\temp\Teams.msi" /l*v "C:\temp\teamslog.txt" ALLUSERS=1 ALLUSER=1
