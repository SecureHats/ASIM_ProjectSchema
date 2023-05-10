@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectRegistryEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectRegistryEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectRegistryEventSchema'
    etag: '*'
    query: '''let Parser =
    T
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
        // Registry Event Mandatory Fields
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('RegistryKey', ''))
        // Registry Event Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('ParentProcessId', ''))
        , tostring(column_ifexists('RegistryPreviousKey', ''))
        , tostring(column_ifexists('RegistryPreviousValue', ''))
        , tostring(column_ifexists('RegistryPreviousValueData', ''))
        , tostring(column_ifexists('RegistryPreviousValueType', ''))
        , tostring(column_ifexists('RegistryValue', ''))
        , tostring(column_ifexists('RegistryValueData', ''))
        , tostring(column_ifexists('RegistryValueType', ''))
        , tostring(_ItemId)
    | project-away Column*
    ;
    let OptionalFields = (optional:bool) {
      T
      | where (optional)
      | invoke ASIM_ProjectRegistryEventOptional()
      | project-away Column*
      };
      union isfuzzy = false
      (Parser | join kind=leftouter OptionalFields(optional) on $left._ItemId == $right._ItemId)
      '''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectRegistryEventSchema'
  }
}
