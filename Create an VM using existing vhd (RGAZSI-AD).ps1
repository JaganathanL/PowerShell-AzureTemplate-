#Create an VM using existing .vhd

$ResourceGroupName = "RGAZSI-ADSERVICES"

$Location = "southindia"

$VMName = "AZSINTSADCPRD01"

$OSDiskUri = "https://ngpdsistoracc.blob.core.windows.net/vhds/AZSINTSADCPRD0120170226100656.vhd"

$VMSize = "Standard_D1_v2"

$OSDiskName = $VMName

$VMResourceGroupName ="RGAZSI-ADSERVICES"

#$VMAvailabilitySetName = "tstclone-AvailabilitySet"

$SubnetName = "NGPDSIADSN"

$InterfaceName = "azsintsadcprd01964"

$VNetName = "NGPDSIVNET"

$VNetResourceGroupName = "NGPDSIRG"                

#$PublicIP = "tstclone-publicip"

$Subnet = Get-AzureRMVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix 10.1.1.0/27

$VNet = Get-AzureRMVirtualNetwork -Name $VNetName  -ResourceGroupName $ResourceGroupName -location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

#$MyPublicIP = New-AzureRMPublicIPAddress -Name $PublicIP -ResourceGroupName $ResourceGroupName -Location $location -AllocationMethod Dynamic

$Interface  = Get-AzureRMNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $VNet.subnets[0].Id

#$AvailabilitySet = New-AzureRmAvailabilitySet -ResourceGroupName $ResourceGroupName -Name $VMAvailabilitySetName -Location $Location

$VirtualMachine  = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize

$VirtualMachine  = Add-AzureRMVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id

$VirtualMachine  = Set-AzureRMVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption Attach -Windows

New-AzureRMVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine





