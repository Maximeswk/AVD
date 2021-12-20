  write-host "Set time limit for disconnected sessions"
  # 5 min = 300000
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "MaxDisconnectionTime" /t "REG_DWORD" /d 1800000 /f

  write-host "MaxIdleTime"
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "MaxIdleTime" /t "REG_DWORD" /d 1800000 /f 

  #  GPU Optimization
  # write-host "GPU Optimization"
  # reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v bEnumerateHWBeforeSW /t REG_DWORD /d 1 /f
  # reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v AVC444ModePreferred /t REG_DWORD /d 1 /f
  # reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v AVCHardwareEncodePreferred /t REG_DWORD /d 1 /f

  # default user setup
  reg load hkey_users\default C:\Users\Default\NTUSER.DAT

  write-host "Office"
  reg add "hkey_users\TempDefault\SOFTWARE\Policies\Microsoft\office\16.0\common" /v InsiderSlabBehavior /t REG_DWORD /d 2 /f
  reg add "hkey_users\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v enable /t REG_DWORD /d 1 /f
  reg add "hkey_users\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v syncwindowsetting /t REG_DWORD /d 1 /f
  reg add "hkey_users\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSetting /t REG_DWORD /d 1 /f
  reg add "hkey_users\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSettingMonths  /t REG_DWORD /d 1 /f

  reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate" /v hideupdatenotifications /t REG_DWORD /d 1 /f
  reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate" /v hideenabledisableupdates /t REG_DWORD /d 1 /f

  write-host "hide suggested apps"
  reg add "hkey_users\default\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t "REG_DWORD" /d "0" /f

  write-host "Quick Acces to Desktop (win+E)"
  reg add "hkey_users\default\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f


  # unload default reg
  reg unload hkey_users\default

  write-host "MS recommands"
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableTimeZoneRedirection /t REG_DWORD /d 1 /f
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f

  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MaxMonitors /t REG_DWORD /d 4 /f
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MaxXResolution /t REG_DWORD /d 5120 /f
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v MaxYResolution /t REG_DWORD /d 2880 /f

  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\rdp-sxs" /v MaxMonitors /t REG_DWORD /d 4 /f
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\rdp-sxs" /v MaxXResolution /t REG_DWORD /d 5120 /f
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\rdp-sxs" /v MaxYResolution /t REG_DWORD /d 2880 /f


# Startlayout
$psscriptsmachine = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" 
xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
  <LayoutOptions StartTileGroupCellWidth="6" />
  <DefaultLayoutOverride LayoutCustomizationRestrictionType="OnlySpecifiedGroups">
    <StartLayoutCollection>
      <defaultlayout:StartLayout GroupCellWidth="6">
      <start:Group Name="Microsoft Office">
      <start:DesktopApplicationTile Size="2x2" Column="2" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Excel.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Word.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="4" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\PowerPoint.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="0" Row="2" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" />
    </start:Group>
    <start:Group Name="Navigateurs Internet">
      <start:DesktopApplicationTile Size="2x2" Column="4" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="2" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Firefox.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" />
    </start:Group>
    <start:Group Name="Windows">
      <start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\computer.lnk" />
      <start:DesktopApplicationTile Size="2x2" Column="2" Row="0" DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />
    </start:Group>
      </defaultlayout:StartLayout>
    </StartLayoutCollection>
  </DefaultLayoutOverride>
<CustomTaskbarLayoutCollection PinListPlacement="Replace">
      <defaultlayout:TaskbarLayout>
        <taskbar:TaskbarPinList>
          <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" />
          <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />
          <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" />
          <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Word.lnk" />
          <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Excel.lnk" />
          </taskbar:TaskbarPinList>
      </defaultlayout:TaskbarLayout>
    </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@

$psscriptsmachine | Out-file C:\Windows\System32\GroupPolicy\startlayout.xml -Force
