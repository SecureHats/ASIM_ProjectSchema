@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = 'gsia002-it-weu-a01-stl-oms01'

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' existing = {
  name: Workspace
}

resource Workspace_ASIM_ProjectSchema 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: Workspace_resource
  name: 'ASIM_ProjectSchema'
  properties: {
    version: 1
    category: 'ASIM'
    displayName: 'ASIM_ProjectSchema'
    query: '''
    let NetworkSession =
    T
    | where EventSchema == 'NetworkSession'
    | invoke ASIM_ProjectNetworkSessionSchema()
    ;
    let NetworkSessionOptional = 
    T
    | where EventSchema == 'NetworkSession' 
    | invoke ASIM_ProjectNetworkSessionOptional()
    ;
    let Authentication =
    T
    | where EventSchema == 'Authentication'
    | invoke ASIM_ProjectAuthenticationSchema()
    ;
    let AuthenticationOptional =
    T
    | where EventSchema == 'Authentication'
    | invoke ASIM_ProjectAuthenticationOptional()
    ;
    let AuditEvent =
    T
    | where EventSchema == 'AuditEvent'
    | invoke ASIM_ProjectAuditEventSchema()
    ;
    let AuditEventOptional =
    T
    | where EventSchema == 'AuditEvent'
    | invoke ASIM_ProjectAuditEventOptional()
    ;
    let FileEvent =
    T
    | where EventSchema == 'FileEvent'
    | invoke ASIM_ProjectFileEventSchema()
    ;
    let FileEventOptional =
    T
    | where EventSchema == 'FileEvent'
    | invoke ASIM_ProjectFileEventOptional()
    ;
    let ProcessEvent =
    T
    | where EventSchema == 'ProcessEvent'
    | invoke ASIM_ProjectProcessEventSchema()
    ;
    let ProcessEventOptional =
    T
    | where EventSchema == 'ProcessEvent'
    | invoke ASIM_ProjectProcessEventOptional()
    ;
    let RegistryEvent =
    T
    | where EventSchema == 'RegistryEvent'
    | invoke ASIM_ProjectRegistryEventSchema()
    ;
    let RegistryEventOptional =
    T
    | where EventSchema == 'RegistryEvent'
    | invoke ASIM_ProjectRegistryEventOptional()
    ;
    let WebSession =
    T
    | where EventSchema == 'WebSession'
    | invoke ASIM_ProjectWebSessionSchema()
    ;
    let WebSessionOptional =
    T
    | where EventSchema == 'WebSession'
    | invoke ASIM_ProjectWebSessionOptional()
    ;
    let Dns =
    T
    | where EventSchema == 'Dns'
    | invoke ASIM_ProjectDnsSchema()
    ;
    let DnsOptional =
    T
    | where EventSchema == 'Dns'
    | invoke ASIM_ProjectDnsOptional()
    ;
    union isfuzzy= false 
        (NetworkSession | join kind=inner NetworkSessionOptional on $left._ItemId == $right._ItemId)
      , (Authentication | join kind=inner AuthenticationOptional on $left._ItemId == $right._ItemId)
      , (AuditEvent | join kind=inner AuditEventOptional on $left._ItemId == $right._ItemId)
      , (FileEvent | join kind=inner FileEventOptional on $left._ItemId == $right._ItemId)
      , (ProcessEvent | join kind=inner ProcessEventOptional on $left._ItemId == $right._ItemId)
      , (RegistryEvent | join kind=inner RegistryEventOptional on $left._ItemId == $right._ItemId)
      , (WebSession | join kind=inner WebSessionOptional on $left._ItemId == $right._ItemId)
      , (Dns | join kind=inner DnsOptional on $left._ItemId == $right._ItemId)
      | project-away _ItemId*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string, EventSchema:string)'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
