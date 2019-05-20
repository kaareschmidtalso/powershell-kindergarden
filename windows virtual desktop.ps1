# windows virtual desktop

Import-Module AzureAD
$aadContext = Connect-AzureAD
$svcPrincipal = New-AzureADApplication -AvailableToOtherTenants $true -DisplayName "Windows Virtual Desktop Svc Principal"
$svcPrincipalCreds = New-AzureADApplicationPasswordCredential -ObjectId $svcPrincipal.ObjectId


$myTenantName = "alsoacademy"

Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"
New-RdsRoleAssignment -RoleDefinitionName "RDS Owner" -ApplicationId $svcPrincipal.AppId -TenantName $myTenantName

$creds = New-Object System.Management.Automation.PSCredential($svcPrincipal.AppId, (ConvertTo-SecureString $svcPrincipalCreds.Value -AsPlainText -Force))
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -Credential $creds -ServicePrincipal -AadTenantId $aadContext.TenantId.Guid

$svcPrincipalCreds.Value
#password = +lE0xW/PQdhuwhZnjAhhUeDT5AQhyMbAp+EBxo67ixM=

$aadContext.TenantId.Guid
#tenant ID = fff86db3-851d-431d-a97a-a4434afc4a06

$svcPrincipal.AppId
#application ID = 8a303c08-633f-4d59-a13e-25fe172f7e1c



