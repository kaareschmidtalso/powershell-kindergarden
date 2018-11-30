#script for finding untagged ressources in a subscription. - By Kåre Schmidt
#Run each command one at a time in Powershell, Powershell ISE, Visual Studio or VS Code
#In ISE and VS Code you can run one line at a time with F8

#First find all subscriptions
Get-AzureRmSubscription | Format-Table name, state, id

#Select a subscription to work on
Select-AzureRmSubscription -SubscriptionName "DONOTDELETE"

#Variables - edit the file path if you want it elsewhere
$ressources = Get-AzureRmResource
$filepath = "c:\temp\out.txt"

#find untagged ressources and put them in the $ressources object
foreach ($ressource in $ressources)
    {
        if ($ressource.Tags -eq $null)
            {
                echo $ressource.Name, $ressource.ResourceType
            }

    }

#Output to file
$ressources | Format-Table name, ResourceType, ResourceGroupName | Out-File -FilePath $filepath

#open notepad to view the file
notepad $filepath