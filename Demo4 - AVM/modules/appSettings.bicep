@description('The name of the site to deploy the function app settings to')
param siteName string

@description('The KeyVault URI for the KeyVault to store the web job secrets in')
param keyVaultUri string

@description('The KeyVault secretUri for the AzureWebJobsStorage connection string')
#disable-next-line secure-secrets-in-params
param secretStorageConnectionStringUri string

@description('The connection string for the Application Insights instance')
param appInsightsConnectionString string

@description('Key-Value pairs representing custom app settings')
param appSettings object = {}

// @description('Name of storage account used for AzureWebJobsStorage')
// param storageAccountName string = ''

resource site 'Microsoft.Web/sites@2024-04-01' existing = {
  name: siteName
}
resource functionAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  name: 'appsettings'
  parent: site
  properties: union(appSettings, {
      // Add two settings to enable storing of funcitons keys in keyvault
      AzureWebJobsSecretStorageType: 'keyvault'
      AzureWebJobsSecretStorageKeyVaultUri: keyVaultUri
      // This is now a reference to our keyvault secret
      AzureWebJobsStorage: '@Microsoft.KeyVault(SecretUri=${secretStorageConnectionStringUri})'
      // AzureWebJobsStorage__blobServiceUri: 'https://${storageAccountName}.blob.${environment().suffixes.storage}'
      // AzureWebJobsStorage__queueServiceUri: 'https://${storageAccountName}.queue.${environment().suffixes.storage}'
      // AzureWebJobsStorage__tableServiceUri: 'https://${storageAccountName}.table.${environment().suffixes.storage}'
      WEBSITE_CONTENTSHARE: toLower(siteName)
      // This is now a reference to our keyvault secret
      WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: '@Microsoft.KeyVault(SecretUri=${secretStorageConnectionStringUri})'
      // WEBSITE_SKIP_CONTENTSHARE_VALIDATION: 1
      FUNCTIONS_EXTENSION_VERSION: '~4'
      APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsConnectionString
      APPLICATIONINSIGHTS_AUTHENTICATION_STRING: 'Authorization=AAD'
      AzureWebJobsDisableHomepage: true
      FUNCTIONS_APP_EDIT_MODE: 'readonly'
      WEBSITE_RUN_FROM_PACKAGE: '1'
      FUNCTIONS_WORKER_RUNTIME: 'powershell'
      FUNCTIONS_WORKER_RUNTIME_VERSION: '7.4'
      functionsRuntimeAdminIsolationEnabled: true
      // Number of PowerShell processes that can run in each instance
      FUNCTIONS_WORKER_PROCESS_COUNT: 10
      // Number of PowerShell runspaces that can run in each process
      // Runspace concurrency has lower CPU overhead than processes but can cause problems with raceconditions with process-level contexts and state.
      // Use with caution.
      PSWorkerInProcConcurrencyUpperBound: 1
  })
}
