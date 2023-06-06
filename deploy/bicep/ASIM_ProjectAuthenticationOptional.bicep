@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectAuthenticationOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectAuthenticationOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectAuthenticationOptional'
    etag: '*'
    query: '''
    T
    | project
        // Common Mandatory Fields
          todatetime(TimeGenerated)
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
        // Authentication Schema Mandatory Fields
        // Authentication Schema Recommended Fields
        , tostring(column_ifexists('Dst', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcIpAddr', ''))
        , tostring(column_ifexists('TargetDomain', ''))
        , tostring(column_ifexists('TargetHostname', ''))   
        // Authentication Optional Fields
        , tostring(column_ifexists('ActingAppId', ''))
        , tostring(column_ifexists('ActingAppName', ''))
        , tostring(column_ifexists('ActingAppType', ''))
        , tostring(column_ifexists('ActorOriginalUserType', ''))
        , tostring(column_ifexists('ActorScope', ''))
        , tostring(column_ifexists('ActorScopeId', ''))
        , tostring(column_ifexists('ActorSessionId', ''))
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
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
        , tostring(column_ifexists('LogonMethod', ''))
        , tostring(column_ifexists('LogonProtocol', ''))
        , tostring(column_ifexists('LogonTarget', ''))
        , tostring(column_ifexists('TargetUsernameType', ''))
        , tostring(column_ifexists('Rule', ''))
        , tostring(column_ifexists('RuleName', ''))
        , toint(column_ifexists('RuleNumber', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , tostring(column_ifexists('SrcDvcOs', ''))
        , tostring(column_ifexists('SrcDvcScope', ''))
        , tostring(column_ifexists('SrcDvcScopeId', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcGeoCity', ''))
        , tostring(column_ifexists('SrcGeoCountry', ''))
        , tostring(column_ifexists('SrcGeoRegion', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , tostring(column_ifexists('SrcIsp', ''))
        , toint(column_ifexists('SrcPortNumber', ''))
        , tostring(column_ifexists('TargetAppId', ''))
        , tostring(column_ifexists('TargetAppName', ''))
        , tostring(column_ifexists('TargetAppType', ''))
        , tostring(column_ifexists('TargetDescription', ''))
        , tostring(column_ifexists('TargetDvcId', ''))
        , tostring(column_ifexists('TargetDvcOs', ''))
        , tostring(column_ifexists('TargetDvcScope', ''))
        , tostring(column_ifexists('TargetDvcScopeId', ''))
        , tostring(column_ifexists('TargetDeviceType', ''))
        , tostring(column_ifexists('TargetFQDN', ''))
        , tostring(column_ifexists('TargetGeoCity', ''))
        , tostring(column_ifexists('TargetGeoCountry', ''))
        , tostring(column_ifexists('TargetGeoRegion', ''))
        , tostring(column_ifexists('TargetHostname', ''))
        , tostring(column_ifexists('TargetIpAddr', ''))
        , toint(column_ifexists('TargetPortNumber', ''))
        , tostring(column_ifexists('TargetSessionId', ''))
        , tostring(column_ifexists('TargetSessionId', ''))
        , tostring(column_ifexists('TargetUrl', ''))
        , tostring(column_ifexists('TargetUserId', ''))
        , tostring(column_ifexists('TargetUsername', ''))
        , tostring(column_ifexists('TargetUserType', ''))
        , tostring(column_ifexists('TargetOriginalUserType', ''))
        , tostring(column_ifexists('TargetSessionId', ''))
        , tostring(column_ifexists('TargetUserScope', ''))
        , tostring(column_ifexists('TargetUserScopeId', ''))
        , tostring(column_ifexists('ThreatCategory', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
        , tostring(column_ifexists('ThreatField', ''))
        , todatetime(column_ifexists('ThreatFirstReportedTime', ''))
        , tostring(column_ifexists('ThreatId', ''))
        , todatetime(column_ifexists('ThreatLastReportedTime', ''))
        , tostring(column_ifexists('ThreatName', ''))
        , tostring(column_ifexists('ThreatOriginalConfidence', ''))
        , tostring(column_ifexists('ThreatOriginalRiskLevel', ''))
        , toint(column_ifexists('ThreatRiskLevel', ''))
        , tostring(column_ifexists('User', ''))
        , tostring(column_ifexists('SrcOriginalRiskLevel', ''))
        , toint(column_ifexists('SrcRiskLevel', ''))
        , tostring(column_ifexists('TargetOriginalRiskLevel', ''))
        , toint(column_ifexists('TargetRiskLevel', ''))
        , tostring(column_ifexists('ThreatIpAddr', ''))
        , tostring(column_ifexists('_ItemId', ''))
        , tostring(column_ifexists('Application', ''))
        , tostring(column_ifexists('IpAddr', ''))
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    FunctionAlias: 'ASIM_ProjectAuthenticationOptional'
  }
}
