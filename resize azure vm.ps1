#resize azure vm

$resourcegroupName = "grafanademo"
$vmName = "grafana"


#List the VM sizes that are available on the hardware cluster where the VM is hosted.
Get-AzureRmVMSize -ResourceGroupName $resourcegroupName -VMName $vmName

#If the desired size is listed, run the following commands to resize the VM.
$vm = Get-AzureRmVM -ResourceGroupName $resourcegroupName -Name $vmName
$vm.HardwareProfile.VmSize = "Basic_A0"
Update-AzureRmVM -VM $vm -ResourceGroupName $resourcegroupName


#If the desired size is not listed, run the following commands to deallocate the VM, resize it, and restart the VM

Stop-AzureRmVM -ResourceGroupName $resourcegroupName -Name $vmname -Force
$vm = Get-AzureRmVM -ResourceGroupName $resourcegroupName -Name $vmname
$vm.HardwareProfile.VmSize = "<newVMSize>"
Update-AzureRmVM -VM $vm -ResourceGroupName $resourcegroupName
Start-AzureRmVM -ResourceGroupName $resourcegroupName -Name $vmname