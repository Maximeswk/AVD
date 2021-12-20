write-output "Installing One Drive"
$client = New-Object System.Net.WebClient
$url = "https://aka.ms/OneDriveWVD-Installer"
$client.DownloadFile($url, "C:\temp\OneDriveSetup.exe")


REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64

Start-Process -FilePath "C:\temp\OneDriveSetup.exe" -ArgumentList ("/silent /allusers") -Wait

REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe /background" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "FilesOnDemandEnabled" /t REG_DWORD /d 1 /f

write-output "OneDrive Installed !"