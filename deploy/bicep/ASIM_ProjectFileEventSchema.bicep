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
    T
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
      , tostring(column_ifexists('EventSeverity', ''))
      , tostring(column_ifexists('Dvc', ''))
      // Common Recommended Fields
      , tostring(column_ifexists('EventResultDetails', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('DvcIpAddr', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      // FileEvent Mandatory Fields
      , tostring(column_ifexists('ActorUsername', ''))
      , tostring(column_ifexists('TargetFilePathType', ''))
      // FileEvent Recommended Fields
      , tostring(column_ifexists('ActorUserId', ''))
      , tostring(column_ifexists('DvcAction', ''))
      , tostring(column_ifexists('SrcFilePath', ''))
      , tostring(column_ifexists('SrcFilePathType', ''))
      , tostring(column_ifexists('SrcIpAddr', ''))
      , tostring(column_ifexists('_ItemId', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectFileEventSchema'
  }
}
