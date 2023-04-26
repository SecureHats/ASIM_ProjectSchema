@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

@description('The region of the selected workspace. The default value will use the Region selection above.')
param WorkspaceRegion string = resourceGroup().location

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: Workspace
  location: WorkspaceRegion
}

resource Workspace_ASIM_ProjectNetworkSessionSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectNetworkSessionSchema'
  properties: {
    etag: '*'
    displayName: 'ASIM_ProjectNetworkSessionSchema'
    category: 'ASIM'
    functionAlias: 'ASIM_ProjectNetworkSessionSchema'
    query: '''
    T
    | project
        // Common Mandatory Fields
          todatetime(TimeGenerated)
        , toint(column_ifexists('EventCount', ''))
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
        // NetworkSession Mandatory Fields
        // NetworkSession Recommended Fields
        , tostring(column_ifexists('ASimMatchingHostname', ''))
        , tostring(column_ifexists('ASimMatchingIpAddr', ''))
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('DstDomain', ''))
        , tostring(column_ifexists('DstHostname', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    version: 1
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
  }
}
