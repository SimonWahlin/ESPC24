metadata name = 'Demo1-Storage-ARM-2'
metadata description = 'This template deploys a storage account with a key vault and a customer-managed key.'
metadata version = '1.0.0'
metadata owner = 'SimonWahlin'

@description('Name of the storage account.')
param storageAccountName string = 'espcdemostorage'

@secure()
#disable-next-line secure-parameter-default
param adminPrincipalId string = '69615b5e-8b26-430c-ae89-4e626f5ba240'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('softDelete data retention days. It accepts >=7 and <=90.')
@minValue(7)
@maxValue(90)
param softDeleteRetentionInDays int = 7

@description('The key size in bits. For example: 2048, 3072, or 4096 for RSA.')
@allowed([
  2048
  3072
  4096
])
param keySize int = 2048

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
      '${storageIdentity.id}': {}
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
        userAssignedIdentity: storageIdentity.id
      }
      services: {
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.KeyVault'
      keyvaultproperties: {
        keyvaulturi: keyVault.properties.vaultUri
        keyname: CMK.name
      }
    }
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource storageIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: '${storageAccountName}-mi'
  location: location
}

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: '${storageAccountName}-kv'
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

var keyVaultCryptoServiceEncryptionUser = 'e147488a-f6f5-4113-8e2d-b22465e65bf6'
resource keyVaultCryptoServiceEncryptionUserRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: keyVaultCryptoServiceEncryptionUser
}
resource keyVaultRbacAssignmentEncryptionUser 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVaultCryptoServiceEncryptionUserRole.id, keyVault.id, storageIdentity.id)
  scope: keyVault
  properties: {
    principalId: storageIdentity.properties.principalId
    roleDefinitionId: keyVaultCryptoServiceEncryptionUserRole.id
  }
}
var keyVaultCryptoServiceEncryptionOfficer = '14b46e9e-c2b7-41b4-b07b-48a6ebf60603'
resource keyVaultCryptoServiceEncryptionOfficerRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: keyVaultCryptoServiceEncryptionOfficer
}
resource keyVaultRbacAssignmentEncryptionOfficer 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVaultCryptoServiceEncryptionOfficerRole.id, keyVault.id, adminPrincipalId)
  scope: keyVault
  properties: {
    principalId: adminPrincipalId
    roleDefinitionId: keyVaultCryptoServiceEncryptionOfficerRole.id
  }
}

resource CMK 'Microsoft.KeyVault/vaults/keys@2024-04-01-preview' = {
  name: 'espcdemocmk'
  parent: keyVault
  properties: {
    keySize: keySize
    kty: 'RSA'
    keyOps: [
      'wrapKey'
      'unwrapKey'
    ]
  }
}

output storageAccountName string = storageAccount.name
output keyVaultName string = keyVault.name
output keyVaultUri string = keyVault.properties.vaultUri
output keyVaultCryptoServiceEncryptionUserRoleId string = keyVaultCryptoServiceEncryptionUserRole.id
output keyVaultCryptoServiceEncryptionOfficerRoleId string = keyVaultCryptoServiceEncryptionOfficerRole.id
