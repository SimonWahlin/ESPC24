using './demo1.bicep'

param name = 'espcdemosa'
param privateNetworking = true
param someConfig = readEnvironmentVariable('myEnvSecret')

param location = 'Sweden Central'
param allowedIpAddresses = [
  '83.226.146.192'
]
param containerNames = [
  'espcdemo'
]

