$timestamp = Get-Date -format "yyyyMMdd-HH.mm"
$startdir = "."
$exportfile = "$startdir\vm-custom-attributes-$timestamp.csv"

$obj = New-Object -TypeName PSObject
$attribs = Get-CustomAttribute -targettype "VirtualMachine"
$obj | Add-Member -MemberType NoteProperty -Name "Name" -Value ""
foreach ($attrib in $attribs){
    $obj | add-member -MemberType NoteProperty -Name $attrib.Name -Value ""
}
$vms = Get-VM 
$Report =@()
    foreach ($vm in $vms) {
        $row = $obj | select *
        $row.Name = $vm.Name
        $customattribs = $vm | select -ExpandProperty CustomFields
        $hash = @{}
        foreach ($attrib in $customattribs){
            $hash.add($attrib.key, $attrib.value)
            
            $row.($attrib.key) = $attrib.value
        }
        #$row.test_attr = $hash['test_attr']
        $Report += $row
    }
$report | Export-Csv "$exportfile" -NoTypeInformation