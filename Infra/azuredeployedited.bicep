param natGateways_nat_jumpbox_name string = 'nat-jumpbox'
param storageAccounts_saragpriv_name string = 'saragpriv'
param virtualMachines_VM_Jumpbox_name string = 'VM-Jumpbox'
param privateEndpoints_PE_Search_name string = 'PE-Search'
param privateEndpoints_PE_AImulti_name string = 'PE-AImulti'
param privateEndpoints_PE_Foundry_name string = 'PE-Foundry'
param privateEndpoints_PE_Storage_name string = 'PE-Storage'
param searchServices_search_ragpriv_name string = 'search-ragpriv'
param accounts_AI_RAGpriv_name string = 'AI-RAGpriv'
param bastionHosts_Bastion_RAGprivate_name string = 'Bastion-RAGprivate'

param publicIPAddresses_nat_jumpbox_ip_name string = 'nat-jumpbox-ip'
param networkSecurityGroups_NSG_Jumpbox_name string = 'NSG-Jumpbox'
param accounts_AImulti_RAGpriv_name string = 'AImulti-RAGpriv'
param networkInterfaces_vm_jumpbox714_z1_name string = 'vm-jumpbox714_z1'
param publicIPAddresses_vnet_ragprivate_bastion_name string = 'vnet-ragprivate-bastion'
param privateDnsZones_privatelink_openai_azure_com_name string = 'privatelink.openai.azure.com'
param privateDnsZones_privatelink_search_windows_net_name string = 'privatelink.search.windows.net'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'
param privateDnsZones_privatelink_services_ai_azure_com_name string = 'privatelink.services.ai.azure.com'
param privateDnsZones_privatelink_cognitiveservices_azure_com_name string = 'privatelink.cognitiveservices.azure.com'
param systemTopics_saragpriv_75b7636e_baf5_49af_aa32_d7c92f1ea32e_name string = 'saragpriv-75b7636e-baf5-49af-aa32-d7c92f1ea32e'
param networkSecurityGroups_VNet_RAGprivate_privatelinkSubnet_nsg_uksouth_name string = 'VNet-RAGprivate-privatelinkSubnet-nsg-uksouth'
param networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name string = 'VNet-RAGprivate-AzureBastionSubnet-nsg-uksouth'

resource accounts_AImulti_RAGpriv_name_resource 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: accounts_AImulti_RAGpriv_name
  location: 'uksouth'
  sku: {
    name: 'S0'
  }
  kind: 'CognitiveServices'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    apiProperties: {}
    customSubDomainName: 'aimulti-ragpriv'
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    allowProjectManagement: false
    publicNetworkAccess: 'Disabled'
  }
}

resource accounts_AI_RAGpriv_name_resource 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: accounts_AI_RAGpriv_name
  location: 'uksouth'
  sku: {
    name: 'S0'
  }
  kind: 'AIServices'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    apiProperties: {}
    customSubDomainName: 'ai-ragpriv'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    allowProjectManagement: true
    defaultProject: 'PrivRag'
    associatedProjects: [
      'PrivRag'
    ]
    publicNetworkAccess: 'Disabled'
  }
}



resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_cognitiveservices_azure_com_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_cognitiveservices_azure_com_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_openai_azure_com_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_openai_azure_com_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_search_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_search_windows_net_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_privatelink_services_ai_azure_com_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_services_ai_azure_com_name
  location: 'global'
  properties: {}
}



resource searchServices_search_ragpriv_name_resource 'Microsoft.Search/searchServices@2025-05-01' = {
  name: searchServices_search_ragpriv_name
  location: 'UK South'
  tags: {
    ProjectType: 'aoai-your-data-service'
  }
  sku: {
    name: 'standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    replicaCount: 1
    partitionCount: 1
    endpoint: 'https://${searchServices_search_ragpriv_name}.search.windows.net'
    hostingMode: 'Default'
    computeType: 'Default'
    publicNetworkAccess: 'Disabled'
    networkRuleSet: {
      ipRules: []
      bypass: 'AzureServices'
    }
    encryptionWithCmk: {
      enforcement: 'Unspecified'
    }
    disableLocalAuth: true
    dataExfiltrationProtections: []
    semanticSearch: 'free'
    upgradeAvailable: 'notAvailable'
  }
}

