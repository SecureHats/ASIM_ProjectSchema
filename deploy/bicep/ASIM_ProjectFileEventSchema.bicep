@description('The region of the selected workspace. The default value will use the Region selection above.')
param WorkspaceRegion string = resourceGroup().location

@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: Workspace
  location: WorkspaceRegion
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
          todatetime(TimeGenerated)
        , toint(EventCount)
        , todatetime(EventStartTime)
        , todatetime(EventEndTime)
        , tostring(EventType)
        , tostring(EventResult)
        , tostring(EventProduct)
        , tostring(EventVendor)
        , tostring(EventSchema)
        , tostring(EventSchemaVersion)
        , tostring(EventSeverity)
        , tostring(Dvc)
        // Common Recommended Fields
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventUid', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        // FileEvent Mandatory Fields
        , tostring(ActorUsername)
        , tostring(TargetFilePathType)
        // FileEvent Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('SrcFilePathType', ''))
        , tostring(column_ifexists('SrcFilePath', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectFileEventSchema'
  }
}
