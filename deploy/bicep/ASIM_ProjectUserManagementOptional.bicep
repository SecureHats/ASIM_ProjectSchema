@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectUserManagementSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectUserManagementOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectUserManagementOptional'
    etag: '*'
    query: '''
    T | project
        tostring(column_ifexists('ActorUsername', ''))
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
      , tostring(column_ifexists('DvcAction', ''))
      , tostring(column_ifexists('DvcDomain', ''))
      , tostring(column_ifexists('DvcFQDN', ''))
      , tostring(column_ifexists('DvcHostname', ''))
      , tostring(column_ifexists('DvcId', ''))
      , tostring(column_ifexists('DvcIdType', ''))
      , tostring(column_ifexists('EventResultDetails', ''))
      , tostring(column_ifexists('EventUid', ''))
      , tostring(column_ifexists('Src', ''))
      , tostring(column_ifexists('SrcDomain', ''))
      , tostring(column_ifexists('SrcDomainType', ''))
      , tostring(column_ifexists('SrcHostname', ''))
      , tostring(column_ifexists('ActingAppId', ''))
      , tostring(column_ifexists('ActingAppType', ''))
      , tostring(column_ifexists('ActiveAppName', ''))
      , tostring(column_ifexists('ActorSessionId', ''))
      , tostring(column_ifexists('ActorUserId', ''))
      , tostring(column_ifexists('ActorUserType', ''))
      , todynamic(column_ifexists('AdditionalFields', ''))
      , tostring(column_ifexists('DvcDescription', ''))
      , tostring(column_ifexists('DvcInterface', ''))
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
      , tostring(column_ifexists('GroupId', ''))
      , tostring(column_ifexists('GroupIdType', ''))
      , tostring(column_ifexists('GroupName', ''))
      , tostring(column_ifexists('GroupNameType', ''))
      , tostring(column_ifexists('GroupOriginalType', ''))
      , tostring(column_ifexists('GroupType', ''))
      , tostring(column_ifexists('HttpUserAgent', ''))
      , tostring(column_ifexists('NewPropertyValue', ''))
      , tostring(column_ifexists('PreviousPropertyValue', ''))
      , tostring(column_ifexists('SrcDeviceType', ''))
      , tostring(column_ifexists('SrcDvcId', ''))
      , tostring(column_ifexists('SrcDvcScope', ''))
      , tostring(column_ifexists('SrcDvcScopeId', ''))
      , tostring(column_ifexists('SrcFQDN', ''))
      , tostring(column_ifexists('TargetOriginalUserType', ''))
      , tostring(column_ifexists('TargetUserId', ''))
      , tostring(column_ifexists('TargetUsername', ''))
      , tostring(column_ifexists('TargetUserType', ''))
      , tostring(column_ifexists('ActorUserIdType', ''))
      , tostring(column_ifexists('ActorUsernameType', ''))
      , tostring(column_ifexists('DvcDomainType', ''))
      , tostring(column_ifexists('Hostname', ''))
      , tostring(column_ifexists('IpAddr', ''))
      , tostring(column_ifexists('SrcDvcIdType', ''))
      , tostring(column_ifexists('TargetUserIdType', ''))
      , tostring(column_ifexists('TargetUsernameType', ''))
      , tostring(column_ifexists('UpdatedPropertyName', ''))
      , tostring(column_ifexists('User', ''))
  | project-away Column*'''
  functionParameters: 'T:(*), optional:bool=false'
    functionAlias: 'ASIM_ProjectUserManagementOptional'
  }
}
