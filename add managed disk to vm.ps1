$rgName = 'hddtest'
$vmName = 'hddtestvm'
$location = 'west europe' 
$storageType = 'StandardLRS'
$dataDiskName = $vmName + '_datadisk8'
$lun = '7'

$diskConfig = New-AzureRmDiskConfig -SkuName $storageType -Location $location -CreateOption Empty -DiskSizeGB 15
$dataDisk1 = New-AzureRmDisk -DiskName $dataDiskName -Disk $diskConfig -ResourceGroupName $rgName

$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName 
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -CreateOption Attach -ManagedDiskId $dataDisk1.Id -Lun $lun

Update-AzureRmVM -VM $vm -ResourceGroupName $rgName