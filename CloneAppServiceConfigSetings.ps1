Login-AzureRmAccount
# If you have multiple subscriptions, you may need to set your context.
Set-AzureRmContext -Subscription 'SubscriptionName'

$myResourceGroup = 'ResourceGroup'
$mySite = 'OldAppService'
$myResourceGroup2 = 'ResourceGroup'
$mySite2 = 'NewappService'

$props = (Invoke-AzureRmResourceAction -ResourceGroupName $myResourceGroup `
        -ResourceType Microsoft.Web/sites/Config -Name $mySite/appsettings `
        -Action list -ApiVersion 2015-08-01 -Force).Properties

$hash = @{}
$props | Get-Member -MemberType NoteProperty | % { $hash[$_.Name] = $props.($_.Name) }

Set-AzureRMWebApp -ResourceGroupName $myResourceGroup2 `
        -Name $mySite2 -AppSettings $hash