resource storageAccounts_saragpriv_name_resource 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccounts_saragpriv_name
  location: 'uksouth'
  tags: {
    ProjectType: 'aoai-your-data-service'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: true
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    largeFileSharesState: 'Enabled'
    networkAcls: {
      resourceAccessRules: [
        {
          tenantId: 'ac171e50-15dd-4b2f-a717-5d05ba421003'
          resourceId: '/subscriptions/789ff1bc-1521-4359-a12e-18eecb82f022/providers/Microsoft.Security/datascanners/StorageDataScanner'
        }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource accounts_AI_RAGpriv_name_Default 'Microsoft.CognitiveServices/accounts/defenderForAISettings@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource accounts_AI_RAGpriv_name_gpt_4_1 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'gpt-4.1'
  sku: {
    name: 'GlobalStandard'
    capacity: 100
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4.1'
      version: '2025-04-14'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 100
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_AI_RAGpriv_name_gpt_4o 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'gpt-4o'
  sku: {
    name: 'Standard'
    capacity: 100
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o'
      version: '2024-11-20'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 100
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_AI_RAGpriv_name_text_embedding_ada_002 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'text-embedding-ada-002'
  sku: {
    name: 'Standard'
    capacity: 120
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-embedding-ada-002'
      version: '2'
    }
    versionUpgradeOption: 'NoAutoUpgrade'
    currentCapacity: 120
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

resource accounts_AImulti_RAGpriv_name_aiforskills_eea4bc85_496c_4a25_854b_15587920446c 'Microsoft.CognitiveServices/accounts/privateEndpointConnections@2025-06-01' = {
  parent: accounts_AImulti_RAGpriv_name_resource
  name: 'aiforskills.eea4bc85-496c-4a25-854b-15587920446c'
  location: 'uksouth'
  properties: {
    privateEndpoint: {}
    groupIds: [
      'account'
    ]
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'for use in skillset'
      actionsRequired: 'None'
    }
  }
}

resource accounts_AImulti_RAGpriv_name_PE_AImulti_766ce7c5_7b4c_49dc_a277_e75cd5eddead 'Microsoft.CognitiveServices/accounts/privateEndpointConnections@2025-06-01' = {
  parent: accounts_AImulti_RAGpriv_name_resource
  name: 'PE-AImulti.766ce7c5-7b4c-49dc-a277-e75cd5eddead'
  location: 'uksouth'
  properties: {
    privateEndpoint: {}
    groupIds: [
      'account'
    ]
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Approved'
      actionsRequired: 'None'
    }
  }
}

resource accounts_AI_RAGpriv_name_PE_Foundry_a3080ee7_91d4_4956_8421_0434a24ba9a6 'Microsoft.CognitiveServices/accounts/privateEndpointConnections@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'PE-Foundry.a3080ee7-91d4-4956-8421-0434a24ba9a6'
  location: 'uksouth'
  properties: {
    privateEndpoint: {}
    groupIds: [
      'account'
    ]
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Approved'
      actionsRequired: 'None'
    }
  }
}

resource accounts_AI_RAGpriv_name_PrivRag 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'PrivRag'
  location: 'uksouth'
  kind: 'AIServices'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    description: 'Default project created with the resource'
    displayName: 'PrivRag'
  }
}

resource accounts_AI_RAGpriv_name_Microsoft_Default 'Microsoft.CognitiveServices/accounts/raiPolicies@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'Microsoft.Default'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
    ]
  }
}

resource accounts_AI_RAGpriv_name_Microsoft_DefaultV2 'Microsoft.CognitiveServices/accounts/raiPolicies@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'Microsoft.DefaultV2'
  properties: {
    mode: 'Blocking'
    contentFilters: [
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Hate'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Sexual'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Violence'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Selfharm'
        severityThreshold: 'Medium'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Jailbreak'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'Protected Material Text'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'Protected Material Code'
        blocking: false
        enabled: true
        source: 'Completion'
      }
    ]
  }
}



