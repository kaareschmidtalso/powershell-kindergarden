#copy vm

#variables
$resourceGroupName = 'CADtestRG2'
$vmName = 'Cadtestvm'
$location = 'westeurope'
$snapshotName = 'mySnapshot'
$destinationResourceGroup = 'CADtestCopyRG'



#Get VM object
$vm = Get-AzureRmVM -Name $vmName `
   -ResourceGroupName $resourceGroupName

#Get OS disk name

$disk = Get-AzureRmDisk -ResourceGroupName $resourceGroupName `
  -DiskName $vm.StorageProfile.OsDisk.Name

  #Create snapshot config
  $snapshotConfig =  New-AzureRmSnapshotConfig `
  -SourceUri $disk.Id `
  -OsType Windows `
  -CreateOption Copy `
  -Location $location 

  #Take snapshot

  $snapShot = New-AzureRmSnapshot `
   -Snapshot $snapshotConfig `
   -SnapshotName $snapshotName `
   -ResourceGroupName $resourceGroupName

   #Create destination Ressource group
    New-AzureRmResourceGroup -Location $location `
   -Name $destinationResourceGroup

#set the OS disk name for new VM
$osDiskName = 'myOsDisk'

#create the managed disk
$osDisk = New-AzureRmDisk -DiskName $osDiskName -Disk `
    (New-AzureRmDiskConfig  -Location $location -CreateOption Copy `
    -SourceResourceId $snapshot.Id) `
    -ResourceGroupName $destinationResourceGroup


    #create subnet
    $subnetName = 'mySubNet'
$singleSubnet = New-AzureRmVirtualNetworkSubnetConfig `
   -Name $subnetName `
   -AddressPrefix 10.0.0.0/24


#Create Vnet
$vnetName = "myVnetName"
$vnet = New-AzureRmVirtualNetwork `
   -Name $vnetName -ResourceGroupName $destinationResourceGroup `
   -Location $location `
   -AddressPrefix 10.0.0.0/16 `
   -Subnet $singleSubnet


#create NSG and RDP rule
$nsgName = "myNsg"

$rdpRule = New-AzureRmNetworkSecurityRuleConfig -Name myRdpRule -Description "Allow RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389
$nsg = New-AzureRmNetworkSecurityGroup `
   -ResourceGroupName $destinationResourceGroup `
   -Location $location `
   -Name $nsgName -SecurityRules $rdpRule


#Create public IP
$ipName = "myIP"
$pip = New-AzureRmPublicIpAddress `
   -Name $ipName -ResourceGroupName $destinationResourceGroup `
   -Location $location `
   -AllocationMethod Dynamic


#Create NIC
$nicName = "myNicName"
$nic = New-AzureRmNetworkInterface -Name $nicName `
   -ResourceGroupName $destinationResourceGroup `
   -Location $location -SubnetId $vnet.Subnets[0].Id `
   -PublicIpAddressId $pip.Id `
   -NetworkSecurityGroupId $nsg.Id

#set new vm sizr and name VM
$vmName = "CADtestCopyVM"
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_NV6"


#add NIC to config
$vm = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id


#Add OS disk to config
$vm = Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $osDisk.Id -StorageAccountType Standard_LRS `
    -DiskSizeInGB 128 -CreateOption Attach -Windows


#Create the new VM with the config
New-AzureRmVM -ResourceGroupName $destinationResourceGroup -Location $location -VM $vm