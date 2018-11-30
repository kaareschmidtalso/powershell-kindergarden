# 1. You need to login to the Azure Rm Account

#Login-AzureRmAccount

# 2. The script will query the Subscriptions that the login account has access and will promt the user to select the target Subscription from the drop down list
 
#$subscription = Get-AzureRmSubscription | Out-GridView -Title "Select a Subscription" -PassThru
#Select-AzureRmSubscription -SubscriptionId $subscription.Id

# 3. The script will query the available VMs and promt to select the target VM from the VM list
 
$vm = Get-AzureRmVM | Out-GridView -Title "Select the Virtual Machine to add Data Disks to" -PassThru

# 4. I set the storage type based on the OS disk. If you want to spesify somehting else you can cahnge this to: $storageType = StandardLRS or PremiumLRS etc.

$storageType = $VM.StorageProfile.OsDisk.ManagedDisk.StorageAccountType

# 5. The script will promt for disk size, in GB

$diskSizeinGB = Read-Host "Enter Size for each Data Disk in GB"

$diskConfig = New-AzureRmDiskConfig -AccountType $storageType -Location $vm.Location -CreateOption Empty -DiskSizeGB $diskSizeinGB

# 6. Enter how many data disks you need to create
 
$diskquantity = Read-Host "How many disks you need to create?"

for($i = 1; $i -le $diskquantity; $i++)
{
$diskName = $vm.Name + "-DataDisk-a" + $i.ToString()
$DataDisk = New-AzureRmDisk -DiskName $diskName -Disk $diskConfig -ResourceGroupName $vm.ResourceGroupName
$lun = $i - 1
Add-AzureRmVMDataDisk -VM $vm -Name $DiskName -CreateOption Attach -ManagedDiskId $DataDisk.Id -Lun $lun
}

Update-AzureRmVM -VM $vm -ResourceGroupName $vm.ResourceGroupName