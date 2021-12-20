Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force 

New-Item -Path c:\temp -Name appleKeyboard -ItemType Directory -ErrorAction SilentlyContinue
$Localfolder = "c:\temp\appleKeyboard\"
$appleURL = 'https://github.com/Altux/azure-devtestlab/raw/master/Artifacts/windows-AppleKeyboardLayout/AppleKeyboard.zip'
$applezip = "AppleKeyboard.zip"
Invoke-WebRequest -Uri $appleURL -OutFile "$Localfolder$applezip"

$ziparchive = "c:\temp\appleKeyboard\AppleKeyboard.zip"
$extractpath = "c:\windows\system32"

#Unzip Keyboards in system32
Write-output "Unziping keyboards Layouts..."

Expand-Archive `
    -LiteralPath $ziparchive `
    -DestinationPath $extractpath `
    -Force `
    -Verbose

Write-output "Merging Registry entry for the keyboards Layouts..."
$keyreg = @"
Windows Registry Editor Version 5.00
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts]
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000405]
"Layout Text"="Czech (Apple)"
"Layout File"="CzechA.dll"
"Layout Id"="00d4"
"Layout Component ID"="0C8DA389245B4792B4960E336F62AC3E"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000406]
"Layout Text"="Danish (Apple)"
"Layout File"="DanishA.dll"
"Layout Id"="00cc"
"Layout Component ID"="C3996498F423440FB9CE2732A821E7D9"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000407]
"Layout Text"="German (Apple)"
"Layout File"="GermanA.dll"
"Layout Id"="00c3"
"Layout Component ID"="B616E2191BF048D4A554E5C6BE224AB4"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000409]
"Layout Text"="United States (Apple)"
"Layout File"="USA.dll"
"Layout Id"="00d1"
"Layout Component ID"="B422390FE3C04f3a917D15AD1ACD710F"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000040a]
"Layout Text"="Spanish (Apple)"
"Layout File"="SpanishA.dll"
"Layout Id"="00c5"
"Layout Component ID"="C3364C7C44BC444A88A50459135D35B5"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000040b]
"Layout Text"="Finnish (Apple)"
"Layout File"="FinnishA.dll"
"Layout Id"="00cb"
"Layout Component ID"="ECE9937799D242F5AE0CAA446EDEDC62"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000040c]
"Layout Text"="French (Apple)"
"Layout File"="FrenchA.dll"
"Layout Id"="00c2"
"Layout Component ID"="2ECD3C77364749B18E910F9196B420FA"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000040e]
"Layout Text"="Hungarian (Apple)"
"Layout File"="HungaryA.dll"
"Layout Id"="00d5"
"Layout Component ID"="725BE97D2AD14042BA539D96030F93AA"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000410]
"Layout Text"="Italian (Apple)"
"Layout File"="ItalianA.dll"
"Layout Id"="00c4"
"Layout Component ID"="6401AAA6058F431181B445C26BEF22D9"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000413]
"Layout Text"="Dutch (Apple)"
"Layout File"="DutchA.dll"
"Layout Id"="00c1"
"Layout Component ID"="3844B95343FB43D68E9695D6E88F016E"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000414]
"Layout Text"="Norwegian (Apple)"
"Layout File"="NorwayA.dll"
"Layout Id"="00c9"
"Layout Component ID"="74BE397ABD8143E4960D38111394D1A3"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000415]
"Layout Text"="Polish (Apple)"
"Layout File"="PolishA.dll"
"Layout Id"="00cf"
"Layout Component ID"="D3D2841618E34D09ABBCA0DA34A60FAE"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000416]
"Layout Text"="Portuguese (Apple)"
"Layout File"="PortuguA.dll"
"Layout Id"="00ce"
"Layout Component ID"="326773935C8C4597B0738FE2084D44AD"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000419]
"Layout Text"="Russian (Apple)"
"Layout File"="RussianA.dll"
"Layout Id"="00c8"
"Layout Component ID"="B0F62A69BE9446488ED502E800DBC36C"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000041d]
"Layout Text"="Swedish (Apple)"
"Layout File"="SwedishA.dll"
"Layout Id"="00c7"
"Layout Component ID"="8CC8067A1BFF4A0FAD38708DE4CD4BF1"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000041f]
"Layout Text"="Turkish Q (Apple)"
"Layout File"="TurkeyQA.dll"
"Layout Id"="00d3"
"Layout Component ID"="2513D09A670B4d9bA8F1BDAAAA32176F"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000809]
"Layout Text"="United Kingdom (Apple)"
"Layout File"="BritishA.dll"
"Layout Id"="00c0"
"Layout Component ID"="1A4D378083AD454BB4FE02F208614EB6"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000813]
"Layout Text"="Belgian (Apple)"
"Layout File"="BelgiumA.dll"
"Layout Id"="00cd"
"Layout Component ID"="D70C1682E8F24ED4B5B70AAD37B1BA42"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0000c0c]
"Layout Text"="Canadian Multilingual (Apple)"
"Layout File"="CanadaA.dll"
"Layout Id"="00ca"
"Layout Component ID"="517A729DDEC543E3A7F392E3F130C25F"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a000100c]
"Layout Text"="Swiss (Apple)"
"Layout File"="SwissA.dll"
"Layout Id"="00c6"
"Layout Component ID"="CE4C7E2419DE400B8A553E1A5C3DCD04"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a0020409]
"Layout Text"="United States-International (Apple)"
"Layout File"="IntlEngA.dll"
"Layout Id"="00d0"
"Layout Component ID"="241A34D0-06DB-405e-8B4E-8CA2FC34D1C7"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\a100041f]
"Layout Text"="Turkish F (Apple)"
"Layout File"="TurkeyA.dll"
"Layout Id"="00d2"
"Layout Component ID"="D1502D2EF02F4e4b8D313D3C0B0457D0"

"@

$keyreg | Out-file c:\temp\appleKeyboard\AppleKeyboard.reg
regedit /s c:\temp\appleKeyboard\AppleKeyboard.reg

