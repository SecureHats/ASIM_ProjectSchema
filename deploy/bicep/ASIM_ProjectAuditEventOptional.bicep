@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectAuditEventOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2022-10-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectAuditEventOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectAuditEventOptional'
    etag: '*'
    query: '''
    T
    | project
        // Audit Event Optional Fields
          tostring(column_ifexists('ActingAppId', ''))
        , tostring(column_ifexists('ActingAppName', ''))
        , tostring(column_ifexists('ActingAppType', ''))
        , tostring(column_ifexists('ActorOriginalUserType', ''))
        , tostring(column_ifexists('ActorScope', ''))
        , tostring(column_ifexists('ActorScopeId', ''))
        , tostring(column_ifexists('ActorSessionId', ''))
        , tostring(column_ifexists('ActorUserAadId', ''))
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('ActorUserSid', ''))
        , tostring(column_ifexists('ActorUserType', ''))
        , todynamic(column_ifexists('AdditionalFields', ''))
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
        , toint(column_ifexists('EventCount', ''))
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
        , tostring(column_ifexists('HttpUserAgent', ''))
        , tostring(column_ifexists('OldValue', ''))
        , tostring(column_ifexists('Rule', ''))
        , tostring(column_ifexists('RuleName', ''))
        , toint(column_ifexists('RuleNumber', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , tostring(column_ifexists('SrcDvcScope', ''))
        , tostring(column_ifexists('SrcDvcScopeId', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcGeoCity', ''))
        , tostring(column_ifexists('SrcGeoCountry', ''))
        , tostring(column_ifexists('SrcGeoRegion', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , toint(column_ifexists('SrcPortNumber', ''))
        , tostring(column_ifexists('TargetAppId', ''))
        , tostring(column_ifexists('TargetAppName', ''))
        , tostring(column_ifexists('TargetDescription', ''))
        , tostring(column_ifexists('TargetDeviceType', ''))
        , tostring(column_ifexists('TargetDomain', ''))
        , tostring(column_ifexists('TargetDvcId', ''))
        , tostring(column_ifexists('TargetDvcScope', ''))
        , tostring(column_ifexists('TargetDvcScopeId', ''))
        , tostring(column_ifexists('TargetFQDN', ''))
        , tostring(column_ifexists('TargetGeoCity', ''))
        , tostring(column_ifexists('TargetGeoCountry', ''))
        , tostring(column_ifexists('TargetGeoRegion', ''))
        , toint(column_ifexists('TargetPortNumber', ''))
        , tostring(column_ifexists('TargetUrl', ''))
        , tostring(column_ifexists('ThreatCategory', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
        , todatetime(column_ifexists('ThreatFirstReportedTime', ''))
        , tostring(column_ifexists('ThreatId', ''))
        , tostring(column_ifexists('ThreatIpAddr', ''))
        , todatetime(column_ifexists('ThreatLastReportedTime', ''))
        , tostring(column_ifexists('ThreatName', ''))
        , tostring(column_ifexists('ThreatOriginalConfidence', ''))
        , tostring(column_ifexists('ThreatOriginalRiskLevel', ''))
        , toint(column_ifexists('ThreatRiskLevel', ''))
        , tostring(column_ifexists('ValueType', ''))
        , tostring(column_ifexists('SrcOriginalRiskLevel', ''))
        , toint(column_ifexists('SrcRiskLevel', ''))
        , tostring(column_ifexists('TargetOriginalRiskLevel', ''))
        , toint(column_ifexists('TargetRiskLevel', ''))
        , tostring(column_ifexists('TargetDvcOs', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    FunctionAlias: 'ASIM_ProjectAuditEventOptional'
  }
}