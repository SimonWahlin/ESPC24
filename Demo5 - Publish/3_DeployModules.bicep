param env string = 'prod'

module storage1 'br:biceptraining.azurecr.io/bicep/modules/storage:v1' = {
  name: 'storage1'
  params: {
    minimumTlsVersion: 'TLS1_3'
  }
}

module storage2 'br:biceptraining.azurecr.io/bicep/modules/storage:v2' = {
  name: 'storage2'
  params: {
    minimumTlsVersion: 'TLS1_3'
  }
}

module storage3 'br/corp:storage:v1' = {
  name: 'storage3'
  params: {
    minimumTlsVersion: 'TLS1_3'
  }
}

module storage4 'ts:82715c44-513a-4b5f-95d9-d95bad8351d6/experiment-shared-rg/storage:1.0' = {
  name: 'storage4'
  params: {
    minimumTlsVersion: 'TLS1_3'
  }
}

module storage5 'ts/corp:storage:1.0' = if (env == 'prod') {
  name: 'storage5'
  params: {
    minimumTlsVersion: 'TLS1_3'
  }
}
