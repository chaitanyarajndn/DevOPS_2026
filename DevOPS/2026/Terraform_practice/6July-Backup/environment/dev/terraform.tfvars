rg_map = {
  rga = {
    name     = "rg-web"
    location = "central india"
  }
}



vn_map = {
  vna = {
    name                = "vnet-web"
    resource_group_name = "rg-web"
    location            = "central india"
    address_space       = ["10.77.0.0/20"]
  }
}



sbn_map = {
  bastionsbnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.0.0/24"]
  }

  web1sbnet = {
    name                 = "snet-web01"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.1.0/24"]
  }

  web2sbnet = {
    name                 = "snet-web02"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.2.0/24"]
  }
}


nsg_map = {
  webnsg = {
    name                = "nsg-web"
    location            = "central india"
    resource_group_name = "rg-web"
  }

}


nsr_map = {
  nsra = {
    name                        = "AllowSSH"
    priority                    = 100
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-web"
    network_security_group_name = "nsg-web"
  }

  nsrb = {
    name                        = "AllowHTTP"
    priority                    = 110
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-web"
    network_security_group_name = "nsg-web"
  }

}

pip_map = {
  loadbalancerpip = {
    name                = "pip-lb"
    location            = "central india"
    resource_group_name = "rg-web"
    allocation_method   = "Static"
  }

  pipbastion = {
    name                = "pip-bastion"
    resource_group_name = "rg-web"
    location            = "central india"
    allocation_method   = "Static"
  }

}

bast_map = {
  basta = {
    name                = "bas-web"
    location            = "central india"
    resource_group_name = "rg-web"
    ipname              = "defaultip"
  }
}



nic_map = {
  nic_mapa = {
    name                          = "nic-web01"
    location                      = "central india"
    resource_group_name           = "rg-web"
    ipname                        = "default-confweb1"
    subnet_id                     = "snet-web01"
    private_ip_address_allocation = "Dynamic"
  }

  nic_mapb = {
    name                          = "nic-web02"
    location                      = "central india"
    resource_group_name           = "rg-web"
    ipname                        = "default-confweb2"
    subnet_id                     = "snet-web02"
    private_ip_address_allocation = "Dynamic"
  }
}















