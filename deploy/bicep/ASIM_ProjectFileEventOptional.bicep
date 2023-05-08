@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectFileEventOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectFileEventOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectFileEventOptional'
    etag: '*'
    query: '''
    T
    | project
        // File Event Optional Fields
          tostring(column_ifexists('ActorScope', ''))
        , tostring(column_ifexists('ActorScopeId', ''))
        , tostring(column_ifexists('DvcScope', ''))
        , tostring(column_ifexists('ActingAppId', ''))
        , tostring(column_ifexists('ActingAppName', ''))
        , tostring(column_ifexists('ActingAppType', ''))
        , tostring(column_ifexists('ActingProcessCommandLine', ''))
        , tostring(column_ifexists('ActingProcessGuid', ''))
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActingProcessName', ''))
        , tostring(column_ifexists('ActorOriginalUserType', ''))
        , tostring(column_ifexists('ActorSessionId', ''))
        , tostring(column_ifexists('ActorUpn', ''))
        , tostring(column_ifexists('ActorUserAadId', ''))
        , tostring(column_ifexists('ActorUserPuid', ''))
        , tostring(column_ifexists('ActorUserSid', ''))
        , tostring(column_ifexists('ActorUserType', ''))
        , todynamic(column_ifexists('AdditionalFields', ''))
        , tostring(column_ifexists('DstDescription', ''))
        , tostring(column_ifexists('Dvc', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcInterface', ''))
        , tostring(column_ifexists('DvcMacAddr', ''))
        , tostring(column_ifexists('DvcOriginalAction', ''))
        , tostring(column_ifexists('DvcOs', ''))
        , tostring(column_ifexists('DvcOsVersion', ''))
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
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventSubType', ''))
        , tostring(column_ifexists('HttpUserAgent', ''))
        , tostring(column_ifexists('NetworkApplicationProtocol', ''))
        , tostring(column_ifexists('Rule', ''))
        , tostring(column_ifexists('RuleName', ''))
        , toint(column_ifexists('RuleNumber', ''))
        , tostring(column_ifexists('Src', ''))
        , tostring(column_ifexists('SrcDescription', ''))
        , tostring(column_ifexists('SrcDeviceType', ''))
        , tostring(column_ifexists('SrcDomain', ''))
        , tostring(column_ifexists('SrcDvcId', ''))
        , todatetime(column_ifexists('SrcFileCreationTime', ''))
        , tostring(column_ifexists('SrcFileDirectory', ''))
        , tostring(column_ifexists('SrcFileExtension', ''))
        , tostring(column_ifexists('SrcFileMD5', ''))
        , tostring(column_ifexists('SrcFileMimeType', ''))
        , tostring(column_ifexists('SrcFileName', ''))
        , tostring(column_ifexists('SrcFileSHA1', ''))
        , tostring(column_ifexists('SrcFileSHA256', ''))
        , tostring(column_ifexists('SrcFileSHA512', ''))
        , tolong(column_ifexists('SrcFileSize', ''))
        , tostring(column_ifexists('SrcFQDN', ''))
        , tostring(column_ifexists('SrcGeoCity', ''))
        , tostring(column_ifexists('SrcGeoCountry', ''))
        , tostring(column_ifexists('SrcGeoRegion', ''))
        , tostring(column_ifexists('SrcHostname', ''))
        , toint(column_ifexists('SrcPortNumber', ''))
        , tostring(column_ifexists('TargetAppId', ''))
        , tostring(column_ifexists('TargetAppName', ''))
        , tostring(column_ifexists('TargetAppType', ''))
        , todatetime(column_ifexists('TargetFileCreationTime', ''))
        , tostring(column_ifexists('TargetFileDirectory', ''))
        , tostring(column_ifexists('TargetFileExtension', ''))
        , tostring(column_ifexists('TargetFileMD5', ''))
        , tostring(column_ifexists('TargetFileMimeType', ''))
        , tostring(column_ifexists('TargetFileName', ''))
        , tostring(column_ifexists('TargetFilePath', ''))
        , tostring(column_ifexists('TargetFileSHA1', ''))
        , tostring(column_ifexists('TargetFileSHA256', ''))
        , tostring(column_ifexists('TargetFileSHA512', ''))
        , tolong(column_ifexists('TargetFileSize', ''))
        , tostring(column_ifexists('TargetUrl', ''))
        , tostring(column_ifexists('ThreatCategory', ''))
        , toint(column_ifexists('ThreatConfidence', ''))
        , tostring(column_ifexists('ThreatFilePath', ''))
        , todatetime(column_ifexists('ThreatFirstReportedTime', ''))
        , tostring(column_ifexists('ThreatId', ''))
        , todatetime(column_ifexists('ThreatLastReportedTime', ''))
        , tostring(column_ifexists('ThreatName', ''))
        , tostring(column_ifexists('ThreatOriginalConfidence', ''))
        , tostring(column_ifexists('ThreatOriginalRiskLevel', ''))
        , toint(column_ifexists('ThreatRiskLevel', ''))
        , tostring(column_ifexists('SrcDvcScope', ''))
        , tostring(column_ifexists('SrcDvcScopeId', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectFileEventOptional'
  }
}