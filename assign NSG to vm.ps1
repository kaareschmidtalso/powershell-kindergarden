login-azurermaccount


#-----------------------#
#Variables

$nsgName = "BackupNSG"

$RGName = "azureBackupSrvRG"

$VMName = "DC1"
#-----------------------#

#Get NSG
$nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $RGName

#Get VM
$VM = get-azurermvm -ResourceGroupName $RGName -Name $VMName

#Get NIC
$vmNIC = Get-AzureRmNetworkInterface | Where-Object {$_.Id -eq $vm.NetworkProfile.NetworkInterfaces[0].Id}

#Add the nsg to the NIC configuration
$vmNIC.NetworkSecurityGroup = $nsg

#Apply the configuration to the NIC
$vmNIC | Set-AzureRmNetworkInterface

