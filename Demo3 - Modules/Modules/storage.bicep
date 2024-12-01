@description('Name of the storage account.')
param storageAccountName string = 'espcdemostorage'

param storageIdentityId string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The Uri of KeyVault.')
param keyVaultUri string

@description('The name of KeyVault key.')
param keyName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${storageIdentityId}': {}
    }
  }
  properties: {
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    encryption: {
      identity: {
        userAssignedIdentity: storageIdentityId
      }
      services: {
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.KeyVault'
      keyvaultproperties: {
        keyvaulturi: keyVaultUri
        keyname: keyName
      }
    }
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

output name string = storageAccount.name
output id string = storageAccount.id
