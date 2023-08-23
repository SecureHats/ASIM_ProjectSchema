@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}


resource Workspace_ASIM_ProjectWebSessionSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectWebSessionSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectWebSessionSchema'
    query: '''
    T | project
        tostring(column_ifexists('Dst', ''))
      , tostring(column_ifexists('Dvc', ''))
      , toint(column_ifexists('EventCount', ''))
      , todatetime(column_ifexists('EventEndTime', ''))
      , tostring(column_ifexists('EventProduct', ''))
      , tostring(column_ifexists('EventResult', ''))
      , tostring(column_ifexists('EventSchema', ''))
      , tostring(column_ifexists('EventSchemaVersion', ''))
      , tostring(column_ifexists('EventSeverity', ''))
      , todatetime(column_ifexists('EventStartTime', ''))
      , tostring(column_ifexists('EventType', ''))
      , tostring(column_ifexists('EventVendor', ''))
      , todatetime(column_ifexists('TimeGenerated', ''))
      , tostring(column_ifexists('Type', ''))
      , tostring(column_ifexists('ASimMatchingIpAddr', ''))
      , tostring(column_ifexists('DstHostname', ''))
      , tostring(column_ifexists('DstIpAddr', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcIpAddr', ''))
      , tostring(column_ifexists('EventResultDetails', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('Src', ''))
      , tostring(column_ifexists('SrcDomain', ''))
      , tostring(column_ifexists('SrcHostname', ''))
      , tostring(column_ifexists('SrcIpAddr', ''))
      , tostring(column_ifexists('DvcDomainType', ''))
      , tostring(column_ifexists('Hostname', ''))
      , tostring(column_ifexists('HttpStatusCode', ''))
      , tostring(column_ifexists('IpAddr', ''))
      , tostring(column_ifexists('SrcDomainType', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectWebSessionSchema'
  }
}
