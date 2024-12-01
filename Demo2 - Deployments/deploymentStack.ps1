Push-Location -Path '/Users/simon/Library/CloudStorage/OneDrive-SimonW/Sessions/ESPC/2024/BicepZeroToHero/Demo2 - Deployments'

New-AzResourceGroupDeployment -ResourceGroupName 'ESPC-Demo2' -TemplateFile './storageStack.bicep'

$Param = Get-Content './storageStack.stack.json' -Raw | ConvertFrom-Json -AsHashtable

New-AzResourceGroupDeploymentStack -ResourceGroupName 'ESPC-Demo2' -TemplateFile './storageStack.bicep' @Param

Remove-AzResourceGroupDeploymentStack -ResourceGroupName 'ESPC-Demo2' -Name $Param['Name'] -ActionOnUnmanage 'DeleteAll' -Force

Pop-Location