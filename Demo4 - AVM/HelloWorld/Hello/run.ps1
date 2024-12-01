using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$ResponseBody = @(
    '######################## REQUEST ############################'
    $Request | ConvertTo-Json
    '######################## ENVIRONMENT ########################'
    Get-ChildItem Env: | Foreach-Object { '{0,-50} = {1}' -f $_.key, $_.value }
) -join [environment]::NewLine

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $ResponseBody
})
