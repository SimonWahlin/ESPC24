resource biceptraining 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: 'biceptraining'
  sku: {
    name: 'Standard'
  }
  location: 'swedencentral'
  tags: {}
  properties: {
    adminUserEnabled: false
    policies: {
      azureADAuthenticationAsArmPolicy: {
        status: 'enabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    anonymousPullEnabled: true
  }
}
