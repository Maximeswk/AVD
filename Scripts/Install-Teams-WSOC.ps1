write-output "Teams WebSocket Optimizations Client"
$client = New-Object System.Net.WebClient
$url = "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4AQBt"
$client.DownloadFile($url, "C:\temp\MsRdcWebRTCSvc.msi")

msiexec /i "C:\temp\MsRdcWebRTCSvc.msi" /qn