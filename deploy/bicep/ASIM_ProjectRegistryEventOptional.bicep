@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}


resource Workspace_ASIM_ProjectRegistryEventOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectRegistryEventOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectWebSessionOptional'
    query: '''T
    | project
        // Common Mandatory Fields
          todatetime(TimeGenerated)
        , toint(column_ifexists('EventCount', ''))
        , todatetime(column_ifexists('EventStartTime', ''))
        , todatetime(column_ifexists('EventEndTime', ''))
        , tostring(column_ifexists('EventType', ''))
        , tostring(column_ifexists('EventResult', ''))
        , tostring(column_ifexists('EventProduct', ''))
        , tostring(column_ifexists('EventVendor', ''))
        , tostring(column_ifexists('EventSchema', ''))
        , tostring(column_ifexists('EventSchemaVersion', ''))
        , tostring(column_ifexists('EventSeverity', ''))
        , tostring(column_ifexists('Dvc', ''))
        // Common Recommended Fields
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventUid', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        // ProcessEvent Mandatory Fields
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('RegistryKey', ''))
        // ProcessEvent Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('ParentProcessId', ''))
        , tostring(column_ifexists('RegistryPreviousKey', ''))
        , tostring(column_ifexists('RegistryPreviousValue', ''))
        , tostring(column_ifexists('RegistryPreviousValueData', ''))
        , tostring(column_ifexists('RegistryPreviousValueType', ''))
        , tostring(column_ifexists('RegistryValue', ''))
        , tostring(column_ifexists('RegistryValueData', ''))
        , tostring(column_ifexists('RegistryValueType', ''))
          // Registry Event Optional Fields
        , tostring(column_ifexists('DvcScope', ''))
        , tostring(column_ifexists('DvcScopeId', ''))
        , tostring(column_ifexists('ActingProcessGuid', ''))
        , tostring(column_ifexists('ActingProcessName', ''))
        , tostring(column_ifexists('ActorSessionId', ''))
        , todynamic(column_ifexists('AdditionalFields', ''))
        , tostring(column_ifexists('DstDescription', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcMacAddr', ''))
        , tostring(column_ifexists('DvcOs', ''))
        , tostring(column_ifexists('DvcOsVersion', ''))
        , tostring(column_ifexists('EventMessage', ''))
        , tostring(column_ifexists('EventOriginalSubType', ''))
        , tostring(column_ifexists('EventOriginalType', ''))
        , tostring(column_ifexists('EventOriginalUid', ''))
        , tostring(column_ifexists('EventOwner', ''))
        , tostring(column_ifexists('EventProductVersion', ''))
        , tostring(column_ifexists('EventReportUrl', ''))
        , tostring(column_ifexists('ParentProcessGuid', ''))
        , tostring(column_ifexists('ParentProcessName', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('_ItemId', ''))
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectRegistryEventOptional'
  }
}
