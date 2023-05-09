@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectProcessEventOptional 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: '_ASIM_ProjectProcessEventOptional'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectProcessEventOptional'
    etag: '*'
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
        // ProcessEvent Mandatory Fields
        , tostring(column_ifexists('ActingProcessId', ''))
        , tostring(column_ifexists('ActorUsername', ''))
        , tostring(column_ifexists('TargetProcessCommandLine', ''))
        , tostring(column_ifexists('TargetProcessId', ''))
        , tostring(column_ifexists('TargetProcessName', ''))
        , tostring(column_ifexists('TargetUsername', ''))
        // ProcessEvent Recommended Fields
        , tostring(column_ifexists('ActorUserId', ''))
        , tostring(column_ifexists('Hash', ''))
        , tostring(column_ifexists('ParentProcessId', ''))
        , tostring(column_ifexists('TargetProcessCreationTime', ''))
        , tostring(column_ifexists('TargetUserId', ''))    
        // Process Event Optional Fields
        ,  tostring(column_ifexists('DvcScope', ''))
        , tostring(column_ifexists('DvcScopeId', ''))
        , tostring(column_ifexists('ActingProcessCommandLine', ''))
        , todatetime(column_ifexists('ActingProcessCreationTime', ''))
        , tostring(column_ifexists('ActingProcessFileCompany', ''))
        , tostring(column_ifexists('ActingProcessFileDescription', ''))
        , tostring(column_ifexists('ActingProcessFileInternalName', ''))
        , tostring(column_ifexists('ActingProcessFilename', ''))
        , tostring(column_ifexists('ActingProcessFileOriginalName', ''))
        , tostring(column_ifexists('ActingProcessFileProduct', ''))
        , tolong(column_ifexists('ActingProcessFileSize', ''))
        , tostring(column_ifexists('ActingProcessFileVersion', ''))
        , tostring(column_ifexists('ActingProcessGuid', ''))
        , tostring(column_ifexists('ActingProcessIMPHASH', ''))
        , tostring(column_ifexists('ActingProcessInjectedAddress', ''))
        , tostring(column_ifexists('ActingProcessIntegrityLevel', ''))
        , tostring(column_ifexists('ActingProcessMD5', ''))
        , tostring(column_ifexists('ActingProcessName', ''))
        , tostring(column_ifexists('ActingProcessSHA1', ''))
        , tostring(column_ifexists('ActingProcessSHA256', ''))
        , tostring(column_ifexists('ActingProcessSHA512', ''))
        , tostring(column_ifexists('ActingProcessTokenElevation', ''))
        , tostring(column_ifexists('ActorOriginalUserType', ''))
        , tostring(column_ifexists('ActorSessionId', ''))
        , tostring(column_ifexists('ActorUserAadId', ''))
        , tostring(column_ifexists('ActorUserSid', ''))
        , tostring(column_ifexists('ActorUserType', ''))
        , tostring(column_ifexists('ActorUserUpn', ''))
        , todynamic(column_ifexists('AdditionalFields', ''))
        , tostring(column_ifexists('DvcAction', ''))
        , tostring(column_ifexists('DvcDescription', ''))
        , tostring(column_ifexists('DvcFQDN', ''))
        , tostring(column_ifexists('DvcId', ''))
        , tostring(column_ifexists('DvcIdType', ''))
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
        , tostring(column_ifexists('EventResultDetails', ''))
        , tostring(column_ifexists('EventSeverity', ''))
        , tostring(column_ifexists('EventSubType', ''))
        , todatetime(column_ifexists('ParentProcessCreationTime', ''))
        , tostring(column_ifexists('ParentProcessFileCompany', ''))
        , tostring(column_ifexists('ParentProcessFileDescription', ''))
        , tostring(column_ifexists('ParentProcessFileProduct', ''))
        , tostring(column_ifexists('ParentProcessFileVersion', ''))
        , tostring(column_ifexists('ParentProcessGuid', ''))
        , tostring(column_ifexists('ParentProcessIMPHASH', ''))
        , tostring(column_ifexists('ParentProcessInjectedAddress', ''))
        , tostring(column_ifexists('ParentProcessIntegrityLevel', ''))
        , tostring(column_ifexists('ParentProcessMD5', ''))
        , tostring(column_ifexists('ParentProcessName', ''))
        , tostring(column_ifexists('ParentProcessSHA1', ''))
        , tostring(column_ifexists('ParentProcessSHA256', ''))
        , tostring(column_ifexists('ParentProcessSHA512', ''))
        , tostring(column_ifexists('ParentProcessTokenElevation', ''))
        , tostring(column_ifexists('TargetProcessCurrentDirectory', ''))
        , tostring(column_ifexists('TargetProcessFileCompany', ''))
        , tostring(column_ifexists('TargetProcessFileDescription', ''))
        , tostring(column_ifexists('TargetProcessFileInternalName', ''))
        , tostring(column_ifexists('TargetProcessFilename', ''))
        , tostring(column_ifexists('TargetProcessFileOriginalName', ''))
        , tostring(column_ifexists('TargetProcessFileProduct', ''))
        , tolong(column_ifexists('TargetProcessFileSize', ''))
        , tostring(column_ifexists('TargetProcessFileVersion', ''))
        , tostring(column_ifexists('TargetProcessGuid', ''))
        , tostring(column_ifexists('TargetProcessIMPHASH', ''))
        , tostring(column_ifexists('TargetProcessInjectedAddress', ''))
        , tostring(column_ifexists('TargetProcessIntegrityLevel', ''))
        , tostring(column_ifexists('TargetProcessMD5', ''))
        , tostring(column_ifexists('TargetProcessSHA1', ''))
        , tostring(column_ifexists('TargetProcessSHA256', ''))
        , tostring(column_ifexists('TargetProcessSHA512', ''))
        , tostring(column_ifexists('TargetProcessStatusCode', ''))
        , tostring(column_ifexists('TargetProcessTokenElevation', ''))
        , tostring(column_ifexists('TargetUserAadId', ''))
        , tostring(column_ifexists('TargetUserSessionGuid', ''))
        , tostring(column_ifexists('TargetUserSessionId', ''))
        , tostring(column_ifexists('TargetUserSid', ''))
        , tostring(column_ifexists('TargetUserType', ''))
        , tostring(column_ifexists('TargetUserUpn', ''))
        , tostring(column_ifexists('ActorScopeId', ''))
        , tostring(column_ifexists('ActorScope', ''))
        , tostring(column_ifexists('TargetOriginalUserType', ''))
        , tostring(column_ifexists('TargetScopeId', ''))
        , tostring(column_ifexists('TargetScope', ''))
        , tostring(_ItemId)
    | project-away Column*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string)'
    functionAlias: 'ASIM_ProjectProcessEventOptional'
  }
}
