Get-ChildItem 'C:\Windows\Installer' -Filter *.msi | ForEach-Object {
    $msiPath = $_.FullName
    $installer = New-Object -ComObject WindowsInstaller.Installer
    $database = $installer.GetType().InvokeMember("OpenDatabase", "InvokeMethod", $null, $installer, @($msiPath, 0))
    $view = $database.GetType().InvokeMember("OpenView", "InvokeMethod", $null, $database, @("SELECT `Value` FROM `Property` WHERE `Property` = 'Manufacturer'"))
    $view.GetType().InvokeMember("Execute", "InvokeMethod", $null, $view, $null)
    $record = $view.GetType().InvokeMember("Fetch", "InvokeMethod", $null, $view, $null)
    $author = if ($record) { $record.GetType().InvokeMember("StringData", "GetProperty", $null, $record, 1) } else { "Unknown" }
    Write-Output "$msiPath`t$author"
}
