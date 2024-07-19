### download https://raw.githubusercontent.com/lamw/vmware-scripts/master/powershell/VMKeystrokes.ps1 and unblock and import it
### install powercli
### connect to the vcenter

function start-to-safemode{
    param(
        [string]$vmname,
        [int]$bootDelay=5000
    )
    $vm = get-vm $vmname

    $vmbo = New-Object VMware.Vim.VirtualMachineBootOptions
    $vmbo.BootDelay = $bootDelay
    $vmcs = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmcs.BootOptions = $vmbo

    $VM.ExtensionData.ReconfigVM($vmcs)


    start-vm $vm

    1..25 | %{
    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "F8"
    start-sleep -milliseconds 50
    }

    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "KeyDown"
    start-sleep -milliseconds 50
    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "KeyEnter"

    1..25 | %{
    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "F8"
    start-sleep -milliseconds 50
    }

    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "KeyDown"
    start-sleep -milliseconds 50
    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "KeyDown"
    start-sleep -milliseconds 50
    Set-VMKeystrokes -VMName $vm.name -SpecialKeyInput "KeyEnter"

}
