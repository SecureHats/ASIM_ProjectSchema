@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}


resource Workspace_ASIM_ProjectWebSessionOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectWebSessionOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectWebSessionOptional'
    query: '''T
    | project
        // Web Session Optional Fields
          tostring(column_ifexists('DstScopeId', ''))
        , tostring(column_ifexists('DvcScope', ''))
        , tostring(column_ifexists('DvcScopeId', ''))
        , todynamic(column_ifexists('AdditionalFields', ''))
        , tostring(column_ifexists('ASimMatchingHostname', ''))
        , tostring(column_ifexists('ASimMatchingIpAddr', ''))
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('DstAppId', ''))
        , tostring(column_ifexists('DstAppName', ''))
        , tostring(column_ifexists('DstAppType', ''))
        , tolong(column_ifexists('DstBytes', ''))
        , tostring(column_ifexists('DstDescription', ''))
        , tostring(column_ifexists('DstDeviceType', ''))
        , tostring(column_ifexists('DstDomain', ''))
        , tostring(column_ifexists('DstDomainType', ''))
        , tostring(column_ifexists('DstDvcId', ''))
        , tostring(column_ifexists('DstDvcIdType', ''))
        , tostring(column_ifexists('DstFQDN', ''))
        , tostring(column_ifexists('DstGeoCity', ''))
        , tostring(column_ifexists('DstGeoCountry', ''))
        , tostring(column_ifexists('DstGeoRegion', ''))
        , tostring(column_ifexists('DstHostname', ''))
        , tostring(column_ifexists('DstInterfaceGuid', ''))
        , tostring(column_ifexists('DstInterfaceName', ''))
        , tostring(column_ifexists('DstIpAddr', ''))
        , tostring(column_ifexists('DstMacAddr', ''))
        , tostring(column_ifexists('DstNatIpAddr', ''))
        , toint(column_ifexists('DstNatPortNumber', ''))
        , tostring(column_ifexists('DstOriginalUserType', ''))
        , tolong(column_ifexists('DstPackets', ''))
        , toint(column_ifexists('DstPortNumber', ''))
        , tostring(column_ifexists('DstProcessName', ''))
        , tostring(column_ifexists('DstProcessId', ''))
        , tostring(column_ifexists('DstProcessGuid', ''))
        , tostring(column_ifexists('DstUserId', ''))
        , tostring(column_ifexists('DstUserIdType', ''))
        , tostring(column_ifexists('DstUsername', ''))
        , tostring(column_ifexists('DstUsernameType', ''))
        , tostring(column_ifexists('DstUserType', ''))
        , tostring(column_ifexists('DstVlanId', ''))
        , tostring(column_ifexists('DstZone', ''))
        , toint(column_ifexists('Duration', ''))
        , tostring(column_ifexists('Dvc', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcDomain', ''))
        , tostring(column_ifexists('DvcDomainType', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcHostname', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcIdType', ''))
        , tostring(column_ifexists('DvcInboundInterface', ''))
        , tostring(column_ifexists('DvcInterface', ''))
        , tostring(column_ifexists('DvcIpAddr', ''))
        , tostring(column_ifexists('DvcMacAddr', ''))
        , tostring(column_ifexists('DvcOriginalAction', ''))
        , tostring(column_ifexists('DvcOs', ''))
        , tostring(column_ifexists('DvcOsVersion', ''))
        , tostring(column_ifexists('DvcOutboundInterface', ''))
        , tostring(column_ifexists('DvcZone', ''))
        , toint(column_ifexists('EventCount', ''))
        , todatetime(column_ifexists('EventEndTime', ''))
        , tostring(column_ifexists('EventMessage', ''))
        , tostring(column_ifexists('EventOriginalResultDetails', ''))
        , tostring(column_ifexists('EventOriginalSeverity', ''))
        , tostring(column_ifexists('EventOriginalSubType', ''))
        , tostring(column_ifexists('EventOriginalType', ''))
        , tostring(column_ifexists('EventOriginalUid', ''))
        , tostring(column_ifexists('EventOwner', ''))
        , tostring(column_ifexists('EventProduct', ''))
        , tostring(column_ifexists('EventProductVersion', ''))
        , tostring(column_ifexists('EventReportUrl', ''))
        , tostring(column_ifexists('EventResult', ''))
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventSchema', ''))
        , tostring(column_ifexists('EventSchemaVersion', ''))
        , tostring(column_ifexists('EventSeverity', ''))
        , todatetime(column_ifexists('EventStartTime', ''))
        , tostring(column_ifexists('EventSubType', ''))
        , tostring(column_ifexists('EventType', ''))
        , tostring(column_ifexists('EventUid', ''))
        , tostring(column_ifexists('EventVendor', ''))
        , tostring(column_ifexists('Hostname', ''))
        , tostring(column_ifexists('InnerVlanId', ''))
        , tostring(column_ifexists('IpAddr', ''))
        , tostring(column_ifexists('NetworkApplicationProtocol', ''))
        , tolong(column_ifexists('NetworkBytes', ''))
        , tostring(column_ifexists('NetworkConnectionHistory', ''))
        , tostring(column_ifexists('NetworkDirection', ''))
        , toint(column_ifexists('NetworkDuration', ''))
        , toint(column_ifexists('NetworkIcmpCode', ''))
        , tostring(column_ifexists('NetworkIcmpType', ''))
        , tolong(column_ifexists('NetworkPackets', ''))
        , tostring(column_ifexists('NetworkProtocol', ''))
        , tostring(column_ifexists('NetworkProtocolVersion', ''))
        , tostring(column_ifexists('NetworkRuleName', ''))
        , toint(column_ifexists('NetworkRuleNumber', ''))
        , tostring(column_ifexists('NetworkSessionId', ''))
        , tostring(column_ifexists('OuterVlanId', ''))
        , tostring(column_ifexists('Rule', ''))
        , tostring(column_ifexists('SessionId', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcAppId', ''))
        , tostring(column_ifexists('SrcAppName', ''))
        , tostring(column_ifexists('SrcAppType', ''))
        , tolong(column_ifexists('SrcBytes', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcDomainType', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , tostring(column_ifexists('SrcDvcIdType', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcGeoCity', ''))
        , tostring(column_ifexists('SrcGeoCountry', ''))
        , tostring(column_ifexists('SrcGeoRegion', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('SrcInterfaceGuid', ''))
        , tostring(column_ifexists('SrcInterfaceName', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('SrcMacAddr', ''))
        , tostring(column_ifexists('SrcNatIpAddr', ''))
        , toint(column_ifexists('SrcNatPortNumber', ''))
        , tostring(column_ifexists('SrcOriginalUserType', ''))
        , tolong(column_ifexists('SrcPackets', ''))
        , toint(column_ifexists('SrcPortNumber', ''))
        , tostring(column_ifexists('SrcProcessName', ''))
        , tostring(column_ifexists('SrcProcessId', ''))
        , tostring(column_ifexists('SrcProcessGuid', ''))
        , tostring(column_ifexists('SrcUserId', ''))
        , tostring(column_ifexists('SrcUserIdType', ''))
        , tostring(column_ifexists('SrcUsername', ''))
        , tostring(column_ifexists('SrcUsernameType', ''))
        , tostring(column_ifexists('SrcUserType', ''))
        , tostring(column_ifexists('SrcVlanId', ''))
        , tostring(column_ifexists('SrcZone', ''))
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
        , todatetime(column_ifexists('TimeGenerated', ''))
        , tostring(column_ifexists('Type', ''))
        , tostring(column_ifexists('User', ''))
        , tostring(column_ifexists('SrcScopeId', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectWebSessionOptional'
  }
}