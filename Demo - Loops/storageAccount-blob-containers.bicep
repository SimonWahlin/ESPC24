param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storageAccountName
}

resource storageAccountBlobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource storageAccountContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = [
  for container in blobContainers: {
  parent: storageAccountBlobService
  name: container.name
  properties: {
    publicAccess: container.publicAccess
    immutableStorageWithVersioning: {
      enabled: container.immutableStorageWithVersioning
    }
  }
}]


param blobContainers blobContainerType[]

type blobContainerType = {
  name: string
  publicAccess: ('Blob' | 'Container' | 'None')
  immutableStorageWithVersioning: bool
}
