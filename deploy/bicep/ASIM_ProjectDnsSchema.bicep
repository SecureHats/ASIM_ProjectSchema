@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}
resource Workspace_ASIM_ProjectDnsSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectDnsSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectDnsSchema'
    query: '''
    T | project
        tostring(column_ifexists('Dvc', ''))
      , toint(column_ifexists('EventCount', ''))
      , todatetime(column_ifexists('EventEndTime', ''))
      , tostring(column_ifexists('EventProduct', ''))
      , tostring(column_ifexists('EventResult', ''))
      , tostring(column_ifexists('EventResultDetails', ''))
      , tostring(column_ifexists('EventSchema', ''))
      , tostring(column_ifexists('EventSchemaVersion', ''))
      , todatetime(column_ifexists('EventStartTime', ''))
      , tostring(column_ifexists('EventType', ''))
      , tostring(column_ifexists('EventVendor', ''))
      , tostring(column_ifexists('Src', ''))
      , todatetime(column_ifexists('TimeGenerated', ''))
      , tostring(column_ifexists('Type', ''))
      , tostring(column_ifexists('DnsQuery', ''))
      , tostring(column_ifexists('DnsQueryClassName', ''))
      , tostring(column_ifexists('Dst', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcIpAddr', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('SrcDomain', ''))
      , tostring(column_ifexists('SrcHostname', ''))
      , tostring(column_ifexists('SrcIpAddr', ''))
      , tostring(column_ifexists('TransactionIdHex', ''))
      , tostring(column_ifexists('DnsResponseCodeName', ''))
      , tostring(column_ifexists('Domain', ''))
      , tostring(column_ifexists('DvcDomainType', ''))
      , tostring(column_ifexists('Hostname', ''))
      , tostring(column_ifexists('IpAddr', ''))
      , tostring(column_ifexists('SrcDomainType', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectDnsSchema'
  }
}
