using './Demo-1.bicep'

param name = getSecret(readEnvironmentVariable('KeyVaultSubscriptionId'),keyVaultConfig.ResourceGroup,'myKeyVault', 'MySecret')
param location = readEnvironmentVariable('AzureRegion')
param allowedIpAddresses = [
  '193.182.233.197'
]
param private = true

var keyVaultConfig = loadJsonContent('KeyVault.json')
