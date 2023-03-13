@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string

@description('The region of the selected workspace. The default value will use the Region selection above.')
param WorkspaceRegion string = resourceGroup().location

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: Workspace
  location: WorkspaceRegion
}

resource Workspace_ASIM_ProjectAuthenticationSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: 'ASIM_ProjectAuthenticationSchema'
  properties: {
    etag: '*'
    displayName: 'ASIM_ProjectAuthenticationSchema'
    category: 'ASIM'
    functionAlias: 'ASIM_ProjectAuthenticationSchema'
    query: 'T\n| project\n    // Common Mandatory Fields\n      todatetime(column_ifexists(\'TimeGenerated\', \'\'))\n      , tostring(column_ifexists(\'Type\', \'\'))\n      , toint(column_ifexists(\'EventCount\', \'\'))\n    , todatetime(column_ifexists(\'EventStartTime\', \'\'))\n    , todatetime(column_ifexists(\'EventEndTime\', \'\'))\n    , tostring(column_ifexists(\'EventType\', \'\'))\n    , tostring(column_ifexists(\'EventResult\', \'\'))\n    , tostring(column_ifexists(\'EventProduct\', \'\'))\n    , tostring(column_ifexists(\'EventVendor\', \'\'))\n    , tostring(column_ifexists(\'EventSchema\', \'\'))\n    , tostring(column_ifexists(\'EventSchemaVersion\', \'\'))\n    , tostring(column_ifexists(\'Dvc\', \'\'))\n    // Common Recommended Fields\n    , tostring(column_ifexists(\'EventResultDetails\', \'\'))\n    , tostring(column_ifexists(\'EventSeverity\', \'\'))\n    , tostring(column_ifexists(\'EventUid\', \'\'))\n    , tostring(column_ifexists(\'DvcIpAddr\', \'\'))\n    , tostring(column_ifexists(\'DvcHostname\', \'\'))\n    , tostring(column_ifexists(\'DvcDomain\', \'\'))\n    , tostring(column_ifexists(\'DvcDomainType\', \'\'))\n    , tostring(column_ifexists(\'DvcFQDN\', \'\'))\n    , tostring(column_ifexists(\'DvcId\', \'\'))\n    , tostring(column_ifexists(\'DvcIdType\', \'\'))\n    , tostring(column_ifexists(\'DvcAction\', \'\'))\n    // Authentication Schema Recommended Fields\n    , tostring(column_ifexists(\'Dst\', \'\'))\n    , tostring(column_ifexists(\'Src\', \'\'))\n    , tostring(column_ifexists(\'SrcIpAddr\', \'\'))\n    , tostring(column_ifexists(\'IpAddr\', \'\'))\n    , tostring(column_ifexists(\'SrcHostname\', \'\'))\n    , tostring(column_ifexists(\'SrcDomain\', \'\'))\n    , tostring(column_ifexists(\'SrcDomainType\', \'\'))\n    , tostring(column_ifexists(\'TargetHostname\', \'\'))\n    , tostring(column_ifexists(\'TargetDomain\', \'\'))\n| project-away Column*'
    version: 1
    functionParameters: 'T:(TimeGenerated:datetime)'
  }
}