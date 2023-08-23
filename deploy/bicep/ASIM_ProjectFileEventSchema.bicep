@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectFileEventSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectFileEventSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectFileEventSchema'
    etag: '*'
    query: '''
    T | project
        tostring(column_ifexists('ActorUsername', ''))
      , todatetime(column_ifexists('EventEndTime', ''))
      , tostring(column_ifexists('EventProduct', ''))
      , tostring(column_ifexists('EventResult', ''))
      , tostring(column_ifexists('EventSchema', ''))
      , tostring(column_ifexists('EventSchemaVersion', ''))
      , todatetime(column_ifexists('EventStartTime', ''))
      , tostring(column_ifexists('EventType', ''))
      , tostring(column_ifexists('EventVendor', ''))
      , tostring(column_ifexists('TargetFilePathType', ''))
      , todatetime(column_ifexists('TimeGenerated', ''))
      , tostring(column_ifexists('Type', ''))
      , tostring(column_ifexists('ActorUserId', ''))
      , tostring(column_ifexists('DvcAction', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcIpAddr', ''))
      , tostring(column_ifexists('EventSeverity', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('SrcFilePath', ''))
      , tostring(column_ifexists('SrcFilePathType', ''))
      , tostring(column_ifexists('SrcIpAddr', ''))
      , tostring(column_ifexists('ActorUserIdType', ''))
      , tostring(column_ifexists('ActorUsernameType', ''))
      , tostring(column_ifexists('DvcDomainType', ''))
      , tostring(column_ifexists('IpAddr', ''))
      , tostring(column_ifexists('User', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectFileEventSchema'
  }
}
