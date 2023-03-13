@description('The region of the selected workspace. The default value will use the Region selection above.')
param WorkspaceRegion string = resourceGroup().location

@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: Workspace
  location: WorkspaceRegion
}

resource Workspace_ASIM_ProjectRegistryEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectRegistryEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectRegistryEventSchema'
    etag: '*'
    query: '''T
    | project
        // Common Mandatory Fields
          todatetime(column_ifexists('TimeGenerated', ''))
        , tostring(column_ifexists('Type', ''))
        , toint(column_ifexists('EventCount', ''))
        , todatetime(column_ifexists('EventStartTime', ''))
        , todatetime(column_ifexists('EventEndTime', ''))
        , tostring(column_ifexists('EventType', ''))
        , tostring(column_ifexists('EventResult', ''))
        , tostring(column_ifexists('EventProduct', ''))
        , tostring(column_ifexists('EventVendor', ''))
        , tostring(column_ifexists('EventSchema', ''))
        , tostring(column_ifexists('EventSchemaVersion', ''))
        , tostring(column_ifexists('Dvc', ''))
        // Common Recommended Fields
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventSeverity', ''))
        , tostring(column_ifexists('EventUid', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        , tostring(column_ifexists('DvcDomainType', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcIdType', ''))
        , tostring(column_ifexists('DvcAction', ''))
        // ProcessEvent Mandatory Fields
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('TargetProcessCommandLine', ''))
        , tostring(column_ifexists('TargetProcessId', ''))
        , tostring(column_ifexists('TargetProcessName', ''))
        , tostring(column_ifexists('TargetUsername', ''))
        // ProcessEvent Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('Hash', ''))
        , tostring(column_ifexists('ParentProcessId', ''))
        , tostring(column_ifexists('TargetProcessCreationTime', ''))
        , tostring(column_ifexists('TargetUserId', ''))
        // ProcessEvent Optional Fields
        , column_ifexists('AdditionalFields', '')
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime)'
    functionAlias: 'ASIM_ProjectRegistryEventSchema'
  }
}
