@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string

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
        // NetworkSession Mandatory Fields
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('Src', ''))
        // NetworkSession Recommended Fields
        , tostring(column_ifexists('ASimMatchingHostname', ''))
        , tostring(column_ifexists('ASimMatchingIpAddr', ''))
        , tostring(column_ifexists('DstDomain', ''))
        , tostring(column_ifexists('DstHostname', ''))
        , tostring(column_ifexists('DstIpAddr', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('IpAddr', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        // NetworkSession Optional Fields
        , column_ifexists('AdditionalFields', '')
        , toint(column_ifexists('DstPortNumber', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
    | project-away Column*'''
    version: 1
    functionParameters: 'T:(TimeGenerated:datetime)'
  }
}
