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
