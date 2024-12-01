@description('Name of the key vault.')
param keyVaultName string

@description('Name of the key.')
param keyName string

@description('The key size in bits. For example: 2048, 3072, or 4096 for RSA.')
@allowed([
  2048
  3072
  4096
])
param keySize int = 2048

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' existing = {
  name: keyVaultName
}

resource CMK 'Microsoft.KeyVault/vaults/keys@2024-04-01-preview' = {
  name: keyName
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
