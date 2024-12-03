import {resolveRoleDefinitionId} from 'builtInRoles.bicep'

@description('Array of role assignments to create.')
param roleAssignments RoleAssignment[]

@description('The name of the target resource to assign the role to.')
param targetResourceName string

/*
$Roles = Get-AzRoleDefinition
$Roles | Where-Object {$_.IsCustom -eq $false} | 
Where-Object {$_.Actions -like 'Microsoft.KeyVault/vaults*'} |
Foreach-Object {$RoleNameType = @()} {
$RoleName = $_.Name -match ' ' ? "'$($_.Name)'" : $_.Name
$RoleNameType += "'$($_.Name)'"
@"
  ${RoleName}: subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '$($_.Id)'
  )
"@
} {"// $($RoleNameType -join ' | ')"} | Set-Clipboard
*/

var builtInRoleNames = {  
  'Key Vault Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '00482a5a-887f-4fb3-b363-3b7fe8e74483'
  )
  'Key Vault Secrets Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b86a8fe4-44ce-4948-aee5-eccb2c155cd7'
  )
  'Key Vault Certificates Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a4417e6f-fecd-4de8-b567-7b0420556985'
  )
  'Key Vault Reader': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '21090545-7ca7-4776-b22c-e363652d74d2'
  )
  'Key Vault Crypto Officer': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '14b46e9e-c2b7-41b4-b07b-48a6ebf60603'
  )
  'Desktop Virtualization Virtual Machine Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'a959dbd1-f747-45e3-8ba6-dd80f235f97c'
  )
  'Key Vault Data Access Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '8b54135c-b56d-4d72-a534-26097cfdc8d8'
  )
  'Operator Nexus Key Vault Writer Service Role (Preview)': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '44f0a1a8-6fea-4b35-980a-8ff50c487c97'
  )
  'Azure AI Enterprise Network Connection Approver': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'b556d68e-0be0-4f35-a333-ad7ee1ce17ea'
  )
}

resource targetResource 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
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

@export()
type RoleAssignment = {
  @description('Optional. The name (as GUID) of the role assignment. If not provided, a GUID will be generated.')
  name: string?

  @description('Required. The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
  roleDefinitionIdOrName: 'Key Vault Administrator' | 'Key Vault Secrets Officer' | 'Key Vault Certificates Officer' | 'Key Vault Reader' | 'Key Vault Crypto Officer' | 'Desktop Virtualization Virtual Machine Contributor' | 'Key Vault Data Access Administrator' | 'Operator Nexus Key Vault Writer Service Role (Preview)' | 'Azure AI Enterprise Network Connection Approver'

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
