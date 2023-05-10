@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectProcessEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectProcessEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectProcessEventSchema'
    etag: '*'
    query: '''
    let Parser =
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
        // ProcessEvent Mandatory Fields
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('TargetProcessCommandLine', ''))
        , tostring(column_ifexists('TargetProcessId', ''))
        , tostring(column_ifexists('TargetProcessName', ''))
        , tostring(column_ifexists('TargetUsername', ''))
        // ProcessEvent Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('DvcDomainType', ''))
        , tostring(column_ifexists('Hash', ''))
        , tostring(column_ifexists('ParentProcessId', ''))
        , todatetime(column_ifexists('TargetProcessCreationTime', ''))
        , tostring(column_ifexists('TargetUserId', ''))
        , tostring(column_ifexists('_ItemId', ''))
    | project-away Column*
    ;
    let OptionalFields = (optional:bool) {
      T
      | where (optional)
      | invoke ASIM_ProjectProcessEventOptional()
      | project-away Column*
      };
      union isfuzzy = false
      (Parser | join kind=leftouter OptionalFields(optional) on $left._ItemId == $right._ItemId)
    '''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectProcessEventSchema'
  }
}