resource systemTopics_saragpriv_75b7636e_baf5_49af_aa32_d7c92f1ea32e_name_resource 'Microsoft.EventGrid/systemTopics@2025-04-01-preview' = {
  name: systemTopics_saragpriv_75b7636e_baf5_49af_aa32_d7c92f1ea32e_name
  location: 'uksouth'
  properties: {
    source: storageAccounts_saragpriv_name_resource.id
    topicType: 'microsoft.storage.storageaccounts'
  }
}

resource systemTopics_saragpriv_75b7636e_baf5_49af_aa32_d7c92f1ea32e_name_StorageAntimalwareSubscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2025-04-01-preview' = {
  parent: systemTopics_saragpriv_75b7636e_baf5_49af_aa32_d7c92f1ea32e_name_resource
  name: 'StorageAntimalwareSubscription'
  properties: {
    destination: {
      properties: {
        maxEventsPerBatch: 1
        preferredBatchSizeInKilobytes: 64
        azureActiveDirectoryTenantId: '33e01921-4d64-4f8c-a055-5bdaffd5e33d'
        azureActiveDirectoryApplicationIdOrUri: 'f1f8da5f-609a-401d-85b2-d498116b7265'
      }
      endpointType: 'WebHook'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
        'Microsoft.Storage.BlobRenamed'
      ]
      advancedFilters: [
        {
          values: [
            'BlockBlob'
          ]
          operatorType: 'StringContains'
          key: 'data.blobType'
        }
      ]
    }
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}





resource networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_AllowAzureCloudOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name}/AllowAzureCloudOutbound'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'AzureCloud'
    access: 'Allow'
    priority: 110
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_resource
  ]
}

resource networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_AllowGatewayManager 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name}/AllowGatewayManager'
  properties: {
    description: 'Allow GatewayManager'
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'GatewayManager'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 2702
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_resource
  ]
}

resource networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_AllowHttpsInBound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name}/AllowHttpsInBound'
  properties: {
    description: 'Allow HTTPs'
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'Internet'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 2703
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_resource
  ]
}

resource networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_AllowSshRdpOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
  name: '${networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name}/AllowSshRdpOutbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 100
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '22'
      '3389'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_resource
  ]
}



resource privateDnsZones_privatelink_cognitiveservices_azure_com_name_aimulti_ragpriv 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_cognitiveservices_azure_com_name_resource
  name: 'aimulti-ragpriv'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.2.9'
      }
    ]
  }
}

resource privateDnsZones_privatelink_openai_azure_com_name_ai_ragpriv 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: 'ai-ragpriv'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.2.6'
      }
    ]
  }
}

resource privateDnsZones_privatelink_services_ai_azure_com_name_ai_ragpriv 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_services_ai_azure_com_name_resource
  name: 'ai-ragpriv'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.2.7'
      }
    ]
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_saragpriv 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'saragpriv'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.2.4'
      }
    ]
  }
}

resource privateDnsZones_privatelink_search_windows_net_name_search_ragpriv 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_search_windows_net_name_resource
  name: 'search-ragpriv'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.2.8'
      }
    ]
  }
}

resource privateDnsZones_privatelink_openai_azure_com_name_vm000000 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: 'vm000000'
  properties: {
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.0.1.4'
      }
    ]
  }
}

resource privateDnsZones_privatelink_openai_azure_com_name_vm000001 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: 'vm000001'
  properties: {
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.0.1.5'
      }
    ]
  }
}

