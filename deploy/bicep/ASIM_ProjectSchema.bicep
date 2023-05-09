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
    | where EventSchema == 'Authentication'
    | invoke ASIM_ProjectAuthenticationSchema(optional)
    ;
    let AuditEvent =
    T
    | where EventSchema == 'AuditEvent'
    | invoke ASIM_ProjectAuditEventSchema(optional)
    ;
    let FileEvent =
    T
    | where EventSchema == 'FileEvent'
    | invoke ASIM_ProjectFileEventSchema(optional)
    ;
    let ProcessEvent =
    T
    | where EventSchema == 'ProcessEvent'
    | invoke ASIM_ProjectProcessEventSchema(optional)
    ;
    let RegistryEvent =
    T
    | where EventSchema == 'RegistryEvent'
    | invoke ASIM_ProjectRegistryEventSchema(optional)
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
    | invoke ASIM_ProjectWebSessionSchemaOptional
    ;
    let Dns =
    T
    | where EventSchema == 'Dns'
    | invoke ASIM_ProjectDnsSchema()
    ;
    union isfuzzy = false 
        NetworkSession
      , NetworkSessionOptional
      // , Authentication
      // , AuditEvent
      // , FileEvent
      // , ProcessEvent
      // , RegistryEvent
      , WebSession
      , WebSessionOptional
      , Dns
    | project-away _ItemId*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string, EventSchema:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
