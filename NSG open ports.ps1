login-azurermaccount


$nsg = Get-AzureRmNetworkSecurityGroup -Name loadtest2-nsg -ResourceGroupName loadtest2rg


Add-AzureRmNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg -Name steamserverbrowser `
    -Description "steamserverbrowser" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "100" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 27015

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name ark `
    -Description "ark" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "200" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 7777

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name "ark_raw_udp" `
    -Description "ark_raw_udp" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "300" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 7778

add-azurermnetworksecurityruleconfig -NetworkSecurityGroup $nsg -Name "ark_rcon" `
    -Description "ark_rcon" -Access "Allow" -Protocol * -Direction "Inbound" `
    -Priority "400" -SourceAddressPrefix "Internet" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 27020



Set-AzureRmNetworkSecurityGroup -NetworkSecurityGroup $nsg