resource privateDnsZones_privatelink_openai_azure_com_name_vm_jumpbox 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: 'vm-jumpbox'
  properties: {
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.0.0.4'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_cognitiveservices_azure_com_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_cognitiveservices_azure_com_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_openai_azure_com_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_search_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_search_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_services_ai_azure_com_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_services_ai_azure_com_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource privateEndpoints_PE_Foundry_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-07-01' = {
  name: '${privateEndpoints_PE_Foundry_name}/default'
  properties: {
    privateDnsZoneConfigs: []
  }
  dependsOn: [
    privateEndpoints_PE_Foundry_name_resource
  ]
}



resource storageAccounts_saragpriv_name_default 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_saragpriv_name_default 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_saragpriv_name_storageAccounts_saragpriv_name_36b77a13_a97b_454f_8960_1d2036bd5c3b 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: '${storageAccounts_saragpriv_name}.36b77a13-a97b-454f-8960-1d2036bd5c3b'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_saragpriv_name_storageAccounts_saragpriv_name_561ac9e5_6e70_4395_9cbe_54d6f4c8ff16 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: '${storageAccounts_saragpriv_name}.561ac9e5-6e70-4395-9cbe-54d6f4c8ff16'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      actionRequired: 'None'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_saragpriv_name_default 'Microsoft.Storage/storageAccounts/queueServices@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_saragpriv_name_default 'Microsoft.Storage/storageAccounts/tableServices@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource accounts_AI_RAGpriv_name_saragpriv 'Microsoft.CognitiveServices/accounts/connections@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_resource
  name: 'saragpriv'
  properties: {
    authType: 'AAD'
    category: 'AzureStorageAccount'
    target: 'https://${storageAccounts_saragpriv_name}.blob.core.windows.net/'
    useWorkspaceManagedIdentity: false
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: storageAccounts_saragpriv_name_resource.id
    }
  }
}



resource privateDnsZones_privatelink_search_windows_net_name_2pyzgzdysr4b4 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_search_windows_net_name_resource
  name: '2pyzgzdysr4b4'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNet_RAGprivate_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_cognitiveservices_azure_com_name_aimulti_dns_vnet 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_cognitiveservices_azure_com_name_resource
  name: 'aimulti-dns-vnet'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNet_RAGprivate_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_openai_azure_com_name_aoai_dns_tovnet 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_openai_azure_com_name_resource
  name: 'aoai-dns-tovnet'
  location: 'global'
  properties: {
    registrationEnabled: true
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNet_RAGprivate_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_t56mpuqzeno3g 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 't56mpuqzeno3g'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_VNet_RAGprivate_name_resource.id
    }
  }
}

resource privateEndpoints_PE_AImulti_name_resource 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: privateEndpoints_PE_AImulti_name
  location: 'uksouth'
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_PE_AImulti_name
        id: '${privateEndpoints_PE_AImulti_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_PE_AImulti_name}'
        properties: {
          privateLinkServiceId: accounts_AImulti_RAGpriv_name_resource.id
          groupIds: [
            'account'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${privateEndpoints_PE_AImulti_name}-nic'
    subnet: {
      id: virtualNetworks_VNet_RAGprivate_name_privatelinkSubnet.id
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'aimulti-ragpriv.cognitiveservices.azure.com'
        ipAddresses: [
          '10.0.2.9'
        ]
      }
    ]
  }
}

resource privateEndpoints_PE_Foundry_name_resource 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: privateEndpoints_PE_Foundry_name
  location: 'uksouth'
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_PE_Foundry_name
        id: '${privateEndpoints_PE_Foundry_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_PE_Foundry_name}'
        properties: {
          privateLinkServiceId: accounts_AI_RAGpriv_name_resource.id
          groupIds: [
            'account'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${privateEndpoints_PE_Foundry_name}-nic'
    subnet: {
      id: virtualNetworks_VNet_RAGprivate_name_privatelinkSubnet.id
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'ai-ragpriv.cognitiveservices.azure.com'
        ipAddresses: [
          '10.0.2.5'
        ]
      }
      {
        fqdn: 'ai-ragpriv.openai.azure.com'
        ipAddresses: [
          '10.0.2.6'
        ]
      }
      {
        fqdn: 'ai-ragpriv.services.ai.azure.com'
        ipAddresses: [
          '10.0.2.7'
        ]
      }
    ]
  }
}

resource privateEndpoints_PE_Search_name_resource 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: privateEndpoints_PE_Search_name
  location: 'uksouth'
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${privateEndpoints_PE_Search_name}_0224f372-5caf-4d5c-affb-b9ae69fb36e7'
        id: '${privateEndpoints_PE_Search_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_PE_Search_name}_0224f372-5caf-4d5c-affb-b9ae69fb36e7'
        properties: {
          privateLinkServiceId: searchServices_search_ragpriv_name_resource.id
          groupIds: [
            'searchService'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_VNet_RAGprivate_name_privatelinkSubnet.id
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'search-ragpriv.search.windows.net'
        ipAddresses: [
          '10.0.2.8'
        ]
      }
    ]
  }
}

