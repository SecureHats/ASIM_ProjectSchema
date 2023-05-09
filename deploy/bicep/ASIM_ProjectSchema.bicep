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
    // let Authentication =
    // T
    // | where EventSchema == 'Authentication'
    // | invoke ASIM_ProjectAuthenticationSchema()
    // ;
    // let AuditEvent =
    // T
    // | where EventSchema == 'AuditEvent'
    // | invoke ASIM_ProjectAuditEventSchema()
    // ;
    // let FileEvent =
    // T
    // | where EventSchema == 'FileEvent'
    // | invoke ASIM_ProjectFileEventSchema()
    // ;
    // let ProcessEvent =
    // T
    // | where EventSchema == 'ProcessEvent'
    // | invoke ASIM_ProjectProcessEventSchema()
    // ;
    // let RegistryEvent =
    // T
    // | where EventSchema == 'RegistryEvent'
    // | invoke ASIM_ProjectRegistryEventSchema()
    // ;
    let WebSession =
    T
    | where EventSchema == 'WebSession'
    | invoke ASIM_ProjectWebSessionSchema(optional)
    ;
    // let Dns =
    // T
    // | where EventSchema == 'Dns'
    // | invoke ASIM_ProjectDnsSchema()
    // ;
    union isfuzzy = false 
        NetworkSession
      , Authentication
      , AuditEvent
      , FileEvent
      , ProcessEvent
      , RegistryEvent
      , WebSession
      , Dns
    | project-away _ItemId*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string, EventSchema:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
