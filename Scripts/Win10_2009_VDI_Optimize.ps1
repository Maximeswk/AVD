################################
#    Download WVD Optimizer    #
################################
$ErrorActionPreference='Continue'
New-Item -Path C:\ -Name temp -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = "C:\temp\"
$WVDOptimizeURL = 'https://codeload.github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool/zip/refs/heads/main'
$WVDOptimizeInstaller = "Windows_10_VDI_Optimize-master.zip"
Invoke-WebRequest `
    -Uri $WVDOptimizeURL `
    -OutFile $Localpath$WVDOptimizeInstaller


###############################
#    Prep for WVD Optimize    #
###############################
Expand-Archive `
    -LiteralPath "C:\temp\Windows_10_VDI_Optimize-master.zip" `
    -DestinationPath "$Localpath" `
    -Force `
    -Verbose
Set-Location -Path C:\temp\Virtual-Desktop-Optimization-Tool-main


$WVDOptimizeURL = 'https://aibstorscript26052021.blob.core.windows.net/publicscripts/Win10_VirtualDesktop_Optimize.ps1'
Invoke-WebRequest `
    -Uri $WVDOptimizeURL `
    -OutFile "C:\temp\Virtual-Desktop-Optimization-Tool-main\Win10_VirtualDesktop_Optimize.ps1"


#################################
#    Run WVD Optimize Script    #
#################################
New-Item -Path C:\temp\ -Name install.log -ItemType File -Force
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
add-content C:\temp\install.log "Starting Optimizations"  
.\Win10_VirtualDesktop_Optimize.ps1 -WindowsVersion 2009 `
                                    -Verbose -AcceptEULA `
                                    -Optimizations "WindowsMediaPlayer",`
                                                    "AppxPackages",`
                                                    "ScheduledTasks",`
                                                    "DefaultUserSettings",`
                                                    "Services",`
                                                    "Autologgers",`
                                                    "LGPO"