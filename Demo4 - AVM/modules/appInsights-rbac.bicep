param appInsightsName string

param principalIds string[]

param role ('Monitoring Metrics Publisher' | 'Application Insights Component Contributor' | 'Application Insights Snapshot Debugger' | 'Data Purger' | 'Monitoring Contributor')

var builtInRoleNames = {
  'Monitoring Metrics Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3913510d-42f4-4e42-8a64-420c390055eb'
  )
  'Application Insights Component Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ae349356-3a1b-4a5e-921d-050484c6347e'
  )
  'Application Insights Snapshot Debugger': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '08954f03-6346-4c2e-81c0-ec3a5cfae23b'
  )
  'Data Purger': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '150f5e0c-0603-4f03-8c7f-cf70034c4e90'
  )
  'Monitoring Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
  )
}

resource target 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for principalId in principalIds: {
  name: guid(builtInRoleNames[role], target.id, principalId)
  scope: target
  properties: {
    principalId: principalId
    roleDefinitionId: builtInRoleNames[role]
  }
}]
