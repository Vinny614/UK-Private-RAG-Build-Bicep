@description('The name of the Virtual Network')
param namePrefix string

@description('The location for all resources')
param location string

@description('The ID of the Bastion subnet')
param bastionSubnetId string

resource bastion 'Microsoft.Network/bastionHosts@2024-07-01' = {
  name: '${namePrefix}-bastion'
  location: location
  sku: {
    name: 'Premium'
  }
  properties: {
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionIP.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: bastionIP.id
          }
          subnet: {
            id: bastionSubnetId
          }
        }
      }
    ]
  }
}

resource bastionIP 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: '${namePrefix}-bastionIP'
  location: location
  sku: {
    name: 'Standard'
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
