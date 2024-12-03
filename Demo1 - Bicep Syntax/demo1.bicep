metadata author = 'SimonWahlin'
metadata description = '''
This template will deploy a storage account

It is really cool, check it out!
'''

@description('The resource name')
param name string = 'espcdemosa'

@description('Use restricted network access')
param privateNetworking bool = true

param someConfig string?

@description('Required. Gets or sets the location of the resource. ')
param location string = resourceGroup().location

@description('Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.')
param allowedIpAddresses string[] = ['83.226.146.192']

@description('The resource name')
param containerNames string[] = ['espcdemo']

// example of ternary operatot, intentionally unused
#disable-next-line no-unused-vars
var ternary = 'this' == 'that' ? 'then do this' : 'else do that'

// example of ?? operator, interntionally unused
#disable-next-line no-unused-vars
var nullCheckConfig = someConfig ?? 'someconfigDefaultValue'

var networkConfig = privateNetworking == true ? {
  allowBlobPublicAccess: false
  allowCrossTenantReplication: false
  allowedCopyScope: 'PrivateLink'
} : {
  allowBlobPublicAccess: true
  allowCrossTenantReplication: true
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    ... networkConfig
    accessTier: 'Hot'
    allowSharedKeyAccess: false
    defaultToOAuthAuthentication: true
    minimumTlsVersion: 'TLS1_3'
    networkAcls: {
      defaultAction: privateNetworking ? 'Deny' : 'Allow'
      ipRules: empty(allowedIpAddresses) ? [] : map(allowedIpAddresses, (ip => {value: ip}))
    }
    supportsHttpsTrafficOnly: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = [
  for container in containerNames: {
  name: container
  parent: blobService
}]

output id string = storageAccount.id
output name string = storageAccount.name
output containers array = [for (item, index) in containerNames: blobContainer[index].name]
