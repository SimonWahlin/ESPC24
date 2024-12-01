@description('Name of the key vault.')
param keyVaultName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('softDelete data retention days. It accepts >=7 and <=90.')
param softDeleteRetentionInDays int = 7

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enablePurgeProtection: true
    enableRbacAuthorization: true
    enabledForDiskEncryption: true
  }
}

output name string = keyVault.name
output id string = keyVault.id
output vaultUri string = keyVault.properties.vaultUri
