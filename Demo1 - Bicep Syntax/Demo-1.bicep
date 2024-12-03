targetScope = 'resourceGroup'

metadata author = 'SimonWahlin'
metadata version = '1.0.0'
metadata moduleDescription = 'Deploys a storage account'

@minLength(3)
@maxLength(24)
@description('The resource name')
param name string = 'espcdemosa'

@description('Sets the location of the resource.')
param location string = resourceGroup().location

@description('Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.')
param allowedIpAddresses string[] = [
  '193.182.233.197'
]
var ipRules = map(allowedIpAddresses, ip => { value: ip })

param private bool = false
var privateConfig = private == true
  ? {
      allowedCopyScope: 'PrivateLink'
      publicNetworkAccess: 'Disabled'
    }
  : {}

// @description('Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.')
// param allowedIpAddressesObject AllowedIpAddressesObject[] = [
//   {
//     value: '193.182.233.197'
//   }
// ]
// type AllowedIpAddressesObject = { value: string }

resource myStorage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    ...privateConfig
    accessTier: 'Hot'
    allowSharedKeyAccess: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Deny'
      ipRules: ipRules
    }
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: myStorage
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: 'espcdemo'
  parent: blobService
}

output id string = myStorage.id
output name string = myStorage.name
