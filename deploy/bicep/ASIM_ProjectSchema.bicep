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
    let NetworkSession =
        T
        | where EventSchema == 'NetworkSession'
            and not(optional)
        | invoke ASIM_ProjectNetworkSessionSchema()
    ;
    let NetworkSessionOptional =
        T
        | where EventSchema == 'NetworkSession'
            and (optional)
        | invoke ASIM_ProjectNetworkSessionOptional()
    ;
    let Authentication =
        T
        | where EventSchema == 'Authentication'
            and not(optional)
        | invoke ASIM_ProjectAuthenticationSchema()
    ;
    let AuthenticationOptional =
        T
        | where EventSchema == 'Authentication'
            and (optional)
        | invoke ASIM_ProjectAuthenticationOptional()
    ;
    let AuditEvent =
        T
        | where EventSchema == 'AuditEvent'
            and not(optional)
        | invoke ASIM_ProjectAuditEventSchema()
    ;
    let AuditEventOptional =
        T
        | where EventSchema == 'AuditEvent'
            and (optional)
        | invoke ASIM_ProjectAuditEventOptional()
    ;
    let FileEvent =
        T
        | where EventSchema == 'FileEvent'
            and not(optional)
        | invoke ASIM_ProjectFileEventSchema()
    ;
    let FileEventOptional =
        T
        | where EventSchema == 'FileEvent'
            and (optional)
        | invoke ASIM_ProjectFileEventOptional()
    ;
    let ProcessEvent =
        T
        | where EventSchema == 'ProcessEvent'
            and not(optional)
        | invoke ASIM_ProjectProcessEventSchema()
    ;
    let ProcessEventOptional =
        T
        | where EventSchema == 'ProcessEvent'
            and (optional)
        | invoke ASIM_ProjectProcessEventOptional()
    ;
    let RegistryEvent =
        T
        | where EventSchema == 'RegistryEvent'
            and not(optional)
        | invoke ASIM_ProjectRegistryEventSchema()
    ;
    let RegistryEventOptional =
        T
        | where EventSchema == 'RegistryEvent'
            and (optional)
        | invoke ASIM_ProjectRegistryEventOptional()
    ;
    let WebSession =
        T
        | where EventSchema == 'WebSession'
            and not(optional)
        | invoke ASIM_ProjectWebSessionSchema()
    ;
    let WebSessionOptional =
        T
        | where EventSchema == 'WebSession'
            and (optional)
        | invoke ASIM_ProjectWebSessionOptional()
    ;
    let Dns =
        T
        | where EventSchema == 'Dns'
            and not(optional)
        | invoke ASIM_ProjectDnsSchema()
    ;
    let DnsOptional =
        T
        | where EventSchema == 'Dns'
            and (optional)
        | invoke ASIM_ProjectDnsOptional()
    ;
    let UserManagement =
        T
        | where EventSchema == 'UserManagement'
            and not(optional)
        | invoke ASIM_ProjectUserManagementSchema()
    ;
    let UserManagementOptional =
        T
        | where EventSchema == 'UserManagement'
            and (optional)
        | invoke ASIM_ProjectUserManagementOptional()
    ;
    let Dhcp =
        T
        | where EventSchema == 'Dhcp'
            and not(optional)
        | invoke ASIM_ProjectDhcpSchema()
    ;
    let DhcpOptional =
        T
        | where EventSchema == 'Dhcp'
            and (optional)
        | invoke ASIM_ProjectDhcpOptional()
    ;
    union isfuzzy = false
        Authentication
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
      , UserManagement
      , UserManagementOptional
      , Dhcp
      , DhcpOptional
      , NetworkSession
      , NetworkSessionOptional
    | project-away _ItemId*'''
    functionParameters: 'T:(EventSchema:string), optional:bool=true'
    functionAlias: 'ASIM_ProjectSchema'
  }
}
