@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectAuditEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2022-10-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectAuditEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectAuditEventSchema'
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
        // AuditEvent Mandatory Fields
        , tostring(column_ifexists('Operation', ''))
        // AuditEvent Recommended Fields
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('NewValue', ''))
        , tostring(column_ifexists('Object', ''))
        , tostring(column_ifexists('ObjectId', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('TargetIpAddr', ''))
        , tostring(column_ifexists('TargetHostname', ''))
        , tostring(column_ifexists('_ItemId', ''))
    | project-away Column*
    ;
    let OptionalFields = (optional:bool) {
      T
      | where (optional)
      | invoke ASIM_ProjectAuditEventOptional()
      | project-away Column*
      };
      union isfuzzy = false
      (Parser | join kind=leftouter OptionalFields(optional) on $left._ItemId == $right._ItemId)
    '''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string), optional:bool=false'
    FunctionAlias: 'ASIM_ProjectAuditEventSchema'
  }
}
