metadata description = '''
// Contains functions to assign built-in roles to a target resource.
// Example of template using this module:

import {builtInRoleNames, resolveRoleDefinitionId, RoleAssignment} from 'builtInRoles.bicep'
@description('Array of role assignments to create.')
param roleAssignments RoleAssignment[]

@description('The name of the target resource to assign the role to.')
param targetResourceName string

resource targetResource '<resourceType>@<apiVersion>' existing = {
  name: targetResourceName
}

resource keyVault_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for (roleAssignment, index) in (resolveRoleDefinitionId(builtInRoleNames, roleAssignments) ?? []): {
    name: roleAssignment.?name ?? guid(targetResource.id, roleAssignment.principalId, roleAssignment.roleDefinitionId)
    properties: {
      roleDefinitionId: roleAssignment.roleDefinitionId
      principalId: roleAssignment.principalId
      description: roleAssignment.?description
      principalType: roleAssignment.?principalType
      condition: roleAssignment.?condition
      conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
      delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
    }
    scope: targetResource
  }
]
'''

/*
# PowerShell script to generate the built-in role names variable
$Roles = Get-AzRoleDefinition
$Roles | Where-Object {$_.IsCustom -eq $false} | Foreach-Object {$RoleNameType = @()} {
$RoleName = $_.Name -match ' ' ? "'$($_.Name)'" : $_.Name
$RoleNameType += "'$_.Name'"
@"
  ${RoleName}: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '$($_.Id)'
  )
"@
} {"// $($RoleNameType -join ' | ')"} | Set-Clipboard
*/

