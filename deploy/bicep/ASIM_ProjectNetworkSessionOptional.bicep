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
  name: '_ASIM_ProjectNetworkSessionOptional'
  properties: {
    etag: '*'
    displayName: 'ASIM_ProjectNetworkSessionOptional'
    category: 'ASIM'
    functionAlias: 'ASIM_ProjectNetworkSessionOptional'
    query: '''
    T
    | project
        // NetworkSession Optional Fields
          column_ifexists('AdditionalFields', '')
        , tostring(column_ifexists('EventUid', ''))
        , toint(column_ifexists('DstPortNumber', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
    | project-away Column*'''
    version: 1
    functionParameters: 'T:(TimeGenerated:datetime)'
  }
}
