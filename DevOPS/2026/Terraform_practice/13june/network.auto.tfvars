vn = {
  vna = {
    name                = "mgmtvnet"
    location            = "rga"
    resource_group_name = "rga"
    address_space       = "10.100.0.0/24"
  }

  vnb = {
    name                = "appvnet"
    location            = "rga"
    resource_group_name = "rga"
    address_space       = "10.100.1.0/24"
  }

}



sbn = {
  sbna = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rga"
    virtual_network_name = "vna"
    address_prefixes     = "10.100.0.0/26"
  }

  sbnb = {
    name                 = "snetfrontend"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.0/26"
  }

  sbnc = {
    name                 = "snetbackend"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.64/26"
  }

  sbnd = {
    name                 = "snetdatabase"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.128/26"
  }
}


peer = {
  peera = {
    name                      = "mgmt-to-app"
    resource_group_name       = "rga"
    virtual_network_name      = "vna"
    remote_virtual_network_id = "vnb"
  }

  peerb = {
    name                      = "app-to-mgmt"
    resource_group_name       = "rga"
    virtual_network_name      = "vnb"
    remote_virtual_network_id = "vna"
  }

}
