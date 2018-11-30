$vmName = 'nv6test'
$resourceGroupName = 'nv6test'
$vm = Get-AzureRmVm -Name $vmName -ResourceGroupName $resourceGroupName

$credential = Get-Credential

$extensionParams = @{
    'VMName' = $vmName
    'Username' = $Credential.UserName
    'Password' = $Credential.GetNetworkCredential().Password
    'ResourceGroupName' = $resourceGroupName
    'Name' = 'AdminPasswordReset'
    'Location' = $vm.Location
}

$result = Set-AzureRmVMAccessExtension @extensionParams

