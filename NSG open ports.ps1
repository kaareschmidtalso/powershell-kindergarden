login-azurermaccount

#-----------------------#
#Variables
$nsgName = "BackupNSG"

$RGName = "azureBackupSrvRG"

#-----------------------#

$nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $RGName


Add-AzureRmNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg -Name ssl `
    -Description "ssl" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "100" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 443

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name 6049 `
    -Description "6049" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "200" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 6049

    add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name 3389 `
    -Description "3389" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "300" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389


Set-AzureRmNetworkSecurityGroup -NetworkSecurityGroup $nsg

Remove-AzureRmNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg

