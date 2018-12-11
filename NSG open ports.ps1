
#-----------------------#
#Variables
$nsgName = "BackupNSG"

$RGName = "azureBackupSrvRG"

#-----------------------#

$nsg = Get-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $RGName

#Remove existing rules
$rules = Get-AzureRmNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg
foreach ($rule in $rules) {
    Remove-AzureRmNetworkSecurityRuleConfig -name $rule.name -NetworkSecurityGroup $nsg

}

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

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name DCOM `
    -Description "DCOM" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "400" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 135

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name TCP `
    -Description "TCP" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "500" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange "5718-5719"

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name DNS `
    -Description "DNS" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "600" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 53

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name Kerberos `
    -Description "kerberos" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "700" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 88

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name LDAP `
    -Description "LDAP" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "800" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 389

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name Netbios1 `
    -Description "Netbios1" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "900" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange "137-139"

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name netbios2 `
    -Description "Netbios2" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "910" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 445


Set-AzureRmNetworkSecurityGroup -NetworkSecurityGroup $nsg


