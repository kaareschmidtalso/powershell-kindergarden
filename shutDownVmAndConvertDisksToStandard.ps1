#Shut down a VM and convert all disks to standard storage

#This script assume you are already logged in

#Fill these variables before running the script
#-----------------------
#name of subscription
$sub = "DONOTDELETE"

#name of resource group
$rg = "azureBackupSrvRG"

#Name of vm
$vmName = "DC1"
#-----------------------

#select subscription
Get-AzureRmSubscription -SubscriptionName $sub | Set-AzureRmContext

#get the vm
$vm = get-azurermvm -ResourceGroupName $rg -Name $vmName

#shut down the VM
$vm | Stop-AzureRmVM -Force

# Get all disks in the resource group of the VM
$vmDisks = Get-AzureRmDisk -ResourceGroupName $rg

# For disks that belong to the selected VM, convert to premium storage
foreach ($disk in $vmDisks)
{
    if ($disk.ManagedBy -eq $vm.Id)
    {
        $diskUpdateConfig = New-AzureRmDiskUpdateConfig –AccountType 'Standard_LRS'
        Update-AzureRmDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $rg `
        -DiskName $disk.Name
    }
}







#kare.schmidt@also.com