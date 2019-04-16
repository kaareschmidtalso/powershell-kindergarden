

$ResourceGroup = 'aadtest2'
$VMname = 'aadtestvm2'

New-AzResourceGroupDeployment -Name "DependencyAgent" -ResourceGroupName $ResourceGroup -TemplateFile ".\dependency-agent.json" -vmName $VMname