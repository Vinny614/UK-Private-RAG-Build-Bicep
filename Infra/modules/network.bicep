@description('The name of the Virtual Network')
param namePrefix string

@description('The location for all resources')
param location string

output bastionSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', '${namePrefix}-VNet', 'AzureBastionSubnet')

resource VNet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: '${namePrefix}-VNet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    dhcpOptions: {
      dnsServers: []
    }
    subnets: [
      {
        name: 'JumpboxSubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: jumpboxNSG.id
          }
          natGateway: {
            id: NATGW.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'privatelinkSubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          networkSecurityGroup: {
            id: privateNSG.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.1.0/26'
          networkSecurityGroup: {
            id: bastionNSG.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource bastionNSG 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: '${namePrefix}-bastion-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowGatewayManager'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
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
      }
      {
        name: 'AllowHttpsInBound'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
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
      }
      {
        name: 'AllowSshRdpOutbound'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
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
      }
      {
        name: 'AllowAzureCloudOutbound'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
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
      }
    ]
  }
}

resource jumpboxNSG 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: '${namePrefix}-jumpbox-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDPfmBastion'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '10.0.0.0/16'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource privateNSG 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: '${namePrefix}-private-nsg'
  location: location
  properties: {
    securityRules: []
  }
}

resource NATGW 'Microsoft.Network/natGateways@2024-07-01' = {
  name: '${namePrefix}-nat-jumpbox'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    idleTimeoutInMinutes: 4
    publicIpAddresses: [
      {
        id: publicIPNATGW.id
      }
    ]
  }
}

resource publicIPNATGW 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: '${namePrefix}-nat-public-ip'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}
