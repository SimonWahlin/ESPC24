@description('Set the minimum TLS version to be permitted on requests to storage. The default interpretation is TLS 1.0 for this property.')
param minimumTlsVersion ('TLS1_0' | 'TLS1_1' | 'TLS1_2' | 'TLS1_3')


@description('Required for storage accounts where kind = BlobStorage. The access tier is used for billing. The \'Premium\' access tier is the default value for premium block blobs storage account type and it cannot be changed for the premium block blobs storage account type.')
param accessTier string = 'Cold'

resource espcdemostorage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'espcdemosa'
  location: 'swedencentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: true
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: minimumTlsVersion
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    accessTier: accessTier
  }
}
