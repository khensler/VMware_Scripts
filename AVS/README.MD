# AVS Related Scripts
## setVMStoragePolocy.ps1
This srcipt will loop through a comma seperated list of VMs in AVS and execute a run command to set the VSAN storage policy.  It requies the Azure CLI to be installed and already logged into your subscription.

This script requires these values at the top of the script:
- $resource_group = \<resource group>
- $cloud_name = \<cloud name>
- $storage_policy = \<storage policy name>
- $vms = \<comma seperated vm list>

## getCloudAdminUsage.ps1

This script will query the vCenter events database for all usage of cloudadmin@vsphere.local.  It will return the username, time of login, and the IP address where the loggin initiated from.  It requires VMware PowerCLI to be installed and connected to a vCenter.