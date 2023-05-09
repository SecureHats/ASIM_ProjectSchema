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
    | where not(optional)
    | where EventSchema == 'NetworkSession'
    | invoke ASIM_ProjectNetworkSessionSchema()
    ;
    let NetworkSessionOptional =
    T
    | where (optional)
    | where EventSchema == 'NetworkSession'
    | invoke ASIM_ProjectNetworkSessionOptional()
    ;
    let Authentication =
    T
    | where not(optional)
    | where EventSchema == 'Authentication'
    | invoke ASIM_ProjectAuthenticationSchema()
    ;
    let AuthenticationOptional =
    T
    | where (optional)
    | where EventSchema == 'Authentication'
    | invoke ASIM_ProjectAuthenticationOptional()
    ;
    let AuditEvent =
    T
    | where not(optional)
    | where EventSchema == 'AuditEvent'
    | invoke ASIM_ProjectAuditEventSchema()
    ;
    let AuditEventOptional =
    T
    | where (optional)
    | where EventSchema == 'AuditEvent'
    | invoke ASIM_ProjectAuditEventOptional()
    ;
    let FileEvent =
    T
    | where not(optional)
    | where EventSchema == 'FileEvent'
    | invoke ASIM_ProjectFileEventSchema()
    ;
    let FileEventOptional =
    T
    | where (optional)
    | where EventSchema == 'FileEvent'
    | invoke ASIM_ProjectFileEventOptional()
    ;
    let ProcessEvent =
    T
    | where not(optional)
    | where EventSchema == 'ProcessEvent'
    | invoke ASIM_ProjectProcessEventSchema()
    ;
    let ProcessEventOptional =
    T
    | where (optional)
    | where EventSchema == 'ProcessEvent'
    | invoke ASIM_ProjectProcessEventOptional()
    ;
    let RegistryEvent =
    T
    | where not(optional)
    | where EventSchema == 'RegistryEvent'
    | invoke ASIM_ProjectRegistryEventSchema()
    ;
    let RegistryEventOptional =
    T
    | where (optional)
    | where EventSchema == 'RegistryEvent'
    | invoke ASIM_ProjectRegistryEventOptional()
    ;
    let WebSession =
    T
    | where not(optional)
    | where EventSchema == 'WebSession'
    | invoke ASIM_ProjectWebSessionSchema()
    ;
    let WebSessionOptional =
    T
    | where (optional)
    | where EventSchema == 'WebSession'
    | invoke ASIM_ProjectWebSessionOptional()
    ;
    let Dns =
    T
    | where not(optional)
    | where EventSchema == 'Dns'
    | invoke ASIM_ProjectDnsSchema()
    ;
    let DnsOptional =
    T
    | where (optional)
    | where EventSchema == 'Dns'
    | invoke ASIM_ProjectDnsOptional()
    ;
    union isfuzzy = false 
        NetworkSession
      , NetworkSessionOptional
      , Authentication
      , AuthenticationOptional
      , AuditEvent
      , AuditEventOptional
      , FileEvent
      , FileEventOptional
      , ProcessEvent
      , ProcessEventOptional
      , RegistryEvent
      , RegistryEventOptional
      , WebSession
      , WebSessionOptional
      , Dns
      , DnsOptional
    | project-away _ItemId*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string, EventSchema:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
