@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}
resource Workspace_ASIM_ProjectDnsOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectDnsOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectDnsOptional'
    query: '''
    T
    | project
        // Common Mandatory Fields
          todatetime(TimeGenerated)
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
        // Dns Mandatory Fields
        , tostring(column_ifexists('DnsQuery', ''))
        // Dns Recommended Fields
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('DnsQueryTypeName', ''))
        , tostring(column_ifexists('TransactionIdHex', ''))    
        // DNS Schema Optional Fields
        ,  todynamic(column_ifexists('AdditionalFields', ''))
        , tostring(column_ifexists('DnsFlags', ''))
        , toint(column_ifexists('DnsNetworkDuration', ''))
        , toint(column_ifexists('DnsQueryClass', ''))
        , toint(column_ifexists('DnsQueryType', ''))
        , tostring(column_ifexists('DnsQueryTypeName', ''))
        , toint(column_ifexists('DnsResponseCode', ''))
        , tostring(column_ifexists('DnsResponseIpCity', ''))
        , tostring(column_ifexists('DnsResponseIpCountry', ''))
        , tostring(column_ifexists('DnsResponseIpRegion', ''))
        , tostring(column_ifexists('DnsResponseName', ''))
        , tostring(column_ifexists('DnsSessionId', ''))
        , tostring(column_ifexists('DstDescription', ''))
        , tostring(column_ifexists('DstDeviceType', ''))
        , tostring(column_ifexists('DstDomain', ''))
        , tostring(column_ifexists('DstDvcId', ''))
        , tostring(column_ifexists('DstDvcScopeId', ''))
        , tostring(column_ifexists('DstDvcScope', ''))
        , tostring(column_ifexists('DstFQDN', ''))
        , tostring(column_ifexists('DstGeoCity', ''))
        , tostring(column_ifexists('DstGeoCountry', ''))
        , tostring(column_ifexists('DstGeoRegion', ''))
        , tostring(column_ifexists('DstHostname', ''))
        , tostring(column_ifexists('DstIpAddr', ''))
        , toint(column_ifexists('DstPortNumber', ''))
        , toint(column_ifexists('DstRiskLevel', ''))
        , tostring(column_ifexists('DstOriginalRiskLevel', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcInterface', ''))
        , tostring(column_ifexists('DvcMacAddr', ''))
        , tostring(column_ifexists('DvcOriginalAction', ''))
        , tostring(column_ifexists('DvcOs', ''))
        , tostring(column_ifexists('DvcOsVersion', ''))
        , tostring(column_ifexists('DvcScope', ''))
        , tostring(column_ifexists('DvcScopeId', ''))
        , tostring(column_ifexists('DvcZone', ''))
        , tostring(column_ifexists('EventMessage', ''))
        , tostring(column_ifexists('EventOriginalSeverity', ''))
        , tostring(column_ifexists('EventOriginalSubType', ''))
        , tostring(column_ifexists('EventOriginalType', ''))
        , tostring(column_ifexists('EventOriginalUid', ''))
        , tostring(column_ifexists('EventOwner', ''))
        , tostring(column_ifexists('EventProductVersion', ''))
        , tostring(column_ifexists('EventReportUrl', ''))
        , tostring(column_ifexists('EventSubType', ''))
        , tostring(column_ifexists('NetworkProtocol', ''))
        , tostring(column_ifexists('NetworkProtocolVersion', ''))
        , tostring(column_ifexists('Rule', ''))
        , tostring(column_ifexists('RuleName', ''))
        , toint(column_ifexists('RuleNumber', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , tostring(column_ifexists('SrcDvcScope', ''))
        , tostring(column_ifexists('SrcDvcScopeId', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcGeoCity', ''))
        , tostring(column_ifexists('SrcGeoCountry', ''))
        , tostring(column_ifexists('SrcGeoRegion', ''))
        , tostring(column_ifexists('SrcOriginalRiskLevel', ''))
        , toint(column_ifexists('SrcPortNumber', ''))
        , tostring(column_ifexists('SrcProcessGuid', ''))
        , tostring(column_ifexists('SrcProcessId', ''))
        , tostring(column_ifexists('SrcProcessName', ''))
        , toint(column_ifexists('SrcRiskLevel', ''))
        , tostring(column_ifexists('SrcUserId', ''))
        , tostring(column_ifexists('SrcUserAadId', ''))
        , tostring(column_ifexists('SrcUserSid', ''))
        , tostring(column_ifexists('SrcUserAWSId', ''))
        , tostring(column_ifexists('SrcUserOktaId', ''))
        , tostring(column_ifexists('SrcUserUid', ''))
        , tostring(column_ifexists('SrcUserScope', ''))
        , tostring(column_ifexists('SrcUserScopeId', ''))
        , tostring(column_ifexists('SrcUsername', ''))
        , tostring(column_ifexists('SrcUserType', ''))
        , tostring(column_ifexists('SrcOriginalUserType', ''))
        , tostring(column_ifexists('SrcUserSessionId', ''))
        , tostring(column_ifexists('TenantId', ''))
        , tostring(column_ifexists('ThreatCategory', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
        , tostring(column_ifexists('ThreatField', ''))
        , todatetime(column_ifexists('ThreatFirstReportedTime', ''))
        , tostring(column_ifexists('ThreatId', ''))
        , tostring(column_ifexists('ThreatIpAddr', ''))
        , todatetime(column_ifexists('ThreatLastReportedTime', ''))
        , tostring(column_ifexists('ThreatName', ''))
        , tostring(column_ifexists('ThreatOriginalConfidence', ''))
        , tostring(column_ifexists('ThreatOriginalRiskLevel', ''))
        , toint(column_ifexists('ThreatRiskLevel', ''))
        , tostring(column_ifexists('UrlCategory', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectDnsOptional'
  }
}