resource privateEndpoints_PE_Storage_name_resource 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: privateEndpoints_PE_Storage_name
  location: 'uksouth'
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${privateEndpoints_PE_Storage_name}_c4c28869-e797-42d0-aa27-625e18df1019'
        id: '${privateEndpoints_PE_Storage_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_PE_Storage_name}_c4c28869-e797-42d0-aa27-625e18df1019'
        properties: {
          privateLinkServiceId: storageAccounts_saragpriv_name_resource.id
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_VNet_RAGprivate_name_privatelinkSubnet.id
    }
    ipConfigurations: []
    customDnsConfigs: [
      {
        fqdn: 'saragpriv.blob.core.windows.net'
        ipAddresses: [
          '10.0.2.4'
        ]
      }
    ]
  }
}

resource virtualNetworks_VNet_RAGprivate_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_VNet_RAGprivate_name}/AzureBastionSubnet'
  properties: {
    addressPrefix: '10.0.1.0/26'
    networkSecurityGroup: {
      id: networkSecurityGroups_VNet_RAGprivate_AzureBastionSubnet_nsg_uksouth_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNet_RAGprivate_name_resource
  ]
}

resource virtualNetworks_VNet_RAGprivate_name_privatelinkSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_VNet_RAGprivate_name}/privatelinkSubnet'
  properties: {
    addressPrefix: '10.0.2.0/24'
    networkSecurityGroup: {
      id: networkSecurityGroups_VNet_RAGprivate_privatelinkSubnet_nsg_uksouth_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_VNet_RAGprivate_name_resource
  ]
}

resource searchServices_search_ragpriv_name_PE_Search_6500ce12_09b5_4172_aafc_95d8de89b49c 'Microsoft.Search/searchServices/privateEndpointConnections@2025-05-01' = {
  parent: searchServices_search_ragpriv_name_resource
  name: 'PE-Search.6500ce12-09b5-4172-aafc-95d8de89b49c'
  properties: {
    privateEndpoint: {
      id: privateEndpoints_PE_Search_name_resource.id
    }
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-approved'
      actionsRequired: 'None'
    }
    provisioningState: 'Succeeded'
    groupId: 'searchService'
  }
}

resource searchServices_search_ragpriv_name_aiforskills 'Microsoft.Search/searchServices/sharedPrivateLinkResources@2025-05-01' = {
  parent: searchServices_search_ragpriv_name_resource
  name: 'aiforskills'
  properties: {
    privateLinkResourceId: accounts_AImulti_RAGpriv_name_resource.id
    groupId: 'cognitiveservices_account'
    requestMessage: 'for use in skillset'
    status: 'Approved'
    provisioningState: 'Succeeded'
  }
}

resource searchServices_search_ragpriv_name_dataforindex 'Microsoft.Search/searchServices/sharedPrivateLinkResources@2025-05-01' = {
  parent: searchServices_search_ragpriv_name_resource
  name: 'dataforindex'
  properties: {
    privateLinkResourceId: storageAccounts_saragpriv_name_resource.id
    groupId: 'blob'
    requestMessage: 'data in storage to be used in index'
    status: 'Approved'
    provisioningState: 'Succeeded'
  }
}

resource storageAccounts_saragpriv_name_default_hrdata 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: storageAccounts_saragpriv_name_default
  name: 'hrdata'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_saragpriv_name_resource
  ]
}

resource accounts_AI_RAGpriv_name_PrivRag_saragpriv 'Microsoft.CognitiveServices/accounts/projects/connections@2025-06-01' = {
  parent: accounts_AI_RAGpriv_name_PrivRag
  name: 'saragpriv'
  properties: {
    authType: 'AAD'
    category: 'AzureStorageAccount'
    target: 'https://${storageAccounts_saragpriv_name}.blob.core.windows.net/'
    useWorkspaceManagedIdentity: false
    isSharedToAll: true
    sharedUserList: []
    peRequirement: 'NotRequired'
    peStatus: 'NotApplicable'
    metadata: {
      ApiType: 'Azure'
      ResourceId: storageAccounts_saragpriv_name_resource.id
    }
  }
  dependsOn: [
    accounts_AI_RAGpriv_name_resource
  ]
}




