@description('Name that will be common for all resources created')
param systemName string

@description('Key-Value pairs representing custom app settings')
param appSettings object = {}

@allowed([
    'Standard_LRS'
    'Standard_GRS'
    'Standard_RAGRS'
    'Standard_ZRS'
    'Premium_LRS'
    'Premium_ZRS'
    'Standard_GZRS'
    'Standard_RAGZRS'
])
@description('Storage account SKU for dedicated storage account')
param storageAccountSku string = 'Standard_LRS'

@description('Number of days logs will be kept in log analytics. Valid values are 30-730')
param logRetentionInDays int = 90

@description('The workspace daily quota limit for ingestion. Set to 0 for no limit (default=0)')
param logDailyQuotaGb int = 0

@description('Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.')
param appInsightsSamplingPercentage int = 100

param tags object = {}
param location string = resourceGroup().location

// storing the name in a variable to easily be able to modify to naming standards
var functionAppName = systemName
var hostingPlanName = '${systemName}-plan'
var logAnalyticsName = '${systemName}-log'
var applicationInsightsName = '${systemName}-appin'
// systemName without any dashes is needed for storageaccount name since they don't accept dashes
var systemNameNoDash = replace(systemName, '-', '')
// Calculate a unique string based on the resource group
var uniqueStringRg = uniqueString(resourceGroup().id)
// Combine up to 17 chars from system name with 5 chars from unique string to hopefully get a unique name
var storageAccountName = toLower('${take(systemNameNoDash, 17)}${take(uniqueStringRg, 5)}sa')
// Use same naming as for storage account but with 'kv' on end.
var keyVaultName = toLower('${take(systemNameNoDash, 17)}${take(uniqueStringRg, 5)}kv')
var storageConnectionStringName = '${systemName}-connectionstring'
var appInsightsInstrumentationKeyName = '${systemName}-instrumentationkey'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: storageAccountName
    location: location
    sku: {
        name: storageAccountSku
    }
    kind: 'StorageV2'
    properties: {
        supportsHttpsTrafficOnly: true
        accessTier: 'Hot'
        allowBlobPublicAccess: false
        minimumTlsVersion: 'TLS1_2'
        allowSharedKeyAccess: true
    }
    tags: tags
}

resource hostingPlan 'Microsoft.Web/serverfarms@2020-12-01' = {
    name: hostingPlanName
    location: location
    kind: 'elastic'
    sku: {
        name: 'Y1'
    }
    properties: {
        reserved: false
    }
    tags: tags
}

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
    name: functionAppName
    location: location
    kind: 'functionapp'
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        enabled: true
        httpsOnly: true
        serverFarmId: hostingPlan.id
        clientCertEnabled: false
        siteConfig: {
            ftpsState: 'Disabled'
            minTlsVersion: '1.2'
            powerShellVersion: '~7'
            scmType: 'None'
        }
        containerSize: 1536 // not used any more, but portal complains without it
        
    }
    tags: tags
}

resource functionAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
    name: 'appsettings'
    parent: functionApp
    properties: union(appSettings, {
        // Add three settings to enable storing of funcitons keys in keyvault
        AzureWebJobsSecretStorageKeyVaultName: keyvault.name
        AzureWebJobsSecretStorageType: 'keyvault'
        AzureWebJobsSecretStorageKeyVaultConnectionString: ''
        // This is now a reference to our keyvault secret
        AzureWebJobsStorage: '@Microsoft.KeyVault(SecretUri=${secretStorageConnectionString.properties.secretUri})'
        WEBSITE_CONTENTSHARE: toLower(functionApp.name)
        // This is now a reference to our keyvault secret
        WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: '@Microsoft.KeyVault(SecretUri=${secretStorageConnectionString.properties.secretUri})'
        FUNCTIONS_EXTENSION_VERSION: '~3'
        // This is now a reference to our keyvault secret
        APPINSIGHTS_INSTRUMENTATIONKEY: '@Microsoft.KeyVault(SecretUri=${secretAppInsightsInstrumentationKey.properties.secretUri})'
        AzureWebJobsDisableHomepage: true
        FUNCTIONS_APP_EDIT_MODE: 'readonly'
        WEBSITE_RUN_FROM_PACKAGE: '1'
        FUNCTIONS_WORKER_RUNTIME: 'powershell'
        FUNCTIONS_WORKER_RUNTIME_VERSION: '~7'
        // Number of PowerShell processes that can run in each instance
        FUNCTIONS_WORKER_PROCESS_COUNT: 10
        // Number of PowerShell runspaces that can run in each process
        // Runspace concurrency has lower CPU overhead than processes but can cause problems with raceconditions with process-level contexts and state.
        // Use with caution.
        PSWorkerInProcConcurrencyUpperBound: 1
    })
}

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
    name: logAnalyticsName
    location: location
    properties: {
        sku: {
            name: 'PerGB2018'
        }
        retentionInDays: logRetentionInDays
        workspaceCapping: logDailyQuotaGb == 0 ? null : {
            dailyQuotaGb: logDailyQuotaGb
        }
    }
    tags: tags
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
    name: applicationInsightsName
    location: location
    kind: 'web'
    tags: union(tags, {
        // This creates a link that will get the proper portal experience
        'hidden-link:${resourceId('Microsoft.Web/sites', functionAppName)}': 'Resource'
    })
    properties: {
        Application_Type: 'web'
        Flow_Type: 'Bluefield'
        Request_Source: 'rest'
        SamplingPercentage: appInsightsSamplingPercentage
        WorkspaceResourceId: logAnalytics.id
    }
}

// Create a keyvault to hold function keys and app setings
resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
    name: keyVaultName
    location: location
    properties: {
        enabledForDeployment: false
        enabledForTemplateDeployment: false
        enabledForDiskEncryption: false
        tenantId: subscription().tenantId
        accessPolicies: [
            {
                // delegate secrets access to function app
                // tenantId: reference(functionApp.id,'2020-06-01','Full').identity.tenantId
                tenantId: functionApp.identity.tenantId
                objectId: functionApp.identity.principalId
                permissions: {
                    secrets: [
                        'get'
                        'list'
                        'set'
                    ]
                }
            }
        ]
        sku: {
            name: 'standard'
            family: 'A'
        }
    }
}

resource secretStorageConnectionString 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
    parent: keyvault
    name: storageConnectionStringName
    properties: {
        value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${listKeys(storageAccount.id, '2019-06-01').keys[0].value}'
    }
}

resource secretAppInsightsInstrumentationKey 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
    parent: keyvault
    name: appInsightsInstrumentationKeyName
    properties: {
        value: appInsights.properties.InstrumentationKey
    }
}

resource zipDeploy 'Microsoft.Web/sites/extensions@2020-09-01' = {
    parent: functionApp
    name: 'MSDeploy'
    properties: {
        packageUri: 'https://github.com/SimonWahlin/NewNameRepo/releases/download/v1.0.0/HelloWorld.zip'
    }
}

output FunctionAppName string = functionApp.name
output StorageAccountName string = storageAccountName
