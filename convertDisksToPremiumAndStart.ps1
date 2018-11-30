# Convert disks of a server to premium storage before starting it

#This script assume you are already logged in

#Fill these variables before running the script
#-----------------------
#name of subscription
$sub = "DONOTDELETE"

#name of resource group
$rg = "testvm3489"

#Name of vm
$vmName = "testvm234"
#-----------------------

#select subscription
Get-AzureRmSubscription -SubscriptionName $sub | Set-AzureRmContext

#get the vm
$vm = get-azurermvm -ResourceGroupName $rg -Name $vmName

# Get all disks in the resource group of the VM
$vmDisks = Get-AzureRmDisk -ResourceGroupName $rg

# For disks that belong to the selected VM, convert to premium storage
foreach ($disk in $vmDisks)
{
    if ($disk.ManagedBy -eq $vm.Id)
    {
        $diskUpdateConfig = New-AzureRmDiskUpdateConfig –AccountType 'Premium_LRS'
        Update-AzureRmDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $rg `
        -DiskName $disk.Name
    }
}

$vm | Start-AzureRmVM








#kare.schmidt@also.com