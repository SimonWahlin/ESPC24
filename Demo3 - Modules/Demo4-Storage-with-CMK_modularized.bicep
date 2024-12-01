metadata name = 'Demo1-Storage-ARM-2'
metadata description = 'This template deploys a storage account with a key vault and a customer-managed key.'
metadata version = '1.0.0'
metadata owner = 'SimonWahlin'

@description('Name of the storage account.')
param storageAccountName string = 'espcdemostorage'

@secure()
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

module storage 'Modules/storage.bicep'= {
  name: 'storage'
  params: {
    keyName: CMK.name
    keyVaultUri: vault.outputs.vaultUri
    storageIdentityId: storageIdentity.id
  }
}

resource storageIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: '${storageAccountName}-mi'
  location: location
}

module vault 'Modules/KeyVault.bicep' = {
  name: 'vault'
  params: {
    keyVaultName: '${storageAccountName}-kv'
    softDeleteRetentionInDays: softDeleteRetentionInDays
  }
}

module StorageAccountKvCryptoUser 'Modules/keyVault-Rbac.bicep' = {
  name: 'StorageAccountKvCryptoUser'
  params: {
    keyVaultName: vault.outputs.name
    principalId: storageIdentity.properties.principalId
    principalObjectId: storageIdentity.id
    role: 'Key Vault Crypto Service Encryption User'
  }
}
module AdminKvCryptoOfficer 'Modules/keyVault-Rbac.bicep' = {
  name: 'AdminKvCryptoOfficer'
  params: {
    keyVaultName: vault.outputs.name
    principalId: adminPrincipalId
    principalObjectId: adminPrincipalId
    role: 'Key Vault Crypto Officer'
  }
}

/* Alternative way to assign roles
  module KVRoleAssingments 'Modules/keyVault-Rbac2.bicep' = {
    name: 'KVRoleAssingments'
    params: {
      roleAssignments: [
        {
          principalId: adminPrincipalId
          roleDefinitionIdOrName: 'Key Vault Crypto Officer'
        }
        {
          principalId: storageIdentity.properties.principalId
          roleDefinitionIdOrName: 'Key Vault Crypto Officer'
        }
      ]
      targetResourceName: vault.outputs.name
    }
  }
*/

module CMK 'Modules/keyVault-Key.bicep' = {
  name: 'espcdemocmk'
  params: {
    keyName: 'espcdemocmk'
    keyVaultName: vault.outputs.name
    keySize: keySize
  }
}

output storageAccountName string = storage.outputs.name
output keyVaultName string = vault.outputs.name
output keyVaultUri string = vault.outputs.vaultUri
