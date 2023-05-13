@description('The Microsoft Sentinel workspace into which the function will be deployed. Has to be in the selected Resource Group.')
param Workspace string = ''

resource Workspace_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
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
    let NetworkSessionSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'NetworkSession'
        | invoke ASIM_ProjectNetworkSessionSchema()
      )
    ;
    let NetworkSessionOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'NetworkSession'
        | invoke ASIM_ProjectNetworkSessionOptional()
      )
    ;
    let AuthenticationSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'Authentication'
        | invoke ASIM_ProjectAuthenticationSchema()
      )
    ;
    let AuthenticationOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'Authentication'
        | invoke ASIM_ProjectAuthenticationOptional()    
      )
    ;
    let AuditEventSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'AuditEvent'
        | invoke ASIM_ProjectAuditEventSchema()
      )
    ;
    let AuditEventOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'AuditEvent'
        | invoke ASIM_ProjectAuditEventOptional()
      )
    ;
    let FileEventSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'FileEvent'
        | invoke ASIM_ProjectFileEventSchema()
      )
    ;
    let FileEventOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'FileEvent'
        | invoke ASIM_ProjectFileEventOptional()
      )
    ;
    let ProcessEventSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'ProcessEvent'
        | invoke ASIM_ProjectProcessEventSchema()
      )
    ;
    let ProcessEventOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'ProcessEvent'
        | invoke ASIM_ProjectProcessEventOptional()
      )
    ;
    let RegistryEventSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'RegistryEvent'
        | invoke ASIM_ProjectRegistryEventSchema()
      )
    ;
    let RegistryEventOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'RegistryEvent'
        | invoke ASIM_ProjectRegistryEventOptional()
      )
    ;
    let WebSessionSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'WebSession'
        | invoke ASIM_ProjectWebSessionSchema()
      )
    ;
    let WebSessionOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'WebSession'
        | invoke ASIM_ProjectWebSessionOptional()
      )
    ;
    let DnsSchema =
      materialize(
        T
        | where not(optional)
        | where EventSchema == 'Dns'
        | invoke ASIM_ProjectDnsSchema()
      )
    ;
    let DnsOptional =
      materialize(
        T
        | where (optional)
        | where EventSchema == 'Dns'
        | invoke ASIM_ProjectDnsOptional()
      )
    ;
    union isfuzzy = false 
        *Schema
      , *Optional
    | project-away _ItemId*'''
    functionParameters: 'T:(TimeGenerated:datetime, _ItemId:string, EventSchema:string), optional:bool=false'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
