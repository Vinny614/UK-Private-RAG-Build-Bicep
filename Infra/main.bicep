param namePrefix string
param location string = resourceGroup().location

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${namePrefix}-rg'
  location: location
}
