@description('The resource name')
param name string

@description('Resource Id of the log analytics workspace which the data will be ingested to. This property is required to create an application with this API version. Applications from older versions will not have this property.')
param workspaceResourceId string

@description('Tags for the resource')
param tags object = {}

@description('Resource location')
param location string = resourceGroup().location

@description('Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.')
param samplingPercentage int = 100

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  kind: 'web'
  tags: tags
  properties: {
      Application_Type: 'web'
      Flow_Type: 'Bluefield'
      Request_Source: 'rest'
      SamplingPercentage: samplingPercentage
      WorkspaceResourceId: workspaceResourceId
      DisableLocalAuth: true
  }
}

output id string = appInsights.id
output name string = appInsights.name
output instrumentationKey string = appInsights.properties.InstrumentationKey
output connectionString string = appInsights.properties.ConnectionString
