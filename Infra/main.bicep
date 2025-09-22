targetScope = 'subscription'

// Stage 1: Resource Group
@description('The name of the resource group')
param namePrefix string

@description('The location for the resource group')
param location string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${namePrefix}-rg'
  location: location
}

// Stage 2: Network
module network 'modules/network.bicep' = {
  name: 'networkDeployment'
  scope: rg
  params: {
    namePrefix: namePrefix
    location: location
  }
}

// Stage 3: Bastion
module bastion 'modules/bastion.bicep' = {
  name: 'bastionDeployment'
  scope: rg
  params: {
    namePrefix: namePrefix
    location: location
    bastionSubnetId: network.outputs.bastionSubnetId
  }
}
