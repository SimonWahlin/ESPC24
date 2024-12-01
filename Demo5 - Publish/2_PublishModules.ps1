Push-Location -Path '/Users/simon/Library/CloudStorage/OneDrive-SimonW/Sessions/ESPC/2024/BicepZeroToHero/Demo5 - Publish'
# ACR AZ CLI
$loginServer = az acr show `
--resource-group "experiment-shared-rg" `
--name "biceptraining" `
--query "loginServer" `
-o "tsv"

az bicep publish --file "storage.bicep" `
--target "br:$loginServer/bicep/modules/storage:v1" `
--documentation-uri "https://www.contoso.com/exampleregistry.html"

az bicep publish --file "storage.bicep" `
--target "br:$loginServer/bicep/modules/storage:v2" `
--documentation-uri "https://www.contoso.com/exampleregistry.html" `
--with-source

az acr repository update --name "biceptraining" `
--image "br:$loginServer/bicep/modules/storage:v2" `
--write-enabled "false" --delete-enabled "false"

# ACR AZ PowerShell
$loginServer = Get-AzContainerRegistry -ResourceGroupName "experiment-shared-rg" -Name "biceptraining" | Select-Object -ExpandProperty LoginServer
Publish-AzBicepModule -FilePath "storage.bicep" -Target "br:$loginServer/bicep/modules/storage:v1" -DocumentationUri "https://www.contoso.com/exampleregistry.html"
Publish-AzBicepModule -FilePath "storage.bicep" -Target "br:$loginServer/bicep/modules/storage:v2" -DocumentationUri "https://www.contoso.com/exampleregistry.html" -WithSource

Update-AzContainerRegistryTag -Registry "biceptraining" -RepositoryName "bicep/modules/storage" -Name "v1" -DeleteEnabled $true -WriteEnabled $true
Update-AzContainerRegistryRepository -Registry "biceptraining" -Name "bicep/modules/storage" -WriteEnabled $true -DeleteEnabled $true

Remove-AzContainerRegistryRepository -Registry "biceptraining" -Name "bicep/modules/storage"

# Template Specs AZ CLI
az ts create --resource-group "experiment-shared-rg" --name "storage" --version "1.0" --template-file "storage.bicep" --location "SwedenCentral"
az ts delete --resource-group "experiment-shared-rg" --name "storage" --version "1.0"

# Template Specs AZ PowerShell
New-AzTemplateSpec -ResourceGroupName "experiment-shared-rg" -Name "storage" -Version "1.0" -TemplateFile "storage.bicep" -Location "SwedenCentral"
Remove-AzTemplateSpec -ResourceGroupName "experiment-shared-rg" -Name "storage" -Version "1.0"

Pop-Location