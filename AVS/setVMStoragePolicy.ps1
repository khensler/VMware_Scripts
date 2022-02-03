$resource_group = <resource group>
$cloud_name = <cloud name>
$storage_policy = <stroage policy name>
$vms = <comma seperated vm list>
$vms = $vms.split(",")
foreach ($vm in $vms){
	$vm = $vm.trim()
	$execname = "set-storage-policy-$vm"
	az vmware script-execution create --name $execname --resource-group $resource_group --private-cloud $cloud_name --script-cmdlet-id "Microsoft.AVS.Management/3.0.51/Set-AvsVMStoragePolicy" --timeout P0Y0M0DT0H60M60S --parameter name=VMName type=Value value=$vm --parameter name=StoragePolicyName type=Value value=$storage_policy
}