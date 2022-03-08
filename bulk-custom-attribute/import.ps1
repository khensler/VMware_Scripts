$fname = $args[0]
$items = import-csv $fname

#Check and create custom properties

foreach ($prop in $data[0].psobject.properties){
    if ($prop.Name -ne "Name"){
        if (Get-CustomAttribute -TargetType VirtualMachine -Name $prop.Name){
            if ($null -eq (Get-CustomAttribute -TargetType VirtualMachine -Name $prop.Name -ErrorAction SilentlyContinue)){
                New-CustomAttribute -TargetType VirtualMachine -Name $prop.Name
            }
        }
        Set-Annotation -Entity $vm -CustomAttribute $prop.Name -Value $prop.value
    }
}

#Set properties

foreach ($item in $items){
    $vm = get-vm -Name $item.name
    foreach ($prop in $item.psobject.properties){
        if ($prop.Name -ne "Name"){
            Set-Annotation -Entity $vm -CustomAttribute $prop.Name -Value $prop.value
        }
        
    }
}