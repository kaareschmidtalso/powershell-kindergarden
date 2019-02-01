#Start all VMs in a resource group

#-----------------------#
#Variables
$RGName = "azureBackupSrvRG"

#-----------------------#

$VMs = get-azurermvm -ResourceGroupName $RGName


Workflow Start-VMs
{
    foreach -parallel ($vm in $VMs)
        {
            start-azurermvm -name $vm.Name -ResourceGroupName $vm.ResourceGroupName
        }
}