@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectAuditEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectAuditEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectAuditEventSchema'
    etag: '*'
    query: '''
    T | project
        tostring(column_ifexists('Dvc', ''))
      , todatetime(column_ifexists('EventEndTime', ''))
      , tostring(column_ifexists('EventProduct', ''))
      , tostring(column_ifexists('EventResult', ''))
      , tostring(column_ifexists('EventSchema', ''))
      , tostring(column_ifexists('EventSchemaVersion', ''))
      , todatetime(column_ifexists('EventStartTime', ''))
      , tostring(column_ifexists('EventType', ''))
      , tostring(column_ifexists('EventVendor', ''))
      , tostring(column_ifexists('Operation', ''))
      , todatetime(column_ifexists('TimeGenerated', ''))
      , tostring(column_ifexists('Type', ''))
      , tostring(column_ifexists('ActorUsername', ''))
      , tostring(column_ifexists('Dst', ''))
      , tostring(column_ifexists('DvcAction', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcIpAddr', ''))
      , tostring(column_ifexists('EventResultDetails', ''))
      , tostring(column_ifexists('EventSeverity', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('NewValue', ''))
      , tostring(column_ifexists('Object', ''))
      , tostring(column_ifexists('ObjectId', ''))
      , tostring(column_ifexists('Src', ''))
      , tostring(column_ifexists('SrcIpAddr', ''))
      , tostring(column_ifexists('TargetHostname', ''))
      , tostring(column_ifexists('TargetIpAddr', ''))
      , tostring(column_ifexists('ActorUsernameType', ''))
      , tostring(column_ifexists('DvcDomainType', ''))
      , tostring(column_ifexists('IpAddr', ''))
      , tostring(column_ifexists('User', ''))
      , tostring(column_ifexists('Value', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectAuditEventSchema'
  }
}
