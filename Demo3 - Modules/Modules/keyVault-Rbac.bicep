import {builtInRoleNames} from 'builtInRoles.bicep'

param keyVaultName string

param principalId string

param principalObjectId string

@allowed([
  'Key Vault Crypto Service Encryption User'
  'Key Vault Crypto Officer'
])
param role string

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' existing = {
  name: keyVaultName
}

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: builtInRoleNames[role]
}

resource roleAssingment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(roleDefinition.id, keyVault.id, principalObjectId)
  scope: keyVault
  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinition.id
  }
}

output name string = roleAssingment.name
output id string = roleAssingment.id
