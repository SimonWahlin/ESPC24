@description('Required. Name of the site.')
param name string = 'simonw-espc-functionapp-avm'

@description('Key-Value pairs representing custom app settings')
param appSettings object = {}

param adminPrincipalId string = '69615b5e-8b26-430c-ae89-4e626f5ba240'

@description('Optional. Tags of the resources.')
param tags object = {}

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.')
param insightsSamplingPercentage int = 100

// name without any dashes is needed for storageaccount name since they don't accept dashes
var nameNoDash = replace(name, '-', '')
// Calculate a unique string based on the resource group
var uniqueStringRg = uniqueString(resourceGroup().id)
// Combine up to 17 chars from system name with 5 chars from unique string to hopefully get a unique name
var storageAccountName = toLower('${take(nameNoDash, 17)}${take(uniqueStringRg, 5)}sa')
// Use same naming as for storage account but with 'kv' on end.
var keyVaultName = toLower('${take(nameNoDash, 17)}${take(uniqueStringRg, 5)}kv')

module storageAccount 'br/public:avm/res/storage/storage-account:0.14.3' = {
  name: 'storageAccountDeployment'
  params: {
    name: storageAccountName
    location: location
    skuName: 'Standard_LRS'
    tags: tags
    networkAcls: {
      defaultAction: 'Allow'
    }
    fileServices: {
      shares: [
        {
          name: 'simonw-espc-functionapp-avm'
        }
      ]
    }
    roleAssignments: [
      {
        principalId: site.outputs.systemAssignedMIPrincipalId
        roleDefinitionIdOrName: 'Storage Blob Data Contributor'
      }
      {
        principalId: site.outputs.systemAssignedMIPrincipalId
        roleDefinitionIdOrName: 'Storage File Data SMB Share Contributor'
      }
      {
        principalId: adminPrincipalId
        roleDefinitionIdOrName: 'Storage Blob Data Contributor'
      }
      {
        principalId: adminPrincipalId
        roleDefinitionIdOrName: 'Storage File Data SMB Share Contributor'
      }
    ]
    secretsExportConfiguration: {
      keyVaultResourceId: vault.outputs.resourceId
      connectionString1: '${name}-storage-connectionstring'
    }
  }
}

module serverfarm 'br/public:avm/res/web/serverfarm:0.3.0' = {
  name: '${name}-farm'
  params: {
    name: '${name}-farm'
    kind: 'FunctionApp'
    skuName: 'Y1'
    skuCapacity: 0
    location: location
    tags: tags
  }
}

module site 'br/public:avm/res/web/site:0.11.1' = {
  name: '${name}-site'
  params: {
    name: name
    kind: 'functionapp'
    serverFarmResourceId: serverfarm.outputs.resourceId
    managedIdentities: {
      systemAssigned: true
    }
    siteConfig: {
      ftpsState: 'Disabled'
      powershellVersion: '7.4'
      scmType: 'None'
      minTlsCipherSuite: 'TLS_AES_128_GCM_SHA256'
      minimumElasticInstanceCount: 0
      remoteDebuggingEnabled: false
      vnetRouteAllEnabled: true
      use32BitWorkerProcess: false
      functionsRuntimeAdminIsolationEnabled: true
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ]
        supportCredentials: true
      }
    }
    containerSize: 1536
    location: location
    tags: union(tags, {
      'hidden-link: /app-insights-resource-id': appInsights.outputs.id
    })
  }
}

module siteAppSettings 'modules/appSettings.bicep' = {
  name: 'appSettings'
  params: {
    siteName: site.outputs.name
    keyVaultUri: vault.outputs.uri
    secretStorageConnectionStringUri: storageAccount.outputs.exportedSecrets['${name}-storage-connectionstring'].secretUri
    appSettings: appSettings
    // storageAccountName: storageAccount.outputs.name
    appInsightsConnectionString: appInsights.outputs.connectionString
  }
}

module workspace 'br/public:avm/res/operational-insights/workspace:0.9.0' = {
  name: '${name}-law'
  params: {
    name: '${name}-law'
    location: location
    tags: tags
  }
}

module appInsights './modules/appInsights.bicep' = {
  name: '${name}-appin'
  params: {
    name: '${name}-appin'
    workspaceResourceId: workspace.outputs.resourceId
    samplingPercentage: insightsSamplingPercentage
    tags: tags
  }
}

module appInsightsRBAC './modules/appInsights-rbac.bicep' = {
  name: 'appInsightsRBAC'
  params: {
    appInsightsName: appInsights.outputs.name
    role: 'Monitoring Metrics Publisher'
    principalIds: [
      site.outputs.systemAssignedMIPrincipalId
    ]
  }
}

module vault 'br/public:avm/res/key-vault/vault:0.10.2' = {
  name: '${name}-kv'
  params: {
    name: keyVaultName
    enableVaultForDeployment: false
    enableVaultForTemplateDeployment: false
    enableVaultForDiskEncryption: false
    roleAssignments: [
      {
        principalId: site.outputs.systemAssignedMIPrincipalId
        roleDefinitionIdOrName: 'Key Vault Secrets Officer'
      }
      {
        principalId: adminPrincipalId
        roleDefinitionIdOrName: 'Key Vault Secrets Officer'
      }
    ]
    enableSoftDelete: false
    enablePurgeProtection: false
    location: location
  }
}