@export()
var builtInRoleNames = {
  AcrPush: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8311e382-0749-4cb8-b61a-304f252e45ec'
  )
  'API Management Service Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '312a565d-c81f-4fd8-895a-4e21e48d571c'
  )
  AcrPull: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7f951dda-4ed3-4680-a7ca-43fe172d538d'
  )
  AcrImageSigner: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6cef56e8-d556-48e5-a04f-b8e64114680f'
  )
  AcrDelete: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c2f4ef07-c644-48eb-af81-4b1b4947fb11'
  )
  AcrQuarantineReader: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cdda3590-29a3-44f6-95f2-9f980659eb04'
  )
  AcrQuarantineWriter: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c8d4ff99-41c3-41a8-9f60-21dfdad59608'
  )
  'API Management Service Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e022efe7-f5ba-4159-bbe4-b44f577e9b61'
  )
  'API Management Service Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '71522526-b88f-4d52-b57f-d31fc3546d0d'
  )
  'Application Insights Component Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ae349356-3a1b-4a5e-921d-050484c6347e'
  )
  'Application Insights Snapshot Debugger': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '08954f03-6346-4c2e-81c0-ec3a5cfae23b'
  )
  'Attestation Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fd1bd22b-8476-40bc-a0bc-69b95687b9f3'
  )
  'Automation Job Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4fe576fe-1146-4730-92eb-48519fa6bf9f'
  )
  'Automation Runbook Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5fb5aef8-1081-4b8e-bb16-9d5d0385bab5'
  )
  'Automation Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd3881f73-407a-4167-8283-e981cbba0404'
  )
  'Avere Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4f8fab4f-1852-4a58-a46a-8eaf358af14a'
  )
  'Avere Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c025889f-8102-4ebf-b32c-fc0c6f0c6bd9'
  )
  'Azure Kubernetes Service Cluster Admin Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0ab0b1a8-8aac-4efd-b8c2-3ee1fb270be8'
  )
  'Azure Kubernetes Service Cluster User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4abbcc35-e782-43d8-92c5-2d3f1bd2253f'
  )
  'Azure Maps Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '423170ca-a8f6-4b0f-8487-9e4eb8f49bfa'
  )
  'Azure Stack Registration Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6f12a6df-dd06-4f3e-bcb1-ce8be600526a'
  )
  'Backup Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5e467623-bb1f-42f4-a55d-6e525e11384b'
  )
  'Billing Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fa23ad8b-c56e-40d8-ac0c-ce449e1d2c64'
  )
  'Backup Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a795c7a0-d4a2-40c1-ae25-d81f01202912'
  )
  'Blockchain Member Node Access (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '31a002a1-acaf-453e-8a5b-297c9ca1ea24'
  )
  'BizTalk Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5e3c6656-6cfa-4708-81fe-0de47ac73342'
  )
  'CDN Endpoint Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '426e0c7f-0c7e-4658-b36f-ff54d6c29b45'
  )
  'CDN Profile Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ec156ff8-a8d1-4d15-830c-5b80698ca432'
  )
  'CDN Profile Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8f96442b-4075-438f-813d-ad51ab4019af'
  )
  'Classic Network Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b34d265f-36f7-4a0d-a4d4-e158ca92e90f'
  )
  'Classic Storage Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '86e8f5dc-a6e9-4c67-9d15-de283e8eac25'
  )
  'Classic Storage Account Key Operator Service Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '985d6b00-f706-48f5-a6fe-d0ca12fb668d'
  )
  'ClearDB MySQL DB Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9106cda0-8a86-4e81-b686-29a22c54effe'
  )
  'Classic Virtual Machine Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd73bb868-a0df-4d4d-bd69-98a00b01fccb'
  )
  'Cognitive Services User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a97b65f3-24c7-4388-baec-2e87135dc908'
  )
  'Cognitive Services Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b59867f0-fa02-499b-be73-45a86b5b3e1c'
  )
  'Cognitive Services Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '25fbc0a9-bd7c-42a3-aa1a-3b75d497ee68'
  )
  CosmosBackupOperator: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'db7b14f2-5adf-42da-9f96-f2ee17bab5cb'
  )
  Contributor: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b24988ac-6180-42a0-ab88-20f7382dd24c'
  )
  'Cosmos DB Account Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fbdf93bf-df7d-467e-a4d2-9458aa1360c8'
  )
  'Cost Management Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '434105ed-43f6-45c7-a02f-909b2ba83430'
  )
  'Cost Management Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '72fafb9e-0641-4937-9268-a91bfd8191a3'
  )
  'Data Box Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'add466c9-e687-43fc-8d98-dfcf8d720be5'
  )
  'Data Box Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '028f4ed7-e2a9-465e-a8f4-9c0ffdfdc027'
  )
  'Data Factory Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '673868aa-7521-48a0-acc6-0f60742d39f5'
  )
  'Data Purger': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '150f5e0c-0603-4f03-8c7f-cf70034c4e90'
  )
  'Data Lake Analytics Developer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '47b7735b-770e-4598-a7da-8b91488b4c88'
  )
  'DevTest Labs User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '76283e04-6283-4c54-8f91-bcf1374a3c64'
  )
  'DocumentDB Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5bd9cd88-fe45-4216-938b-f97437e15450'
  )
  'DNS Zone Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'befefa01-2a29-4197-83a8-272ff33ce314'
  )
  'EventGrid EventSubscription Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '428e0ff0-5e57-4d9c-a221-2c70d0e0a443'
  )
  'EventGrid EventSubscription Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2414bbcf-6497-4faf-8c65-045460748405'
  )
  'Graph Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b60367af-1334-4454-b71e-769d9a4f83d9'
  )
  'HDInsight Domain Services Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8d8d5a11-05d3-4bda-a417-a08778121c7c'
  )
  'Intelligent Systems Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '03a6d094-3444-4b3d-88af-7477090a9e5e'
  )
  'Key Vault Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f25e0fa2-a7c8-4377-a976-54943a77a395'
  )
  'Knowledge Consumer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ee361c5d-f7b5-4119-b4b6-892157c8f64c'
  )
  'Lab Creator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b97fb8bc-a8b2-4522-a38b-dd33c7e65ead'
  )
  'Log Analytics Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '73c42c96-874c-492b-b04d-ab87d138a893'
  )
  'Log Analytics Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '92aaf0da-9dab-42b6-94a3-d43ce8d16293'
  )
  'Logic App Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '515c2055-d9d4-4321-b1b9-bd0c9a0f79fe'
  )
  'Logic App Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '87a39d53-fc1b-424a-814c-f7e04687dc9e'
  )
  'Managed Application Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c7393b34-138c-406f-901b-d8cf2b17e6ae'
  )
  'Managed Applications Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b9331d33-8a36-4f8c-b097-4f54124fdb44'
  )
  'Managed Identity Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f1a07417-d97a-45cb-824c-7a7467783830'
  )
  'Managed Identity Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e40ec5ca-96e0-45a2-b4ff-59039f2c2b59'
  )
  'Management Group Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d58bcaf-24a5-4b20-bdb6-eed9f69fbe4c'
  )
  'Management Group Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ac63b705-f282-497d-ac71-919bf39d939d'
  )
  'Monitoring Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
  )
  'Network Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4d97b98b-1d4f-4787-a291-c67834d212e7'
  )
  'New Relic APM Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d28c62d-5b37-4476-8438-e587778df237'
  )
  Owner: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  )
  Reader: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'acdd72a7-3385-48ef-bd42-f606fba81ae7'
  )
  'Redis Cache Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e0f68234-74aa-48ed-b826-c38b57376e17'
  )
  'Reader and Data Access': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c12c1c16-33a1-487b-954d-41c89c60f349'
  )
  'Resource Policy Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '36243c78-bf99-498c-9df9-86d9f8d28608'
  )
  'Scheduler Job Collections Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '188a0f2f-5c9e-469b-ae67-2aa5ce574b94'
  )
  'Search Service Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7ca78c08-252a-4471-8644-bb5ff32d4ba0'
  )
  'Security Manager (Legacy)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e3d13bf0-dd5a-482e-ba6b-9b8433878d10'
  )
  'Security Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '39bc4728-0917-49c7-9d2c-d95423bc2eb4'
  )
  'Spatial Anchors Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8bbe83f1-e2a6-4df7-8cb4-4e04d4e5c827'
  )
  'Site Recovery Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6670b86e-a3f7-4917-ac9b-5d6ab1be4567'
  )
  'Site Recovery Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '494ae006-db33-4328-bf46-533a6560a3ca'
  )
  'Spatial Anchors Account Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d51204f-eb77-4b1c-b86a-2ec626c49413'
  )
  'Site Recovery Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dbaa88c4-0c30-4179-9fb3-46319faa6149'
  )
  'Spatial Anchors Account Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '70bbe301-9835-447d-afdd-19eb3167307c'
  )
  'SQL Managed Instance Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4939a1f6-9ae0-4e48-a1e0-f2cbe897382d'
  )
  'SQL DB Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9b7fa17d-e63e-47b0-bb0a-15c516ac86ec'
  )
  'SQL Security Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '056cd41c-7e88-42e1-933e-88ba6a50c9c3'
  )
  'Storage Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '17d1049b-9a84-46fb-8f53-869881c3d3ab'
  )
  'SQL Server Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437'
  )
  'Storage Account Key Operator Service Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '81a9662b-bebf-436f-a333-f67b29880f12'
  )
  'Storage Blob Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  )
  'Storage Blob Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  )
  'Storage Blob Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
  )
  'Storage Queue Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '974c5e8b-45b9-4653-ba55-5f855dd0fb88'
  )
  'Storage Queue Data Message Processor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8a0f0c08-91a1-4084-bc3d-661d67233fed'
  )
  'Storage Queue Data Message Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c6a89b2d-59bc-44d0-9896-0f6e12d7b80a'
  )
  'Storage Queue Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '19e7f393-937e-4f77-808e-94535e297925'
  )
  'Support Request Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cfd33db0-3dd1-45e3-aa9d-cdbdf3b6f24e'
  )
  'Traffic Manager Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a4b10055-b0c7-44c2-b00f-c7b5b3550cf7'
  )
  'User Access Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
  )
  'Virtual Machine Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9980e02c-c2be-4d73-94e8-173b1dc7cf3c'
  )
  'Web Plan Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2cc479cb-7b4d-49a8-b449-8c00fd0f0a4b'
  )
  'Website Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'de139f84-1756-47ae-9be6-808fbbe84772'
  )
  'Azure Service Bus Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '090c5cfd-751d-490a-894a-3ce6f1109419'
  )
  'Azure Event Hubs Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f526a384-b230-433a-b45c-95f59c4a2dec'
  )
  'Attestation Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bbf86eb8-f7b4-4cce-96e4-18cddf81d86e'
  )
  'HDInsight Cluster Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '61ed4efc-fab3-44fd-b111-e24485cc132a'
  )
  'Cosmos DB Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '230815da-be43-4aae-9cb4-875f7bd000aa'
  )
  'Hybrid Server Resource Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '48b40c6e-82e0-4eb3-90d5-19e40f49b624'
  )
  'Hybrid Server Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d1e5ee4-7c68-4a71-ac8b-0739630a3dfb'
  )
  'Azure Event Hubs Data Receiver': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a638d3c7-ab3a-418d-83e6-5f17a39d4fde'
  )
  'Azure Event Hubs Data Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2b629674-e913-4c01-ae53-ef4638d8f975'
  )
  'Azure Service Bus Data Receiver': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4f6d3b9b-027b-4f4c-9142-0e5a2a2247e0'
  )
  'Azure Service Bus Data Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '69a216fc-b8fb-44d8-bc22-1f3c2cd27a39'
  )
  'Storage File Data SMB Share Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'aba4ae5f-2193-4029-9191-0cb91df5e314'
  )
  'Storage File Data SMB Share Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0c867c2a-1d8c-454a-a3db-ab2ea1bdc8bb'
  )
  'Private DNS Zone Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b12aa53e-6015-4669-85d0-8515ebb3ae7f'
  )
  'Storage Blob Delegator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'db58b8e5-c6ad-4a2a-8342-4190687cbf4a'
  )
  'Desktop Virtualization User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'
  )
  'Storage File Data SMB Share Elevated Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a7264617-510b-434b-a828-9731dc254ea7'
  )
  'Blueprint Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '41077137-e803-4205-871c-5a86e6a753b4'
  )
  'Blueprint Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '437d2ced-4a38-4302-8479-ed2bcb43d090'
  )
  'Microsoft Sentinel Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ab8e14d6-4a74-4a29-9ba8-549422addade'
  )
  'Microsoft Sentinel Responder': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3e150937-b8fe-4cfb-8069-0eaf05ecd056'
  )
  'Microsoft Sentinel Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8d289c81-5878-46d4-8554-54e1e3d8b5cb'
  )
  'Policy Insights Data Writer (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '66bb4e9e-b016-4a94-8249-4c0511c2be84'
  )
  'SignalR AccessKey Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '04165923-9d83-45d5-8227-78b77b0a687e'
  )
  'SignalR/Web PubSub Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8cf5e20a-e4b2-4e9d-b3a1-5ceb692c2761'
  )
  'Azure Connected Machine Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b64e21ea-ac4e-4cdf-9dc9-5b892992bee7'
  )
  'Managed Services Registration assignment Delete Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '91c1777a-f3dc-4fae-b103-61d183457e46'
  )
  'App Configuration Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5ae67dd6-50cb-40e7-96ff-dc2bfa4b606b'
  )
  'App Configuration Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '516239f1-63e1-4d78-a4de-a74fb236a071'
  )
  'Kubernetes Cluster - Azure Arc Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '34e09817-6cbe-4d01-b1a2-e0eac5743d41'
  )
  'Experimentation Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7f646f1b-fa08-80eb-a22b-edd6ce5c915c'
  )
  'Cognitive Services QnA Maker Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '466ccd10-b268-4a11-b098-b4849f024126'
  )
  'Cognitive Services QnA Maker Editor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f4cc2bf9-21be-47a1-bdf1-5c5804381025'
  )
  'Experimentation Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7f646f1b-fa08-80eb-a33b-edd6ce5c915c'
  )
  'Remote Rendering Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3df8b902-2a6f-47c7-8cc5-360e9b272a7e'
  )
  'Remote Rendering Client': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd39065c4-c120-43c9-ab0a-63eed9795f0a'
  )
  'Managed Application Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '641177b8-a67a-45b9-a033-47bc880bb21e'
  )
  'Security Assessment Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '612c2aa1-cb24-443b-ac28-3ab7272de6f5'
  )
  'Tag Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4a9ae827-6dc8-4573-8ac7-8239d42aa03f'
  )
  'Integration Service Environment Developer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c7aa55d3-1abb-444a-a5ca-5e51e485d6ec'
  )
  'Integration Service Environment Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a41e2c5b-bd99-4a07-88f4-9bf657a760b8'
  )
  'Azure Kubernetes Service Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8'
  )
  'Azure Digital Twins Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd57506d4-4c8d-48b1-8587-93c323f6a5a3'
  )
  'Azure Digital Twins Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bcd981a7-7f74-457b-83e1-cceb9e632ffe'
  )
  'Hierarchy Settings Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '350f8d15-c687-4448-8ae1-157740a3936d'
  )
  'FHIR Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5a1fc7df-4bf1-4951-a576-89034ee01acd'
  )
  'FHIR Data Exporter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3db33094-8700-4567-8da5-1501d4e7e843'
  )
  'FHIR Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4c8d0bbc-75d3-4935-991f-5f3c56d81508'
  )
  'FHIR Data Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3f88fce4-5892-4214-ae73-ba5294559913'
  )
  'Experimentation Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '49632ef5-d9ac-41f4-b8e7-bbe587fa74a1'
  )
  'Object Understanding Account Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4dd61c23-6743-42fe-a388-d8bdd41cb745'
  )
  'Azure Maps Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8f5e0ce6-4f7b-4dcf-bddf-e6f48634a204'
  )
  'Cognitive Services Custom Vision Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c1ff6cc2-c111-46fe-8896-e0ef812ad9f3'
  )
  'Cognitive Services Custom Vision Deployment': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5c4089e1-6d96-4d2f-b296-c1bc7137275f'
  )
  'Cognitive Services Custom Vision Labeler': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '88424f51-ebe7-446f-bc41-7fa16989e96c'
  )
  'Cognitive Services Custom Vision Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '93586559-c37d-4a6b-ba08-b9f0940c2d73'
  )
  'Cognitive Services Custom Vision Trainer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0a5ae4ab-0d65-4eeb-be61-29fc9b54394b'
  )
  'Key Vault Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '00482a5a-887f-4fb3-b363-3b7fe8e74483'
  )
  'Key Vault Crypto User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '12338af0-0e69-4776-bea7-57ae8d297424'
  )
  'Key Vault Secrets Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b86a8fe4-44ce-4948-aee5-eccb2c155cd7'
  )
  'Key Vault Secrets User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4633458b-17de-408a-b874-0445c86b69e6'
  )
  'Key Vault Certificates Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a4417e6f-fecd-4de8-b567-7b0420556985'
  )
  'Key Vault Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '21090545-7ca7-4776-b22c-e363652d74d2'
  )
  'Key Vault Crypto Service Encryption User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e147488a-f6f5-4113-8e2d-b22465e65bf6'
  )
  'Azure Arc Kubernetes Viewer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '63f0a09d-1495-4db4-a681-037d84835eb4'
  )
  'Azure Arc Kubernetes Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5b999177-9696-4545-85c7-50de3797e5a1'
  )
  'Azure Arc Kubernetes Cluster Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8393591c-06b9-48a2-a542-1bd6b377f6a2'
  )
  'Azure Arc Kubernetes Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dffb1e0c-446f-4dde-a09f-99eb5cc68b96'
  )
  'Azure Kubernetes Service RBAC Cluster Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b1ff04bb-8a4e-4dc4-8eb5-8693973ce19b'
  )
  'Azure Kubernetes Service RBAC Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3498e952-d568-435e-9b2c-8d77e338d7f7'
  )
  'Azure Kubernetes Service RBAC Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7f6c6a51-bcf8-42ba-9220-52d62157d7db'
  )
  'Azure Kubernetes Service RBAC Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a7ffa36f-339b-4b5c-8bdf-e2c188b2c0eb'
  )
  'Services Hub Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '82200a5b-e217-47a5-b665-6d8765ee745b'
  )
  'Object Understanding Account Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd18777c0-1514-4662-8490-608db7d334b6'
  )
  'SignalR REST API Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fd53cd77-2268-407a-8f46-7e7863d0f521'
  )
  'Collaborative Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'daa9e50b-21df-454c-94a6-a8050adab352'
  )
  'Device Update Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e9dba6fb-3d52-4cf0-bce3-f06ce71b9e0f'
  )
  'Device Update Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '02ca0879-e8e4-47a5-a61e-5c618b76e64a'
  )
  'Device Update Content Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0378884a-3af5-44ab-8323-f5b22f9f3c98'
  )
  'Device Update Content Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd1ee9a80-8b14-47f0-bdc2-f4a351625a7b'
  )
  'Cognitive Services Metrics Advisor Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cb43c632-a144-4ec5-977c-e80c4affc34a'
  )
  'Cognitive Services Metrics Advisor User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3b20f47b-3825-43cb-8114-4bd2201156a8'
  )
  'Schema Registry Reader (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2c56ea50-c6b3-40a6-83c0-9d98858bc7d2'
  )
  'Schema Registry Contributor (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5dffeca3-4936-4216-b2bc-10343a5abb25'
  )
  'AgFood Platform Service Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7ec7ccdc-f61e-41fe-9aaf-980df0a44eba'
  )
  'AgFood Platform Service Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8508508a-4469-4e45-963b-2518ee0bb728'
  )
  'AgFood Platform Service Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f8da80de-1ff9-4747-ad80-a19b7f6079e3'
  )
  'Managed HSM contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18500a29-7fe2-46b2-a342-b16a415e101d'
  )
  'Security Detonation Chamber Submitter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0b555d9b-b4a7-4f43-b330-627f0e5be8f0'
  )
  'SignalR REST API Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ddde6b66-c0df-4114-a159-3618637b3035'
  )
  'SignalR Service Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7e4f1700-ea5a-4f59-8f37-079cfe29dce3'
  )
  'Reservation Purchaser': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f7b75c60-3036-4b75-91c3-6b41c27c1689'
  )
  'AzureML Metrics Writer (preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '635dd51f-9968-44d3-b7fb-6d9a6bd613ae'
  )
  'Storage Account Backup Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e5e2a7ff-d759-4cd2-bb51-3152d37e2eb1'
  )
  'Experimentation Metric Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6188b7c9-7d01-4f99-a59f-c88b630326c0'
  )
  'Project Babylon Data Curator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9ef4ef9c-a049-46b0-82ab-dd8ac094c889'
  )
  'Project Babylon Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c8d896ba-346d-4f50-bc1d-7d1c84130446'
  )
  'Project Babylon Data Source Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '05b7651b-dc44-475e-b74d-df3db49fae0f'
  )
  'Application Group Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ca6382a4-1721-4bcf-a114-ff0c70227b6b'
  )
  'Desktop Virtualization Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '49a72310-ab8d-41df-bbb0-79b649203868'
  )
  'Desktop Virtualization Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '082f0a83-3be5-4ba1-904c-961cca79b387'
  )
  'Desktop Virtualization Workspace Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '21efdde3-836f-432b-bf3d-3e8e734d4b2b'
  )
  'Desktop Virtualization User Session Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ea4bfff8-7fb4-485a-aadd-d4129a0ffaa6'
  )
  'Desktop Virtualization Session Host Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2ad6aaab-ead9-4eaa-8ac5-da422f562408'
  )
  'Desktop Virtualization Host Pool Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ceadfde2-b300-400a-ab7b-6143895aa822'
  )
  'Desktop Virtualization Host Pool Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e307426c-f9b6-4e81-87de-d99efb3c32bc'
  )
  'Desktop Virtualization Application Group Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'aebf23d0-b568-4e86-b8f9-fe83a2c6ab55'
  )
  'Desktop Virtualization Application Group Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '86240b0e-9422-4c43-887b-b61143f32ba8'
  )
  'Desktop Virtualization Workspace Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0fa44ee9-7a7d-466b-9bb2-2bf446b1204d'
  )
  'Disk Backup Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3e5e47e6-65f7-47ef-90b5-e5dd4d455f24'
  )
  'Disk Restore Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b50d9833-a0cb-478e-945f-707fcc997c13'
  )
  'Disk Snapshot Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7efff54f-a5b4-42b5-a1c5-5411624893ce'
  )
  'Microsoft.Kubernetes connected cluster role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5548b2cf-c94c-4228-90ba-30851930a12f'
  )
  'Security Detonation Chamber Submission Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a37b566d-3efa-4beb-a2f2-698963fa42ce'
  )
  'Security Detonation Chamber Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '352470b3-6a9c-4686-b503-35deb827e500'
  )
  'Collaborative Runtime Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7a6f0e70-c033-4fb1-828c-08514e5f4102'
  )
  CosmosRestoreOperator: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5432c526-bc82-444a-b7ba-57c5b0b5b34f'
  )
  'FHIR Data Converter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a1705bd2-3a8f-45a5-8683-466fcfd5cc24'
  )
  'Quota Request Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0e5f05e5-9ab9-446b-b98d-1e2157c94125'
  )
  'EventGrid Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1e241071-0855-49ea-94dc-649edcd759de'
  )
  'Security Detonation Chamber Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '28241645-39f8-410b-ad48-87863e2951d5'
  )
  'Object Anchors Account Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4a167cdf-cb95-4554-9203-2347fe489bd9'
  )
  'Object Anchors Account Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ca0835dd-bacc-42dd-8ed2-ed5e7230d15b'
  )
  'WorkloadBuilder Migration Agent Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd17ce0a2-0697-43bc-aac5-9113337ab61c'
  )
  'Azure Spring Cloud Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b5537268-8956-4941-a8f0-646150406f0c'
  )
  'Cognitive Services Speech Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0e75ca1e-0464-4b4d-8b93-68208a576181'
  )
  'Cognitive Services Face Recognizer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9894cab4-e18a-44aa-828b-cb588cd6f2d7'
  )
  'Media Services Account Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '054126f8-9a2b-4f1c-a9ad-eca461f08466'
  )
  'Media Services Live Events Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '532bc159-b25e-42c0-969e-a1d439f60d77'
  )
  'Media Services Media Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e4395492-1534-4db2-bedf-88c14621589c'
  )
  'Media Services Policy Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c4bba371-dacd-4a26-b320-7250bca963ae'
  )
  'Media Services Streaming Endpoints Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '99dba123-b5fe-44d5-874c-ced7199a5804'
  )
  'Stream Analytics Query Tester': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1ec5b3c1-b17e-4e25-8312-2acb3c3c5abf'
  )
  'AnyBuild Builder': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a2138dac-4907-4679-a376-736901ed8ad8'
  )
  'IoT Hub Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b447c946-2db7-41ec-983d-d8bf3b1c77e3'
  )
  'IoT Hub Twin Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '494bdba2-168f-4f31-a0a1-191d2f7c028c'
  )
  'IoT Hub Registry Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4ea46cd5-c1b2-4a8e-910b-273211f9ce47'
  )
  'IoT Hub Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4fc6c259-987e-4a07-842e-c321cc9d413f'
  )
  'Test Base Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '15e0f5a1-3450-4248-8e25-e2afe88a9e85'
  )
  'Search Index Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1407120a-92aa-4202-b7e9-c0e197c71c8f'
  )
  'Search Index Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8ebe5a00-799e-43f5-93ac-243d3dce84a7'
  )
  'Storage Table Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '76199698-9eea-4c19-bc75-cec21354c6b6'
  )
  'Storage Table Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'
  )
  'DICOM Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e89c7a3c-2f64-4fa1-a847-3e4c9ba4283a'
  )
  'DICOM Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '58a3b984-7adf-4c20-983a-32417c86fbc8'
  )
  'EventGrid Data Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd5a91429-5739-47e2-a06b-3470a27159e7'
  )
  'Disk Pool Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '60fc6e62-5479-42d4-8bf4-67625fcc2840'
  )
  'AzureML Data Scientist': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f6c7c914-8db3-469d-8ca1-694a8f32e121'
  )
  'Grafana Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '22926164-76b3-42b3-bc55-97df8dab3e41'
  )
  'Azure Connected SQL Server Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e8113dce-c529-4d33-91fa-e9b972617508'
  )
  'Azure Relay Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '26baccc8-eea7-41f1-98f4-1762cc7f685d'
  )
  'Azure Relay Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2787bf04-f1f5-4bfe-8383-c8a24483ee38'
  )
  'Azure Relay Listener': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '26e0b698-aa6d-4085-9386-aadae190014d'
  )
  'Grafana Viewer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '60921a7e-fef1-4a43-9b16-a26c52ad4769'
  )
  'Grafana Editor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a79a5197-3a5c-4973-a920-486035ffd60f'
  )
  'Automation Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f353d9bd-d4a6-484e-a77a-8050b599b867'
  )
  'Kubernetes Extension Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '85cb6faf-e071-4c9b-8136-154b5a04f717'
  )
  'Device Provisioning Service Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '10745317-c249-44a1-a5ce-3a4353c0bbd8'
  )
  'Device Provisioning Service Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dfce44e4-17b7-4bd1-a6d1-04996ec95633'
  )
  'Trusted Signing Certificate Profile Signer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2837e146-70d7-4cfd-ad55-7efa6464f958'
  )
  'Azure Spring Cloud Service Registry Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cff1b556-2399-4e7e-856d-a8f754be7b65'
  )
  'Azure Spring Cloud Service Registry Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f5880b48-c26d-48be-b172-7927bfa1c8f1'
  )
  'Azure Spring Cloud Config Server Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd04c6db6-4947-4782-9e91-30a88feb7be7'
  )
  'Azure Spring Cloud Config Server Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a06f5c24-21a7-4e1a-aa2b-f19eb6684f5b'
  )
  'Azure VM Managed identities restore Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6ae96244-5829-4925-a7d3-5975537d91dd'
  )
  'Azure Maps Search and Render Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6be48352-4f82-47c9-ad5e-0acacefdb005'
  )
  'Azure Maps Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dba33070-676a-4fb0-87fa-064dc56ff7fb'
  )
  'Azure Arc VMware VM Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b748a06d-6150-4f8a-aaa9-ce3940cd96cb'
  )
  'Azure Arc VMware Private Cloud User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ce551c02-7c42-47e0-9deb-e3b6fc3a9a83'
  )
  'Azure Arc VMware Administrator role ': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ddc140ed-e463-4246-9145-7c664192013f'
  )
  'Cognitive Services LUIS Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f72c8140-2111-481c-87ff-72b910f6e3f8'
  )
  'Cognitive Services Language Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7628b7b8-a8b2-4cdc-b46f-e9b35248918e'
  )
  'Cognitive Services Language Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f2310ca1-dc64-4889-bb49-c8e0fa3d47a8'
  )
  'Cognitive Services Language Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f07febfe-79bc-46b1-8b37-790e26e6e498'
  )
  'Cognitive Services LUIS Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18e81cdc-4e98-4e29-a639-e7d10c5a6226'
  )
  'Cognitive Services LUIS Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6322a993-d5c9-4bed-b113-e49bbea25b27'
  )
  'PlayFab Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a9a19cc5-31f4-447c-901f-56c0bb18fcaf'
  )
  'Load Test Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '749a398d-560b-491b-bb21-08924219302e'
  )
  'Load Test Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '45bb0b16-2f0c-4e78-afaa-a07599b003f6'
  )
  'PlayFab Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0c8b84dc-067c-4039-9615-fa1a4b77c726'
  )
  'Load Test Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3ae3fb29-0000-4ccd-bf80-542e7b26e081'
  )
  'Cognitive Services Immersive Reader User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b2de6794-95db-4659-8781-7e080d3f2b9d'
  )
  'Lab Services Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f69b8690-cc87-41d6-b77a-a4bc3c0a966f'
  )
  'Lab Services Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2a5c394f-5eb7-4d4f-9c8e-e8eae39faebc'
  )
  'Lab Assistant': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ce40b423-cede-4313-a93f-9b28290b72e1'
  )
  'Lab Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a36e6959-b6be-4b12-8e9f-ef4b474d304d'
  )
  'Lab Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5daaa2af-1fe8-407c-9122-bba179798270'
  )
  'Security Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fb1c8493-542b-48eb-b624-b4c8fea62acd'
  )
  'Web PubSub Service Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '12cf5a90-567b-43ae-8102-96cf46c7d9b4'
  )
  'Web PubSub Service Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bfb1c7d2-fb1a-466b-b2ba-aee63b92deaf'
  )
  'SignalR App Server': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '420fcaa2-552c-430f-98ca-3264be4806c7'
  )
  'Virtual Machine User Login': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fb879df8-f326-4884-b1cf-06f3ad86be52'
  )
  'Virtual Machine Administrator Login': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1c0163c0-47e6-4577-8991-ea5c82e286e4'
  )
  'Azure Connected Machine Resource Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cd570a14-e51a-42ad-bac8-bafd67325302'
  )
  'Backup Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '00c29273-979b-4161-815c-10b084fb9324'
  )
  'Workbook Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e8ddcd69-c73f-4f9f-9844-4100522f16ad'
  )
  'Workbook Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b279062a-9be3-42a0-92ae-8b3cf002ec4d'
  )
  'Monitoring Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
  )
  'Monitoring Metrics Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3913510d-42f4-4e42-8a64-420c390055eb'
  )
  'Purview role 1 (Deprecated)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8a3c2885-9b38-4fd2-9d99-91af537c1347'
  )
  'Purview role 2 (Deprecated)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '200bba9e-f0c8-430f-892b-6f0794863803'
  )
  'Purview role 3 (Deprecated)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ff100721-1b9d-43d8-af52-42b69c1272db'
  )
  'Autonomous Development Platform Data Contributor (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b8b15564-4fa6-4a59-ab12-03e1d9594795'
  )
  'Autonomous Development Platform Data Owner (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '27f8b550-c507-4db9-86f2-f4b8e816d59d'
  )
  'Autonomous Development Platform Data Reader (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd63b75f7-47ea-4f27-92ac-e0d173aaf093'
  )
  'Key Vault Crypto Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '14b46e9e-c2b7-41b4-b07b-48a6ebf60603'
  )
  'Device Update Deployments Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '49e2f5d2-7741-4835-8efa-19e1fe35e47f'
  )
  'Device Update Deployments Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e4237640-0e3d-4a46-8fda-70bc94856432'
  )
  'Azure Arc VMware Private Clouds Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '67d33e57-3129-45e6-bb0b-7cc522f762fa'
  )
  'Chamber Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4e9b8407-af2e-495b-ae54-bb60a55b1b5a'
  )
  'Microsoft Sentinel Automation Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f4c81013-99ee-4d62-a7ee-b3f1f648599a'
  )
  'CDN Endpoint Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '871e35f6-b5c1-49cc-a043-bde969a0f2cd'
  )
  'Chamber User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4447db05-44ed-4da3-ae60-6cbece780e32'
  )
  'Cognitive Services Speech User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f2dc8367-1007-4938-bd23-fe263f013447'
  )
  'Windows Admin Center Administrator Login': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a6333a3e-0164-44c3-b281-7a577aff287f'
  )
  'Azure Kubernetes Service Policy Add-on Deployment': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18ed5180-3e48-46fd-8541-4ea054d57064'
  )
  'Guest Configuration Resource Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '088ab73d-1256-47ae-bea9-9de8e7131f31'
  )
  'Domain Services Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '361898ef-9ed1-48c2-849c-a832951106bb'
  )
  'Domain Services Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'eeaeda52-9324-47f6-8069-5d5bade478b2'
  )
  'DNS Resolver Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0f2ebee7-ffd4-4fc0-b3b7-664099fdad5d'
  )
  'Azure Arc Enabled Kubernetes Cluster User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '00493d72-78f6-4148-b6c5-d3ce8e4799dd'
  )
  'Data Operator for Managed Disks': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '959f8984-c045-4866-89c7-12bf9737be2e'
  )
  'AgFood Platform Sensor Partner Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6b77f0a0-0d89-41cc-acd1-579c22c17a67'
  )
  'Compute Gallery Sharing Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1ef6a3be-d0ac-425d-8c01-acb62866290b'
  )
  'Scheduled Patching Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cd08ab90-6b14-449c-ad9a-8f8e549482c6'
  )
  'DevCenter Dev Box User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '45d50f46-0b78-4001-a660-4198cbe8cd05'
  )
  'DevCenter Project Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '331c37c6-af14-46d9-b9f4-e1909e1b95a0'
  )
  'Virtual Machine Local User Login': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '602da2ba-a5c2-41da-b01d-5360126ab525'
  )
  'Azure Arc ScVmm Private Cloud User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c0781e91-8102-4553-8951-97c6d4243cda'
  )
  'Azure Arc ScVmm VM Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e582369a-e17b-42a5-b10c-874c387c530b'
  )
  'Azure Arc ScVmm Private Clouds Onboarding': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6aac74c4-6311-40d2-bbdd-7d01e7c6e3a9'
  )
  'Azure Arc ScVmm Administrator role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a92dfd61-77f9-4aec-a531-19858b406c87'
  )
  'HDInsight on AKS Cluster Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fd036e6b-1266-47a0-b0bb-a05d04831731'
  )
  'HDInsight on AKS Cluster Pool Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7656b436-37d4-490a-a4ab-d39f838f0042'
  )
  'FHIR Data Importer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4465e953-8ced-4406-a58e-0f6e3f3b530b'
  )
  'HDInsight on AKS Cluster Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bcf28286-af25-4c81-bb6f-351fcab5dbe9'
  )
  'API Management Developer Portal Content Editor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c031e6a8-4391-4de0-8d69-4706a7ed3729'
  )
  'VM Scanner Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd24ecba3-c1f4-40fa-a7bb-4588a071e8fd'
  )
  'Elastic SAN Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '80dcbedb-47ef-405d-95bd-188a1b4ac406'
  )
  'Elastic SAN Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'af6a70f8-3c9f-4105-acf1-d719e9fca4ca'
  )
  'Desktop Virtualization Power On Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '489581de-a3bd-480d-9518-53dea7416b33'
  )
  'Desktop Virtualization Virtual Machine Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a959dbd1-f747-45e3-8ba6-dd80f235f97c'
  )
  'Desktop Virtualization Power On Off Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '40c5ff49-9181-41f8-ae61-143b0e78555e'
  )
  'Access Review Operator Service Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '76cc9ee4-d5d3-4a45-a930-26add3d73475'
  )
  'Elastic SAN Volume Group Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a8281131-f312-4f34-8d98-ae12be9f0d23'
  )
  'Trusted Signing Identity Verifier': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4339b7cf-9826-4e41-b4ed-c7f4505dac08'
  )
  'Video Indexer Restricted Viewer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a2c4a527-7dc0-4ee3-897b-403ade70fafb'
  )
  'Monitoring Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b0d8363b-8ddd-447d-831f-62ca05bff136'
  )
  'Azure Kubernetes Fleet Manager RBAC Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '30b27cfc-9c84-438e-b0ce-70e35255df80'
  )
  'Azure Kubernetes Fleet Manager RBAC Cluster Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18ab4d3d-a1bf-4477-8ad9-8359bc988f69'
  )
  'Azure Kubernetes Fleet Manager RBAC Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '434fb43a-c01c-447e-9f67-c3ad923cfaba'
  )
  'Azure Kubernetes Fleet Manager RBAC Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5af6afb3-c06c-4fa4-8848-71a8aee05683'
  )
  'Azure Kubernetes Fleet Manager Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '63bb64ad-9799-4770-b5c3-24ed299a07bf'
  )
  'Kubernetes Namespace User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ba79058c-0414-4a34-9e42-c3399d80cd5a'
  )
  'Data Labeling - Labeler': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c6decf44-fd0a-444c-a844-d653c394e7ab'
  )
  'Role Based Access Control Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f58310d9-a9f6-439a-9e8d-f62e7b41a168'
  )
  'Template Spec Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '392ae280-861d-42bd-9ea5-08ee6d83b80e'
  )
  'Template Spec Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1c9b6475-caf0-4164-b5a1-2142a7116f4b'
  )
  'Microsoft Sentinel Playbook Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '51d6186e-6489-4900-b93f-92e23144cca5'
  )
  'Deployment Environments User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18e40d4e-8d2e-438d-97e1-9528336e149c'
  )
  'Azure Spring Apps Connect Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '80558df3-64f9-4c0f-b32d-e5094b036b0b'
  )
  'Azure Spring Apps Remote Debugging Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a99b0159-1064-4c22-a57b-c9b3caa1c054'
  )
  'AzureML Registry User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1823dd4f-9b8c-4ab6-ab4e-7397a3684615'
  )
  'AzureML Compute Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e503ece1-11d0-4e8e-8e2c-7a6c3bf38815'
  )
  'Azure Center for SAP solutions reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '05352d14-a920-4328-a0de-4cbe7430e26b'
  )
  'Azure Center for SAP solutions service role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'aabbc5dd-1af0-458b-a942-81af88f9c138'
  )
  'Azure Center for SAP solutions administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7b0c7e81-271f-4c71-90bf-e30bdfdbc2f7'
  )
  'AppGw for Containers Configuration Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fbc52c3f-28ad-4303-a892-8a056630b8f1'
  )
  'FHIR SMART User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4ba50f17-9666-485c-a643-ff00808643f0'
  )
  'Cognitive Services OpenAI Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a001fd3d-188f-4b5d-821b-7da978bf7442'
  )
  'Cognitive Services OpenAI User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd'
  )
  'Impact Reporter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '36e80216-a7e8-4f42-a7e1-f12c98cbaf8a'
  )
  'Impact Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '68ff5d27-c7f5-4fa9-a21c-785d0df7bd9e'
  )
  'ContainerApp Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ad2dd5fb-cd4b-4fd4-a9b6-4fed3630980b'
  )
  'Azure Kubernetes Service Cluster Monitoring User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1afdec4b-e479-420e-99e7-f82237c7c5e6'
  )
  'Azure Connected Machine Resource Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f5819b54-e033-4d82-ac66-4fec3cbf3f4c'
  )
  'SqlDb Migration Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '189207d4-bb67-4208-a635-b06afe8b2c57'
  )
  'Bayer Ag Powered Services GDU Solution': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c4bc862a-3b64-4a35-a021-a380c159b042'
  )
  'Bayer Ag Powered Services Imagery Solution': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ef29765d-0d37-4119-a4f8-f9f9902c9588'
  )
  'Azure Center for SAP solutions Service role for management': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0105a6b0-4bb9-43d2-982a-12806f9faddb'
  )
  'Azure Center for SAP solutions Management role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6d949e1d-41e2-46e3-8920-c6e4f31a8310'
  )
  'Kubernetes Agentless Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd5a2ae44-610b-4500-93be-660a0c5f5ca6'
  )
  'Azure Usage Billing Data Sender': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f0310ce6-e953-4cf8-b892-fb1c87eaf7f6'
  )
  'Azure Container Registry secure supply chain operator service role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '96062cf7-95ca-4f89-9b9d-2a2aa47356af'
  )
  'SqlMI Migration Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1d335eef-eee1-47fe-a9e0-53214eba8872'
  )
  'SqlVM Migration Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ae8036db-e102-405b-a1b9-bae082ea436d'
  )
  'Bayer Ag Powered Services CWUM Solution': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a9b99099-ead7-47db-8fcf-072597a61dfa'
  )
  'Azure Front Door Domain Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0ab34830-df19-4f8c-b84e-aa85b8afa6e8'
  )
  'Azure Front Door Secret Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3f2eb865-5811-4578-b90a-6fc6fa0df8e5'
  )
  'Azure Front Door Domain Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0f99d363-226e-4dca-9920-b807cf8e1a5f'
  )
  'Azure Front Door Secret Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0db238c4-885e-4c4f-a933-aa2cef684fca'
  )
  'MySQL Backup And Export Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd18ad5f3-1baf-4119-b49b-d944edb1f9d0'
  )
  'LocalNGFirewallAdministrator role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a8835c7d-b5cb-47fa-b6f0-65ea10ce07a2'
  )
  'Azure Stack HCI Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bda0d508-adf1-4af0-9c28-88919fc3ae06'
  )
  'LocalRulestacksAdministrator role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bfc3b73d-c6ff-45eb-9a5f-40298295bf20'
  )
  'Azure Extension for SQL Server Deployment': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7392c568-9289-4bde-aaaa-b7131215889d'
  )
  'Azure Maps Data Read and Batch Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd6470a16-71bd-43ab-86b3-6f3a73f4e787'
  )
  'API Management Workspace Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ef1c2c96-4a77-49e8-b9a4-6179fe1d2fd2'
  )
  'API Management Workspace API Product Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '73c2c328-d004-4c5e-938c-35c6f5679a1f'
  )
  'API Management Workspace API Developer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '56328988-075d-4c6a-8766-d93edd6725b6'
  )
  'API Management Service Workspace API Product Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd59a3e9c-6d52-4a5a-aeed-6bf3cf0e31da'
  )
  'API Management Service Workspace API Developer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9565a273-41b9-4368-97d2-aeb0c976a9b3'
  )
  'API Management Workspace Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0c34c906-8d99-4cb7-8bb7-33f5b0a1a799'
  )
  'Storage File Data Privileged Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b8eda974-7b85-4f76-af95-65846b26df6d'
  )
  'Storage File Data Privileged Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '69566ab7-960f-475b-8e7c-b3118f30c6bd'
  )
  'Windows 365 Network User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7eabc9a4-85f7-4f71-b8ab-75daaccc1033'
  )
  'Windows 365 Network Interface Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1f135831-5bbe-4924-9016-264044c00788'
  )
  Windows365SubscriptionReader: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3d55a8f6-4133-418d-8051-facdb1735758'
  )
  'App Compliance Automation Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0f37683f-2463-46b6-9ce7-9b788b988ba2'
  )
  'App Compliance Automation Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ffc6bbe0-e443-4c3b-bf54-26581bb2f78e'
  )
  'Azure Sphere Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8b9dfcab-4b77-4632-a6df-94bd07820648'
  )
  'SaaS Hub Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e9b8712a-cbcf-4ea7-b0f7-e71b803401e6'
  )
  'Azure Sphere Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c8ae6279-5a0b-4cb2-b3f0-d4d62845742c'
  )
  'Azure Sphere Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6d994134-994b-4a59-9974-f479f0b227fb'
  )
  'Procurement Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'be1a1ac2-09d3-4261-9e57-a73a6e227f53'
  )
  'Azure Machine Learning Workspace Connection Secrets Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ea01e6af-a1c1-4350-9563-ad00f8c72ec5'
  )
  'Cognitive Search Serverless Data Reader (Deprecated)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '79b01272-bf9f-4f4c-9517-5506269cf524'
  )
  'Cognitive Search Serverless Data Contributor (Deprecated)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7ac06ca7-21ca-47e3-a67b-cbd6e6223baf'
  )
  'Community Owner Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5e28a61e-8040-49db-b175-bb5b88af6239'
  )
  'Firmware Analysis Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9c1607d1-791d-4c68-885d-c7b7aaff7c8a'
  )
  'Key Vault Data Access Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8b54135c-b56d-4d72-a534-26097cfdc8d8'
  )
  'Defender for Storage Data Scanner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1e7ca9b1-60d1-4db8-a914-f2ca1ff27c40'
  )
  'Compute Diagnostics Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'df2711a6-406d-41cf-b366-b0250bff9ad1'
  )
  'Elastic SAN Network Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fa6cecf6-5db3-4c43-8470-c540bcb4eafa'
  )
  'Cognitive Services Usages Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bba48692-92b0-4667-a9ad-c31c7b334ac2'
  )
  'PostgreSQL Flexible Server Long Term Retention Backup Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c088a766-074b-43ba-90d4-1fb21feae531'
  )
  'Search Parameter Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a02f7c31-354d-4106-865a-deedf37fa038'
  )
  'Virtual Machine Data Access Administrator (preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '66f75aeb-eabe-4b70-9f1e-c350c4c9ad04'
  )
  'Logic Apps Standard Reader (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4accf36b-2c05-432f-91c8-5c532dff4c73'
  )
  'Logic Apps Standard Developer (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '523776ba-4eb2-4600-a3c8-f2dc93da4bdb'
  )
  'Logic Apps Standard Contributor (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ad710c24-b039-4e85-a019-deb4a06e8570'
  )
  'Logic Apps Standard Operator (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b70c96e9-66fe-4c09-b6e7-c98e69c98555'
  )
  'IPAM Pool User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7b3e853f-ad5d-4fb5-a7b8-56a3581c7037'
  )
  'SpatialMapsAccounts Account Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e9c9ed2b-2a99-4071-b2ff-5b113ebf73a1'
  )
  'Azure Resource Notifications System Topics Subscriber': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0b962ed2-6d56-471c-bd5f-3477d83a7ba4'
  )
  'Elastic SAN Snapshot Exporter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1c4770c0-34f7-4110-a1ea-a5855cc7a939'
  )
  'Elastic SAN Volume Importer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '90e8b822-3e73-47b5-868a-787dc80c008f'
  )
  'Community Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '49435da6-99fe-48a5-a235-fc668b9dc04a'
  )
  'EventGrid TopicSpaces Subscriber': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4b0f2fd7-60b4-4eca-896f-4435034f8bf5'
  )
  'EventGrid TopicSpaces Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a12b0b94-b317-4dcd-84a8-502ce99884c6'
  )
  'Data Boundary Tenant Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd1a38570-4b05-4d70-b8e4-1100bcf76d12'
  )
  'DeID Batch Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8a90fa6b-6997-4a07-8a95-30633a7c97b9'
  )
  'DeID Batch Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b73a14ee-91f5-41b7-bd81-920e12466be9'
  )
  'DeID Realtime Data User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bb6577c4-ea0a-40b2-8962-ea18cb8ecd4e'
  )
  'Carbon Optimization Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fa0d39e6-28e5-40cf-8521-1eb320653a4c'
  )
  'Landing Zone Management Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '38863829-c2a4-4f8d-b1d2-2e325973ebc7'
  )
  'Landing Zone Management Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8fe6e843-6d9e-417b-9073-106b048f50bb'
  )
  'Azure Stack HCI Device Management Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '865ae368-6a45-4bd1-8fbf-0d5151f56fc1'
  )
  'Azure Customer Lockbox Approver for Subscription': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4dae6930-7baf-46f5-909e-0383bc931c46'
  )
  'Azure Resource Bridge Deployment Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7b1f81f9-4196-4058-8aae-762e593270df'
  )
  'Azure Stack HCI VM Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '874d1c73-6003-4e60-a13a-cb31ea190a85'
  )
  'Azure Stack HCI VM Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4b3fe76c-f777-4d24-a2d7-b027b0f7b273'
  )
  'Azure AI Developer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '64702f94-c441-49e6-a78b-ef80e0188fee'
  )
  'Deployment Environments Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'eb960402-bf75-4cc3-8d68-35b34f960f72'
  )
  'EventGrid Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1d8c3fe3-8864-474b-8749-01e3783e8157'
  )
  'EventGrid Data Receiver': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '78cbd9e7-9798-4e2e-9b5a-547d9ebb31fb'
  )
  'Azure AI Inference Deployment Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3afb7f49-54cb-416e-8c09-6dc049efa503'
  )
  'Connected Cluster Managed Identity CheckAccess Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '65a14201-8f6c-4c28-bec4-12619c5a9aaa'
  )
  'Advisor Reviews Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c64499e0-74c3-47ad-921c-13865957895c'
  )
  'Advisor Reviews Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8aac15f0-d885-4138-8afa-bfb5872f7d13'
  )
  'AgFood Platform Dataset Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a8d4b70f-0fb9-4f72-b267-b87b2f990aec'
  )
  'Defender for Storage Scanner Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0f641de8-0b88-4198-bdef-bd8b45ceba96'
  )
  'Azure Front Door Profile Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '662802e2-50f6-46b0-aed2-e834bacc6d12'
  )
  'Enclave Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '86fede04-b259-4277-8c3e-e26b9865abd8'
  )
  'Azure Kubernetes Service Hybrid Cluster Admin Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b5092dac-c796-4349-8681-1a322a31c3f9'
  )
  'Azure Kubernetes Service Hybrid Cluster User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fc3f91a1-40bf-4439-8c46-45edbd83563a'
  )
  'Azure Kubernetes Service Hybrid Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e7037d40-443a-4434-a3fb-8cd202011e1d'
  )
  'Enclave Owner Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3d5f3eff-eb94-473d-91e3-7aac74d6c0bb'
  )
  'Community Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e6aadb6b-e64f-41c0-9392-d2bba3bc3ebc'
  )
  'Enclave Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '19feefae-eacc-4106-81fd-ac34c0671f14'
  )
  'Operator Nexus Key Vault Writer Service Role (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '44f0a1a8-6fea-4b35-980a-8ff50c487c97'
  )
  'Storage Account Encryption Scope Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a316ed6d-1efe-48ac-ac08-f7995a9c26fb'
  )
  'Key Vault Crypto Service Release User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '08bbd89e-9f13-488c-ac41-acfcb10c90ab'
  )
  'Kubernetes Runtime Storage Class Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0cd9749a-3aaf-4ae5-8803-bd217705bf3b'
  )
  'Azure Programmable Connectivity Gateway User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '609c0c20-e0a0-4a71-b99f-e7e755ac493d'
  )
  'Key Vault Certificate User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'db79e9a7-68ee-4b58-9aeb-b90e7c24fcba'
  )
  'Azure Spring Apps Spring Cloud Gateway Log Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4301dc2a-25a9-44b0-ae63-3636cf7f2bd2'
  )
  'Azure Spring Apps Managed Components Log Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '52fd16bd-6ed5-46af-9c40-29cbd7952a29'
  )
  'Azure Spring Apps Application Configuration Service Log Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6593e776-2a30-40f9-8a32-4fe28b77655d'
  )
  'Azure Edge On-Site Deployment Engineer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '207bcc4b-86a6-4487-9141-d6c1f4c238aa'
  )
  'Azure API Center Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c7244dfb-f447-457d-b2ba-3999044d1706'
  )
  'Azure impact-insight reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dfb2f09d-25f8-4558-8986-497084006d7a'
  )
  'Defender Kubernetes Agent Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8bb6f106-b146-4ee6-a3f9-b9c5a96e0ae5'
  )
  'Azure Red Hat OpenShift Storage Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5b7237c5-45e1-49d6-bc18-a1f62f400748'
  )
  'Azure Red Hat OpenShift Service Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4436bae4-7702-4c84-919b-c4069ff25ee2'
  )
  'Azure Red Hat OpenShift Azure Files Storage Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0d7aedc0-15fd-4a67-a412-efad370c947e'
  )
  'Azure Red Hat OpenShift Image Registry Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8b32b316-c2f5-4ddf-b05b-83dacd2d08b5'
  )
  'Azure Red Hat OpenShift Network Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'be7a6435-15ae-4171-8f30-4a343eff9e8f'
  )
  'Azure Red Hat OpenShift Cloud Controller Manager Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a1f96423-95ce-4224-ab27-4e3dc72facd4'
  )
  'Azure Red Hat OpenShift Machine API Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0358943c-7e01-48ba-8889-02cc51d78637'
  )
  'Azure Red Hat OpenShift Cluster Ingress Operator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0336e1d3-7a87-462b-b6db-342b63f7802c'
  )
  'Azure Sphere Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5a382001-fe36-41ff-bba4-8bf06bd54da9'
  )
  'GroupQuota Request Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e2217c0e-04bb-4724-9580-91cf9871bc01'
  )
  'GroupQuota Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd0f495dc-44ef-4140-aeb0-b89110e6a7c1'
  )
  'Bayer Ag Powered Services Smart Boundary Solution User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '539283cd-c185-4a9a-9503-d35217a1db7b'
  )
  'Defender CSPM Storage Scanner Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8480c0f0-4509-4229-9339-7c10018cb8c4'
  )
  'Advisor Recommendations Contributor (Assessments and Reviews)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6b534d80-e337-47c4-864f-140f5c7f593d'
  )
  'GeoCatalog Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c9c97b9c-105d-4bb5-a2a7-7d15666c2484'
  )
  'GeoCatalog Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b7b8f583-43d0-40ae-b147-6b46f53661c1'
  )
  'Health Bot Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'eb5a76d5-50e7-4c33-a449-070e7c9c4cf2'
  )
  'Health Bot Editor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'af854a69-80ce-4ff7-8447-f1118a2e0ca8'
  )
  'Health Bot Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f1082fec-a70f-419f-9230-885d2550fb38'
  )
  'Azure Programmable Connectivity Gateway Dataplane User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c20923c5-b089-47a5-bf67-fd89569c4ad9'
  )
  'Azure AI Enterprise Network Connection Approver': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b556d68e-0be0-4f35-a333-ad7ee1ce17ea'
  )
  'Azure Container Storage Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '08d4c71a-cc63-4ce4-a9c8-5dd251b4d619'
  )
  'Azure Container Storage Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '95dd08a6-00bd-4661-84bf-f6726f83a4d0'
  )
  'Azure Container Storage Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '95de85bd-744d-4664-9dde-11430bc34793'
  )
  'Azure Kubernetes Service Arc Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d3f1697-4507-4d08-bb4a-477695db5f82'
  )
  'Azure Kubernetes Service Arc Cluster User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '233ca253-b031-42ff-9fba-87ef12d6b55f'
  )
  'Azure Kubernetes Service Arc Cluster Admin Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b29efa5f-7782-4dc3-9537-4d5bc70a5e9f'
  )
  'Backup MUA Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c2a970b4-16a7-4a51-8c84-8a8ea6ee0bb8'
  )
  'Backup MUA Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f54b6d04-23c6-443e-b462-9c16ab7b4a52'
  )
  'Savings plan Purchaser': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3d24a3a0-c154-4f6f-a5ed-adc8e01ddb74'
  )
  CrossConnectionManager: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '399c3b2b-64c2-4ff1-af34-571db925b068'
  )
  CrossConnectionReader: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b6ee44de-fe58-4ddc-b5c2-ab174eb23f05'
  )
  'Kubernetes Agent Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5e93ba01-8f92-4c7a-b12a-801e3df23824'
  )
  'Azure API Center Compliance Manager': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ede9aaa3-4627-494e-be13-4aa7c256148d'
  )
  'Azure API Center Service Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6cba8790-29c5-48e5-bab1-c7541b01cb04'
  )
  'Azure API Center Service Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dd24193f-ef65-44e5-8a7e-6fa6e03f7713'
  )
  'Bayer Ag Powered Services Historical Weather Data Solution User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b5b192c1-773c-4543-bfb0-6c59254b74a9'
  )
  'Oracle Subscriptions Manager Built-in Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4caf51ec-f9f5-413f-8a94-b9f5fddba66b'
  )
  'Oracle.Database Owner Built-in Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4562aac9-b209-4bd7-a144-6d7f3bb516f4'
  )
  'Oracle.Database Reader Built-in Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd623d097-b882-4e1e-a26f-ac60e31065a1'
  )
  'Oracle.Database VmCluster Administrator Built-in Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e9ce8739-6fa2-4123-a0a2-0ef41a67806f'
  )
  'Oracle.Database Exadata Infrastructure Administrator Built-in Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4cfdd23b-aece-4fd1-b614-ad3a06c53453'
  )
  'Azure Spring Apps Application Configuration Service Config File Pattern Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '25211fc6-dc78-40b6-b205-e4ac934fd9fd'
  )
  'Azure Messaging Catalog Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f27b7598-bc64-41f7-8a44-855ff16326c2'
  )
  'Azure Hybrid Database Administrator - Read Only Service Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d9c6a55-fc0e-4e21-ae6f-f7b095497342'
  )
  'Microsoft Sentinel Business Applications Agent Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c18f9900-27b8-47c7-a8f0-5b3b3d4c2bc2'
  )
  'Azure ContainerApps Session Executor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0fb8eba5-a2bb-4abe-b1c1-49dfad359bb0'
  )
  'Microsoft.Edge Winfields federated subscription read access role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '83ee7727-862c-4213-8ed8-2ce6c5d69a40'
  )
  'Azure Red Hat OpenShift Federated Credential Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ef318e2a-8334-4a05-9e4a-295a196c6a6e'
  )
  'Bayer Ag Powered Services Crop Id Solution User Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '39138f76-04e6-41f0-ba6b-c411b59081a9'
  )
  'Scheduled Events Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b67fe603-310e-4889-b9ee-8257d09d353d'
  )
  'Compute Recommendations Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'e82342c9-ac7f-422b-af64-e426d2e12b2d'
  )
  'Azure Spring Apps Job Log Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b459aa1d-e3c8-436f-ae21-c0531140f43e'
  )
  'Azure Spring Apps Job Execution Instance List Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '91422e52-bb88-4415-bb4a-90f5b71f6dcb'
  )
  'Nexus Network Fabric Service Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a5eb8433-97a5-4a06-80b2-a877e1622c31'
  )
  'Nexus Network Fabric Service Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '05fdd44c-adc6-4aff-981c-61041f0c929a'
  )
  'Azure Deployment Stack Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'adb29209-aa1d-457b-a786-c913953d2891'
  )
  'Azure Deployment Stack Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bf7f8882-3383-422a-806a-6526c631a88a'
  )
  'Azure Spring Apps Spring Cloud Config Server Log Reader Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '74252426-c508-480e-9345-4607bbebead4'
  )
  'Container Registry Repository Catalog Lister': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bfdb9389-c9a5-478a-bb2f-ba9ca092c3c7'
  )
  'Container Registry Repository Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2efddaa5-3f1f-4df3-97df-af3f13818f4c'
  )
  'Container Registry Repository Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b93aa761-3e63-49ed-ac28-beffa264f7ac'
  )
  'Container Registry Repository Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2a1e307c-b015-4ebd-883e-5b7698a07328'
  )
  'DeID Data Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '78e4b983-1a0b-472e-8b7d-8d770f7c5890'
  )
  'Standby Container Group Pool Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '39fcb0de-8844-4706-b050-c28ddbe3ff83'
  )
  'Compute Gallery Artifacts Publisher': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '85a2d0d9-2eba-4c9c-b355-11c2cc0788ab'
  )
  'ToolchainOrchestrator Viewer Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c5826735-177b-4a0d-a9a3-d0e4b4bda107'
  )
  'ToolchainOrchestrator Admin Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2ccf8795-8983-4912-8036-1c45212c95e8'
  )
  'ProviderHub Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a3ab03bc-5350-42ff-b0d5-00207672db55'
  )
  'ProviderHub Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4d8c6f2e-3fd6-4d40-826e-93e3dc4c3fc1'
  )
  'Azure Stack HCI Connected InfraVMs': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c99c945f-8bd1-4fb1-a903-01460aae6068'
  )
  'VM Restore Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'dfce8971-25e3-42e3-ba33-6055438e3080'
  )
  'HDInsight Cluster Admin': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0847e196-2fd2-4c2f-a48c-fca6fd030f44'
  )
  'Operator Nexus Compute Contributor Role (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4aa368ec-fba9-4e93-81ed-396b3d461cc5'
  )
  'Azure Container Instances Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5d977122-f97e-4b4d-a52f-6b43003ddb4d'
  )
  'Connector Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6cdbb904-5ff3-429d-8169-7d7818b91bd8'
  )
  'Transparency Logs Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8ad4d0ee-9bfb-49e8-93fc-01abb8db6240'
  )
  'Grafana Limited Viewer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '41e04612-9dac-4699-a02b-c82ff2cc3fb5'
  )
  'Disk Encryption Set Operator for Managed Disks': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '136d308c-0937-4a49-9bd7-edfb42adbffc'
  )
  'Bayer Ag Powered Services Field Imagery Solution Service Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1af232de-e806-426f-8ca1-c36142449755'
  )
  'Azure Edge Hardware Center Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9295f069-25d0-4f44-bb6a-3da70d11aa00'
  )
  'Azure AI Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b78c5d69-af96-48a3-bf8d-a8b4d589de94'
  )
  'Compute Gallery Image Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'cf7c76d2-98a3-4358-a134-615aa78bf44d'
  )
  'Container Apps Jobs Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'edd66693-d32a-450b-997d-0158c03976b0'
  )
  'Container Apps Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '358470bc-b998-42bd-ab17-a7e34c199c0f'
  )
  'Container Apps Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f3bd1b5c-91fa-40e7-afe7-0c11d331232c'
  )
  'Container Apps SessionPools Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'af61e8fc-2633-4b95-bed3-421ad6826515'
  )
  'Container Apps SessionPools Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f7669afb-68b2-44b4-9c5f-6d2a47fddda0'
  )
  'Container Apps ManagedEnvironments Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '57cc5028-e6a7-4284-868d-0611c5923f8d'
  )
  'Container Apps ManagedEnvironments Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1b32c00b-7eff-4c22-93e6-93d11d72d2d8'
  )
  'Container Apps Jobs Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4e3d2b60-56ae-4dc6-a233-09c8e5a82e68'
  )
  'Durable Task Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0ad04412-c4d5-4796-b79c-f76d14c8d402'
  )
  'KubernetesRuntime Load Balancer Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1a5682fc-4f12-4b25-927e-e8cfed0c539e'
  )
  'AVS Orchestrator Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd715fb95-a0f0-4f1c-8be6-5ad2d2767f67'
  )
  'Service Connector Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'db7003cd-07a9-490c-bfa5-23e40314f8d7'
  )
  'Azure Device Update Agent': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2a740172-0fc2-4039-972c-b31864cd47d6'
  )
  'Enclave Approver Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2142ea27-02ad-4094-bfea-2dbac6d24934'
  )
  'Key Vault Purge Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a68e7c17-0ab2-4c09-9a58-125dae29748c'
  )
  'Cognitive Services Face Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b5b0c71d-aca9-4081-aee2-9b1bb335fc1a'
  )
  'Container Apps Jobs Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b9a307c4-5aa3-4b52-ba60-2b17c136cd7b'
  )
  'Operator Nexus Owner (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '77be276d-fb44-4f3b-beb5-9bf03c4cd2d3'
  )
  'CloudTest Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '4e9d0bd4-5aab-4f91-92df-9def33fe287c'
  )
  'Azure Automanage Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8d6517c1-e434-405c-9f3f-e0ae65085d76'
  )
  'Azure Bot Service Contributor Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '9fc6112f-f48e-4e27-8b09-72a5c94e4ae9'
  )
  'App Configuration Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '175b81b9-6e0d-490a-85e4-0d422273c10c'
  )
  'App Configuration Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'fe86443c-f201-4fc4-9d2a-ac61149fbda0'
  )
  'Service Fabric Managed Cluster Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '83f80186-3729-438c-ad2d-39e94d718838'
  )
  'Container Registry Data Importer and Data Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '577a9874-89fd-4f24-9dbd-b5034d0ad23a'
  )
  'Azure Batch Service Orchestration Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a35466a1-cfd6-450a-b35e-683fcdf30363'
  )
  'Microsoft PowerBI Tenant Operations Role': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8c87871d-6201-42da-abb1-1c0c985ff71c'
  )
  'Service Fabric Cluster Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b6efc156-f0da-4e90-a50a-8c000140b017'
  )
  'Stream Analytics Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6e0c8711-85a0-4490-8365-8ec13c4560b4'
  )
  'Stream Analytics Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1dfc38e8-6ce7-447f-807c-029c65262c5f'
  )
  'Durable Task Worker': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '80d0d6b0-f522-40a4-8886-a5a11720c375'
  )
  'Microsoft.Windows365.CloudPcDelegatedMsis Writer User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '21bffb94-04c0-4ed0-b676-68bb926e832b'
  )
  'Landing Zone Account Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bf2b6809-e9a5-4aea-a6e1-40a9dc8c43a7'
  )
  'Landing Zone Account Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2718b1f7-eb07-424e-8868-0137541392a1'
  )
  'Defender CSPM Storage Data Scanner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0b6ca2e8-2cdc-4bd6-b896-aa3d8c21fc35'
  )
  'Azure Batch Account Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '11076f67-66f6-4be0-8f6b-f0609fd05cc9'
  )
  'Azure Batch Account Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '29fe4964-1e60-436b-bd3a-77fd4c178b3c'
  )
  'Azure Batch Job Submitter': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '48e5e92e-a480-4e71-aa9c-2778f4c13781'
  )
  'Azure Batch Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6aaa78f1-f7de-44ca-8722-c64a23943cae'
  )
  'Azure Managed Grafana Workspace Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '5c2d7e57-b7c2-4d8a-be4f-82afa42c6e95'
  )
  'Service Group Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'de754d53-652d-4c75-a67f-1e48d8b49c97'
  )
  'Container Apps ConnectedEnvironments Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'd5adeb5b-107f-4aca-99ea-4e3f4fc008d5'
  )
  'Cognitive Services Data Contributor (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '19c28022-e58e-450d-a464-0b2a53034789'
  )
  'Azure Kubernetes Fleet Manager RBAC Cluster Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bd80684d-2f5f-4130-892a-0955546282de'
  )
  'Azure Kubernetes Fleet Manager RBAC Cluster Writer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '1dc4cd5a-de51-4ee4-bc8e-b40e9c17e320'
  )
  'Container Apps ConnectedEnvironments Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '6f4fe6fc-f04f-4d97-8528-8bc18c848dca'
  )
  'Azure Messaging Connectors Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ff478a4e-8633-416e-91bc-ec33ce7c9516'
  )
  'Container Registry Contributor and Data Access Configuration Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '3bc748fc-213d-45c1-8d91-9da5725539b9'
  )
  'App Configuration Data SAS User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '7fd69092-c9bc-4b59-9e2e-bca63317e147'
  )
  'Health Safeguards Data User': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '566f0da3-e2a5-4393-9089-763f8bab8fb6'
  )
  'Container Registry Configuration Reader and Data Access Configuration Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '69b07be0-09bf-439a-b9a6-e73de851bd59'
  )
  'Container Registry Transfer Pipeline Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'bf94e731-3a51-4a7c-8c54-a1ab9971dfc1'
  )
  'Desktop Virtualization App Attach Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '97dfb3ce-e936-462c-9425-9cdb67e66d45'
  )
  'App Service Environment Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8ea85a25-eb16-4e29-ab4d-6f2a26c711a2'
  )
  'Kubernetes Agent Subscription Level Operator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'ada52afe-776a-4b4d-a8f2-55670d3d8178'
  )
  'Quantum Workspace Data Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'c1410b24-3e69-4857-8f86-4d0a2e603250'
  )
  'Communication and Email Service Owner': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '09976791-48a7-449e-bb21-39d1a415f350'
  )
}

@export()
func resolveRoleDefinitionId(
    roleDefinitionTable object,
    roleAssignments RoleAssignment[]
  ) array => map(roleAssignments, assignment => 
    union(assignment, 
    {
      roleDefinitionId: roleDefinitionTable[assignment.roleDefinitionIdOrName] ?? assignment.roleDefinitionIdOrName
    })
)

@export()
type RoleAssignment = {
  @description('Optional. The name (as GUID) of the role assignment. If not provided, a GUID will be generated.')
  name: string?

  @description('Required. The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
  roleDefinitionIdOrName: string // Replace with list of roles

  @description('Required. The principal ID of the principal (user/group/identity) to assign the role to.')
  principalId: string

  @description('Optional. The principal type of the assigned principal ID.')
  principalType: ('ServicePrincipal' | 'Group' | 'User' | 'ForeignGroup' | 'Device')?

  @description('Optional. The description of the role assignment.')
  description: string?

  @description('Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".')
  condition: string?

  @description('Optional. Version of the condition.')
  conditionVersion: '2.0'?

  @description('Optional. The Resource Id of the delegated managed identity resource.')
  delegatedManagedIdentityResourceId: string?
}

