$ExtensionManager = Get-View ExtensionManager
write-Host "Current Extensions:"
$ExtensionManager.ExtensionList | Select-Object @{Name='Description';Expression={$_.Description.Label}},Key,Company,Version | Sort-Object Description
write-host "HCX Eextensions:"
$ext_hcx = $ExtensionManager.ExtensionList | Select-Object @{Name='Description';Expression={$_.Description.Label}},Key,Company,Version | Where-Object -Property Key -Like 'com.vmware.hybridity*' | Sort-Object Description
$ext_hcx
foreach ($ext in $ext_hcx){
    Write-Host "Removing Extension:" $ext.key
    $ExtensionManager.UnregisterExtension($ext.key)
}
write-host "Removing Extension: com.vmware.hcsp.alarm"
$ExtensionManager.UnregisterExtension("com.vmware.hcsp.alarm")
write-host "Removing Extension: com.vmware.vca.marketing.ngc.ui"
$ExtensionManager.UnregisterExtension("com.vmware.vca.marketing.ngc.ui")
