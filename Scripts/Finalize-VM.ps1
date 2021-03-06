# Write-Host "Cleanup WinSxS"
# Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

$ErrorActionPreference = 'silentlycontinue'

Write-Host "Clean up various directories"
@(
    "$env:windir\\logs",
    "$env:windir\\winsxs\\manifestcache",
    "$env:windir\\Temp",
    "$env:TEMP",
    "C:\Installdir",
    "C:\temp"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        try {
            Takeown /d Y /R /f $_
            Icacls $_ /GRANT:r administrators:F /T /c /q  2>&1 | Out-Null
            Remove-Item $_ -Recurse -Force | Out-Null
        }
        catch { $global:error.RemoveAt(0) }
    }
}

$winInstallDir = "$env:windir\\Installer"
New-Item -Path $winInstallDir -ItemType Directory -Force

$ErrorActionPreference = 'Continue'