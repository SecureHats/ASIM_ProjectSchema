@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}
resource Workspace_ASIM_ProjectDnsSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectDhcpOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectDhcpOptional'
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
        // Dhcp Mandatory Fields
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('SrcMacAddr', ''))
        // Dhcp Recommended Fields
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcDomainType', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventUid', ''))
        // Dhcp Optional Fields
        , tostring(column_ifexists('RequestedIpAddr', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , tostring(column_ifexists('SrcDvcIdType', ''))
        , tostring(column_ifexists('SrcDvcScopeId', ''))
        , tostring(column_ifexists('SrcDvcScope', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcUserId', ''))
        , tostring(column_ifexists('SrcUserIdType', ''))
        , tostring(column_ifexists('SrcUsername', ''))
        , tostring(column_ifexists('SrcUsernameType', ''))
        , tostring(column_ifexists('Username', ''))
        , tostring(column_ifexists('SrcUserType', ''))
        , tostring(column_ifexists('SrcOriginalUserType', ''))
        , toint(column_ifexists('DhcpLeaseDuration', ''))
        , tostring(column_ifexists('DhcpSessionId', ''))
        , tostring(column_ifexists('SessionId', ''))
        , toint(column_ifexists('DhcpSessionDuration', ''))
        , tostring(column_ifexists('DhcpSrcDHCId', ''))
        , tostring(column_ifexists('DhcpCircuitId', ''))
        , tostring(column_ifexists('DhcpSubscriberId', ''))
        , tostring(column_ifexists('DhcpVendorClassId', ''))
        , tostring(column_ifexists('DhcpVendorClass', ''))
        , tostring(column_ifexists('DhcpUserClassId', ''))
        , tostring(column_ifexists('DhcpUserClass', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcInterface', ''))
        , tostring(column_ifexists('DvcMacAddr', ''))
        , tostring(column_ifexists('DvcOriginalAction', ''))
        , tostring(column_ifexists('DvcOs', ''))
        , tostring(column_ifexists('DvcOsVersion', ''))
        , tostring(column_ifexists('DvcZone', ''))
        , tostring(column_ifexists('EventMessage', ''))
        , tostring(column_ifexists('EventOriginalResultDetails', ''))
        , tostring(column_ifexists('EventOriginalSeverity', ''))
        , tostring(column_ifexists('EventOriginalSubType', ''))
        , tostring(column_ifexists('EventOriginalType', ''))
        , tostring(column_ifexists('EventOriginalUid', ''))
        , tostring(column_ifexists('EventOwner', ''))
        , tostring(column_ifexists('EventProductVersion', ''))
        , tostring(column_ifexists('EventReportUrl', ''))
        , tostring(column_ifexists('EventSubType', ''))
        , tostring(column_ifexists('DvcScopeId', ''))
    | project-away Column*
    '''
    functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectDhcpOptional'
  }
}
