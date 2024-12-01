New-AzResourceGroupDeployment -ResourceGroupName 'ESPC-Demo4' -TemplateFile 'Functions-AVM.bicep'

# Compress-Archive -Path './HelloWorld/*' -CompressionLevel Fastest -DestinationPath ./HelloWorldApp.zip

az functionapp deployment source config-zip -g 'ESPC-Demo4' -n 'simonw-espc-functionapp-avm' --src 'HelloWorldApp.zip'