@description('The region of the selected workspace. The default value will use the Region selection above.')
param WorkspaceRegion string = resourceGroup().location

@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: Workspace
  location: WorkspaceRegion
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
    T
    | project
        // Common Mandatory Fields
          todatetime('TimeGenerated')
        , tostring('Type')
        , toint('EventCount')
        , todatetime('EventStartTime')
        , todatetime('EventEndTime')
        , tostring('EventType')
        , tostring('EventResult')
        , tostring('EventProduct')
        , tostring('EventVendor')
        , tostring('EventSchema')
        , tostring('EventSchemaVersion')
        , tostring('EventSeverity')
        , tostring('Dvc')
        // Common Recommended Fields
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventUid', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        // AuditEvent Mandatory Fields
        , tostring('Operation')
        // AuditEvent Recommended Fields
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('NewValue', ''))
        , tostring(column_ifexists('Object', ''))
        , tostring(column_ifexists('ObjectId', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('TargetIpAddr', ''))
        , tostring(column_ifexists('TargetHostName', ''))
        , _ItemId
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    FunctionAlias: 'ASIM_ProjectAuditEventSchema'
  }
}
